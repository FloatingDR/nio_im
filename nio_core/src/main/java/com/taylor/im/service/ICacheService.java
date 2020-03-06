package com.taylor.im.service;

import io.netty.channel.ChannelId;

/**
 * <p>
 * channel 或 userId 的redis缓存接口
 * </p>
 *
 * @author taylor
 * @date 2020/2/21 16:52
 */
public interface ICacheService {

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
    void mapUserChannel(Long userId, ChannelId channelId);

    /**
     * <p>
     * 删除用户与channel映射
     * </p>
     *
     * @param userId userId
     * @author taylor
     * @date 2020/2/21 17:33
     */
    void remove(Long userId);

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
    boolean isOnline(Long userId);

    /**
     * <p>
     * 获取channelId
     * </p>
     *
     * @param userId userId
     * @return {@link ChannelId }
     * @author taylor
     * @date 2020/2/21 17:49
     */
    ChannelId getChannelId(Long userId);


    /**
     * <p>
     * 删除用户与channel映射
     * </p>
     *
     * @param channelId userId
     * @author taylor
     * @date 2020/2/21 17:33
     */
    void remove(ChannelId channelId);

}
