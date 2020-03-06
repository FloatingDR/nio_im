package com.taylor.im.context;

import com.taylor.im.service.ICacheService;
import io.netty.channel.Channel;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelId;
import io.netty.channel.group.ChannelGroup;
import io.netty.channel.group.DefaultChannelGroup;
import io.netty.util.concurrent.GlobalEventExecutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * <p>
 * Channel 管理器
 * </p>
 *
 * @author taylor
 * @date 2020/2/21 16:47
 */
@Service
@ChannelHandler.Sharable
public class ChannelManager {

    public static ChannelGroup channelPool = new DefaultChannelGroup(GlobalEventExecutor.INSTANCE);

    private final ICacheService cacheService;

    @Autowired
    public ChannelManager(ICacheService cacheService) {
        this.cacheService = cacheService;
    }

    /**
     * <p>
     * 将用户与channel映射
     * userID -> channelId（LongId）
     * </p>
     *
     * @param userId    用户id
     * @param channelId channelId
     * @author taylor
     * @date 2020/2/21 17:25
     */
    public void mapUserChannel(Long userId, ChannelId channelId) {
        cacheService.mapUserChannel(userId, channelId);
    }

    /**
     * <p>
     * 删除用户与channel映射
     * </p>
     *
     * @param userId userId
     * @author taylor
     * @date 2020/2/21 17:33
     */
    public void remove(Long userId) {
        cacheService.remove(userId);
    }

    /**
     * <p>
     * 删除用户与channel映射
     * </p>
     *
     * @param channelId channelId
     * @author taylor
     * @date 2020/2/21 17:33
     */
    public void remove(ChannelId channelId) {
        cacheService.remove(channelId);
    }

    /**
     * <p>
     * 判断用户是否在线
     * </p>
     *
     * @param userId usrId
     * @return {@link boolean }
     * @author taylor
     * @date 2020/2/21 17:34
     */
    public boolean isOnline(Long userId) {
        AtomicBoolean flag = new AtomicBoolean(false);
        ChannelId channelId = cacheService.getChannelId(userId);
        Optional.ofNullable(channelId)
                .flatMap(id -> Optional.ofNullable(channelPool.find(channelId)))
                .ifPresent(ch -> flag.set(cacheService.isOnline(userId) && ch.isOpen()));
        return flag.get();
    }

    /**
     * <p>
     * 根据userId获取channel
     * 不保证一定能找到,需要进行判空
     * </p>
     *
     * @param userId userId
     * @return {@link Channel }
     * @author taylor
     * @date 2020/2/21 17:49
     */
    public Channel getChannel(Long userId) {
        ChannelId channelId = cacheService.getChannelId(userId);
        return channelId != null ? channelPool.find(channelId) : null;
    }

    /**
     * <p>
     * 根据channelId获取channel
     * </p>
     *
     * @param channelId userId
     * @return {@link Channel }
     * @author taylor
     * @date 2020/2/21 17:49
     */
    public Channel getChannel(ChannelId channelId) {
        return channelId != null ? channelPool.find(channelId) : null;
    }


}
