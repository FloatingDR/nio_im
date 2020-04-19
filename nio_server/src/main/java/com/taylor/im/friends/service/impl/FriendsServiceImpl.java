package com.taylor.im.friends.service.impl;

import com.taylor.im.friends.service.IFriendsService;
import com.taylor.im.user.entity.dto.UserDto;
import com.taylor.im.user.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * friends service impl
 * </p>
 *
 * @author taylor
 * @date 2020/3/28 10:56
 */
@Service
public class FriendsServiceImpl implements IFriendsService {

    private final String friendsPre = "com.taylor.im.friends#";

    private final RedisTemplate<String, Object> jdkTemplate;
    private final IUserService userService;

    @Autowired
    public FriendsServiceImpl(@Qualifier("JdkTemplate") RedisTemplate<String, Object> jdkTemplate,
                              IUserService userService) {
        this.jdkTemplate = jdkTemplate;
        this.userService = userService;
    }

    @Override
    public boolean addFriends(Long userId1, Long userId2) {
        jdkTemplate.boundSetOps(friendsPre + userId1).add(userId2);
        jdkTemplate.boundSetOps(friendsPre + userId2).add(userId1);
        return true;
    }

    @Override
    public boolean removeFriends(Long userId1, Long userId2) {
        jdkTemplate.boundSetOps(friendsPre + userId1).remove(userId2);
        jdkTemplate.boundSetOps(friendsPre + userId2).remove(userId1);
        return false;
    }

    @Override
    public List<UserDto> listMyFriends(Long userId) {
        Set<Long> ids = members(friendsPre + userId);
        return transToDto(ids);
    }

    @Override
    public List<UserDto> listCommonFriends(Long userId1, Long userId2) {
        Set<Long> common = Objects.requireNonNull(jdkTemplate.opsForSet()
                .intersect(friendsPre + userId1, friendsPre + userId2)
        )
                .stream()
                .map(id -> (Long) id)
                .collect(Collectors.toSet());
        return transToDto(common);
    }


    //------------------------------------------------------------------
    //        utils methods
    //------------------------------------------------------------------


    /**
     * ids 转化为 UserDto
     *
     * @param ids id列表
     */
    private List<UserDto> transToDto(Collection<? extends Serializable> ids) {
        if (ids == null || ids.isEmpty()) {
            return null;
        }
        return userService.listByIds(ids).stream()
                .map(userService::po2dto)
                .collect(Collectors.toList());
    }

    /**
     * 转换
     *
     * @param key key
     */
    public Set<Long> members(String key) {
        return getRedisSet(key);
    }

    /**
     * <p>
     * 从redis中获取对应的set
     * </p>
     *
     * @param key redis key
     * @return {@link Set<T> }
     * @author taylor
     * @date 2020/3/1 21:52
     */
    private <T> Set<T> getRedisSet(String key) {
        Set<Object> members = jdkTemplate.boundSetOps(key).members();
        if (members != null) {
            return members.stream()
                    .map(id -> (T) id)
                    .collect(Collectors.toSet());
        }
        return null;
    }

}
