package com.taylor.im.websocket.service.impl;

import com.taylor.im.service.ICacheService;
import io.netty.channel.ChannelId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * <p>
 * channel 或 userId 的redis缓存接口实现类
 * </p>
 *
 * @author taylor
 * @date 2020/2/21 17:24
 */
@Service
public class CacheServiceImpl implements ICacheService {

    /**
     * userId-channelId 缓存前缀
     */
    private final String PRE_UC = "USER_CHANNEL#";

    private final RedisTemplate<String, Object> jdkTemplate;

    @Autowired
    public CacheServiceImpl(@Qualifier("JdkTemplate") RedisTemplate<String, Object> redisTemplate) {
        this.jdkTemplate = redisTemplate;
    }


    @Override
    public void mapUserChannel(Long userId, ChannelId channelId) {
        jdkTemplate.boundValueOps(PRE_UC + userId).set(channelId);
    }

    @Override
    public void remove(Long userId) {
        jdkTemplate.delete(PRE_UC + userId);
    }

    @Override
    public boolean isOnline(Long userId) {
        return jdkTemplate.boundValueOps(PRE_UC + userId).get() != null;
    }

    @Override
    public ChannelId getChannelId(Long userId) {
        return (ChannelId) jdkTemplate.boundValueOps(PRE_UC + userId).get();
    }

    @Override
    public void remove(ChannelId channelId) {
        Optional.ofNullable(jdkTemplate.keys(PRE_UC + "*")).ifPresent(keys -> keys.forEach(key -> {
            if (jdkTemplate.boundValueOps(key).get() == channelId) {
                jdkTemplate.delete(key);
            }
        }));
    }


}
