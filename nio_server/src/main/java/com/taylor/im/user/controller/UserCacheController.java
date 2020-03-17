package com.taylor.im.user.controller;

import com.taylor.im.message.entity.po.MessagePo;
import com.taylor.im.message.service.IMessageService;
import com.taylor.im.response.HttpResult;
import com.taylor.im.user.entity.bo.UserChatCache;
import com.taylor.im.user.entity.dto.UnreadListDto;
import com.taylor.im.user.entity.po.UserPo;
import com.taylor.im.user.service.IUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 用户缓存控制类
 * </p>
 *
 * @author taylor
 * @date 2020/3/15 12:30
 */
@RestController
@RequestMapping("/user_cache")
@CrossOrigin
@Slf4j
@Api(tags = "用户缓存")
public class UserCacheController {

    private final RedisTemplate<String, Object> jdkTemplate;
    private final IMessageService messageService;
    private final IUserService userService;

    @Autowired
    public UserCacheController(@Qualifier("JdkTemplate") RedisTemplate<String, Object> jdkTemplate,
                               IMessageService messageService, IUserService userService) {
        this.jdkTemplate = jdkTemplate;
        this.messageService = messageService;
        this.userService = userService;
    }

    @GetMapping("/get_unreadList/{userId}")
    @ApiOperation("用户获取未读消息列表，用于生成未读列表")
    public HttpResult<List<UnreadListDto>> getUnReadList(@PathVariable @ApiParam("用户id") Long userId) {
        List<UnreadListDto> list = getNewUnreadList(userId);
        String key = getCacheKey(userId, 0L, "message_list_cache");
        // 缓存中的列表
        List<UnreadListDto> cache = getListFromCache(key);

        // 处理新旧数据
        for (UnreadListDto item : list) {
            // 如果有缓存,更新count
            processItem(item, cache);
        }
        List<UnreadListDto> sorted = cache.stream()
                .sorted(Comparator.comparing(UnreadListDto::getCount).reversed())
                .distinct()
                .collect(Collectors.toList());

        // 刷入缓存
        jdkTemplate.delete(key);
        for (UnreadListDto item : sorted) {
            jdkTemplate.boundListOps(key).rightPush(item);
        }
        return HttpResult.success(sorted);
    }

    @GetMapping("/get_cache/{userId}/{sendId}/{type}")
    @ApiOperation("获取用户缓存消息")
    public HttpResult<List<UserChatCache>> getCache(@ApiParam("用户id") @PathVariable Long userId, @ApiParam("对方id") @PathVariable Long sendId,
                                                    @ApiParam("消息类型") @PathVariable String type) {
        String key = getCacheKey(userId, sendId, type);
        List<UserChatCache> list = getListFromCache(key);
        return HttpResult.success(list);
    }

    @PostMapping("/cache_msg/{userId}/{sendId}/{type}")
    @ApiOperation("缓存用户消息")
    public HttpResult<Boolean> cacheMsg(@ApiParam("用户id") @PathVariable Long userId, @ApiParam("对方id") @PathVariable Long sendId,
                                        @ApiParam("消息类型") @PathVariable String type, @ApiParam("要缓存的数据") @RequestBody UserChatCache msg) {
        log.info("收到用户{}的缓存请求，缓存数据为{}", userId, msg);
        String key = getCacheKey(userId, sendId, type);
        jdkTemplate.boundListOps(key).rightPush(msg);
        return HttpResult.success(true);
    }

    @DeleteMapping("/delete_cache/{userId}/{sendId}/{type}")
    @ApiOperation("删除用户缓存消息")
    public HttpResult<Boolean> deleteCache(@ApiParam("用户id") @PathVariable Long userId, @ApiParam("对方id") @PathVariable Long sendId,
                                           @ApiParam("消息类型") @PathVariable String type) {
        String key = getCacheKey(userId, sendId, type);
        jdkTemplate.delete(key);
        return HttpResult.success(true);
    }


    //------------------------------------------------------------------
    //        utils
    //------------------------------------------------------------------

    /**
     * 获取新的未读列表
     *
     * @param userId userId
     */
    private List<UnreadListDto> getNewUnreadList(Long userId) {
        // 获取未读消息列表
        List<MessagePo> unreadList = messageService.searchUserUnread(userId);
        // 解析
        List<UnreadListDto> list = new ArrayList<>();
        Map<String, Long> countMap = unreadList.stream()
                .collect(Collectors.groupingBy(messagePo ->
                        messagePo.getSendId() + "_" + messagePo.getType(), Collectors.counting()));
        // 聚合
        countMap.keySet().forEach(key -> {
            String[] s = key.split("_");
            Long i = Long.valueOf(s[0]);
            String t = s[1];
            MessagePo ms = getMax(unreadList, i, t);
            UserPo sender = userService.getById(ms.getSendId());
            UnreadListDto data = UnreadListDto.builder()
                    .count(countMap.get(key))
                    .message(ms.getData())
                    .time(ms.getSendTime())
                    .sendId(ms.getSendId())
                    .build();
            Optional.ofNullable(sender).ifPresent(po -> {
                data.setSendHeaderImg(po.getImgReduce());
                data.setSendHeaderNickname(po.getNickname());
            });
            list.add(data);
        });
        return list;
    }

    /**
     * 获取符合条件的数据中最近的一条数据
     */
    private MessagePo getMax(List<MessagePo> unreadList, Long sendId, String type) {
        List<MessagePo> collect = unreadList.stream()
                .filter(messagePo -> messagePo.getSendId().equals(sendId)
                        && messagePo.getType().equals(type))
                .sorted(Comparator.comparing(MessagePo::getId).reversed())
                .collect(Collectors.toList());
        return collect.get(0);
    }

    /**
     * 生成缓存key
     */
    private String getCacheKey(Long userId, Long sendId, String type) {
        return userId + "_" + sendId + "#" + type;
    }

    /**
     * 处理缓存中的数据
     */
    private void processItem(UnreadListDto dto, List<UnreadListDto> cache) {
        int size = cache.size();
        // 第一次处理
        if (size <= 0) {
            cache.add(dto);
            return;
        }
        boolean anyMatch = cache.stream()
                .anyMatch(u -> u.getSendId().equals(dto.getSendId()));
        for (int i = 0; i < size; i++) {
            // 如果已有，更新count
            if (anyMatch) {
                if (!dto.getTime().equals(cache.get(i).getTime())
                        && dto.getSendId().equals(cache.get(i).getSendId())) {
                    dto.setCount(cache.get(i).getCount() + 1);
                    cache.set(i, dto);
                }
            }
            // 如果没有，插入最后
            else {
                cache.add(dto);
            }
        }
    }

    /**
     * @param key redis key
     * @param <T> 类型
     * @return List<T>
     */
    private <T> List<T> getListFromCache(String key) {
        // 缓存中的列表
        List<T> cache = new ArrayList<>();
        // NOP
        Optional.ofNullable(jdkTemplate.boundListOps(key).size())
                .ifPresent(size -> {
                    for (long i = 0; i < size; i++) {
                        cache.add((T) jdkTemplate.boundListOps(key).index(i));
                    }
                });
        return cache;
    }

}
