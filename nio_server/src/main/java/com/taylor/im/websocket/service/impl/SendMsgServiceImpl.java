package com.taylor.im.websocket.service.impl;

import com.alibaba.fastjson.JSON;
import com.taylor.im.context.ChannelManager;
import com.taylor.im.message.BaseMessage;
import com.taylor.im.message.entity.po.MessagePo;
import com.taylor.im.message.service.IMessageService;
import com.taylor.im.service.ISendMsgService;
import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 发送消息实现类
 * </p>
 *
 * @author taylor
 * @date 2020/2/22 18:40
 */
@Service
public class SendMsgServiceImpl implements ISendMsgService {

    private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    private final ChannelManager channelManager;
    private final IMessageService msgService;

    @Autowired
    public SendMsgServiceImpl(ChannelManager channelManager, IMessageService msgService) {
        this.channelManager = channelManager;
        this.msgService = msgService;
    }

    @Override
    public void sendChannel(ChannelHandlerContext ctx, BaseMessage data) {
        ctx.writeAndFlush(getFrame(data));
    }

    @Override
    public void sendToUserDontSave(Long userId, BaseMessage data) {
        // 写入channel
        Channel channel = channelManager.getChannel(userId);
        if (channel != null && channelManager.isOnline(userId)) {
            channel.writeAndFlush(getFrame(data));
            logger.info("已向 【" + userId + "】发送消息");
        } else {
            channelManager.remove(userId);
            logger.info("对方【" + userId + "】不在线");
        }
    }

    @Override
    public void sendToUserAndSave(Long userId, BaseMessage data) {
        String send = JSON.toJSONString(data);
        MessagePo messagePo = new MessagePo();
        messagePo.setUserId(userId);
        messagePo.setData(send);

        // 持久化
        msgService.saveMessage(messagePo);
        data.getHeader().setId(messagePo.getId());
        Channel channel = channelManager.getChannel(userId);
        if (channel != null && channelManager.isOnline(userId)) {
            channel.writeAndFlush(getFrame(data));
            logger.info("已向 【" + userId + "】发送消息");
        } else {
            channelManager.remove(userId);
            logger.info("对方【" + userId + "】不在线");
        }
    }

    @Override
    public void sendToUsersDontSave(List<Long> userIds, BaseMessage data) {
        userIds.forEach(userId -> this.sendToUserDontSave(userId, data));
    }

    @Override
    public void sendToUsersAndSave(List<Long> userIds, BaseMessage data) {
        userIds.forEach(userId -> this.sendToUserAndSave(userId, data));
    }

    @Override
    public void sendChannels(List<Channel> channels, BaseMessage data) {
        String send = JSON.toJSONString(data);
        channels.forEach(channel -> channel.writeAndFlush(send));
    }

    @Override
    public void sendToChannelAndMap(ChannelHandlerContext ctx, BaseMessage data, Long userId) {
        TextWebSocketFrame frame = new TextWebSocketFrame(JSON.toJSONString(data));
        channelManager.mapUserChannel(userId, ctx.channel().id());
        ctx.writeAndFlush(frame);
    }


    //------------------------------------------------------------------
    //        util methods
    //------------------------------------------------------------------


    /**
     * BaseMessage 转为 TextWebSocketFrame
     * +-------------+       +--------------------+
     * | BaseMessage |  -->  | TextWebSocketFrame |
     * +-------------+       +--------------------+
     *
     * @param message message
     * @return frame
     */
    private TextWebSocketFrame getFrame(BaseMessage message) {
        return new TextWebSocketFrame(JSON.toJSONString(message));
    }

}
