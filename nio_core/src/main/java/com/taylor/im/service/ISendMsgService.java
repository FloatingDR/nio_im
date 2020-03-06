package com.taylor.im.service;

import com.taylor.im.message.BaseMessage;
import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerContext;

import java.util.List;

/**
 * <p>
 * 发送消息服务接口
 * </p>
 *
 * @author taylor
 * @date 2020/2/22 18:51
 */
public interface ISendMsgService {

    /**
     * <p>
     * 给单一通道发送消息
     * </p>
     *
     * @param ctx  ctx
     * @param data message
     * @author taylor
     * @date 2020/2/22 18:43
     */
    void sendChannel(ChannelHandlerContext ctx, BaseMessage data);

    /**
     * <p>
     * 发送消息给对方
     * 不做持久化
     * </p>
     *
     * @param userId userId
     * @param data   data
     * @author taylor
     * @date 2020/2/22 18:46
     */
    void sendToUserDontSave(Long userId, BaseMessage data);


    /**
     * <p>
     * 发送消息给对方
     * 并持久化，返回 messageId
     * </p>
     *
     * @param userId userId
     * @param data   data
     * @author taylor
     * @date 2020/2/23 11:43
     */
    void sendToUserAndSave(Long userId, BaseMessage data);

    /**
     * <p>
     * 给多用户发送消息
     * 不做持久化
     * </p>
     *
     * @param userIds userIds
     * @param data    data
     * @author taylor
     * @date 2020/2/22 18:54
     */
    void sendToUsersDontSave(List<Long> userIds, BaseMessage data);

    /**
     * <p>
     * 给多用户发送消息
     * 并做持久化
     * </p>
     *
     * @param userIds userIds
     * @param data    data
     * @author taylor
     * @date 2020/2/23 11:45
     */
    void sendToUsersAndSave(List<Long> userIds, BaseMessage data);

    /**
     * <p>
     * 给多通道发送消息
     * </p>
     *
     * @param channels 通道
     * @param data     data
     * @author taylor
     * @date 2020/2/22 18:56
     */
    void sendChannels(List<Channel> channels, BaseMessage data);

    /**
     * <p>
     * 给通道发送消息并且将该通道与指定userId缓存
     * </p>
     *
     * @param ctx    ctx
     * @param data   data
     * @param userId userId
     * @author taylor
     * @date 2020/2/22 19:25
     */
    void sendToChannelAndMap(ChannelHandlerContext ctx, BaseMessage data, Long userId);

}
