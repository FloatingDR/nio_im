package com.taylor.im.message.controller;


import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.taylor.im.message.entity.po.MessagePo;
import com.taylor.im.message.service.IMessageService;
import com.taylor.im.response.HttpResult;
import com.taylor.im.user.entity.dto.UnreadListDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * <p>
 * 消息表 前端控制器
 * </p>
 *
 * @author taylor
 * @since 2020-02-23
 */
@RestController
@RequestMapping("/message")
@CrossOrigin
@Api(tags = "消息-api")
public class MessageController {

    private final IMessageService messageService;
    private final RedisTemplate<String, Object> jdkTemplate;

    @Autowired
    public MessageController(IMessageService messageService, @Qualifier("JdkTemplate") RedisTemplate<String, Object> jdkTemplate) {
        this.messageService = messageService;
        this.jdkTemplate = jdkTemplate;
    }


    /**
     * <p>
     * 查找用户的未读消息
     * </p>
     *
     * @param userId userId
     * @return {@link HttpResult<List<MessagePo>> }
     * @author taylor
     * @date 2020/2/23 15:32
     */
    @GetMapping("search_message_unread/{userId}")
    @ApiOperation(value = "查找用户的未读消息", notes = "查找用户的未读消息")
    public HttpResult<List<MessagePo>> searchUserUnread(@PathVariable @ApiParam("用户id") Long userId) {
        return HttpResult.success(messageService.searchUserUnread(userId));
    }

    /**
     * <p>
     * 标记id为已读消息
     * </p>
     *
     * @param id id
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/2/23 15:07
     */
    @PutMapping("read/{id}")
    @ApiOperation(value = "标记id为已读消息", notes = "标记id为已读消息")
    public HttpResult<Boolean> readById(@PathVariable @ApiParam("消息id") Long id) {
        MessagePo messagePo = MessagePo.builder()
                .id(id)
                .signed(true)
                .build();
        return messageService.updateById(messagePo) ?
                HttpResult.success(true, "已读") :
                HttpResult.error("未读");
    }

    /**
     * <p>
     * 标记ids为已读消息
     * </p>
     *
     * @param ids ids
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/2/23 15:07
     */
    @PutMapping("read_batch")
    @ApiOperation(value = "标记ids为已读消息", notes = "标记ids为已读消息")
    public HttpResult<Boolean> readBatch(@ApiParam("消息ids") @RequestBody List<Long> ids) {
        List<MessagePo> messagePos = ids.stream()
                .map(id -> MessagePo.builder()
                        .id(id)
                        .signed(true)
                        .build()
                ).collect(Collectors.toList());
        return HttpResult.success(messageService.updateBatchById(messagePos), "已读");
    }

    /**
     * <p>
     * 标记userId/sendId/type的消息已读
     * </p>
     *
     * @param sendId userId
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/2/23 15:07
     */
    @PutMapping("read_batch_by_sendIdAndType/{userId}/{sendId}/{type}")
    @ApiOperation(value = "标记userId/type的消息已读", notes = "标记userId/type的消息已读")
    @Transactional(rollbackFor = Exception.class)
    public HttpResult<Boolean> readByUserId(@PathVariable @ApiParam("消息属于者（接受者）id") Long userId, @PathVariable @ApiParam("发送者id") Long sendId, @PathVariable @ApiParam("消息类型") String type) {

        String key = getCacheKey(userId, 0L, "message_list_cache");
        // 缓存中的列表
        List<UnreadListDto> cache = new ArrayList<>();
        // NOP
        Optional.ofNullable(jdkTemplate.boundListOps(key).size())
                .ifPresent(size -> {
                    for (long i = 0; i < size; i++) {
                        cache.add((UnreadListDto) jdkTemplate.boundListOps(key).index(i));
                    }
                });
        cache.stream().distinct().forEach(item -> {
            if (item.getSendId().equals(sendId)) {
                item.setCount(0L);
            }
        });
        // 刷入缓存
        jdkTemplate.delete(key);
        for (UnreadListDto item : cache) {
            jdkTemplate.boundListOps(key).rightPush(item);
        }

        MessagePo messagePo = MessagePo.builder()
                .signed(true)
                .build();
        LambdaUpdateWrapper<MessagePo> condition = new UpdateWrapper<MessagePo>()
                .lambda()
                .eq(MessagePo::getUserId, userId)
                .eq(MessagePo::getSendId, sendId)
                .eq(MessagePo::getType, type);
        return HttpResult.success(messageService.update(messagePo, condition), "已读");
    }

    /**
     * 生成缓存key
     */
    private String getCacheKey(Long userId, Long sendId, String type) {
        return userId + "_" + sendId + "#" + type;
    }
}
