package com.taylor.im.strategys.impl;

import com.alibaba.fastjson.JSON;
import com.taylor.im.annotation.HandlerMsg;
import com.taylor.im.message.ChatMessage;
import com.taylor.im.service.ISendMsgService;
import com.taylor.im.strategys.BaseStrategy;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import io.netty.handler.codec.http.websocketx.WebSocketFrame;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 点对点聊天消息策略处理
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 11:10
 */
@Service
@HandlerMsg("CHAT")
public class ChatStrategy implements BaseStrategy {

    private final ISendMsgService sendMsgService;

    @Autowired
    public ChatStrategy(ISendMsgService sendMsgService) {
        this.sendMsgService = sendMsgService;
    }

    @Override
    public void handler(ChannelHandlerContext ctx, WebSocketFrame frame) {
        TextWebSocketFrame msg = (TextWebSocketFrame) frame;
        ChatMessage message = JSON.parseObject(msg.text(), ChatMessage.class);
        Long receiverId = message.getReceiverId();
        // 发送给对方消息，不维护对方在线状态
        sendMsgService.sendToUserAndSave(receiverId, message);
    }
}
