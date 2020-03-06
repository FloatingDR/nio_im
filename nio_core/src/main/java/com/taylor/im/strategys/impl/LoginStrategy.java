package com.taylor.im.strategys.impl;

import com.alibaba.fastjson.JSON;
import com.taylor.im.annotation.HandlerMsg;
import com.taylor.im.message.LoginMessage;
import com.taylor.im.service.IMsgService;
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
@HandlerMsg("LOGIN")
public class LoginStrategy implements BaseStrategy {

    private final ISendMsgService sendMsgService;
    private final IMsgService msgService;

    @Autowired
    public LoginStrategy(ISendMsgService sendMsgService, IMsgService msgService) {
        this.sendMsgService = sendMsgService;
        this.msgService = msgService;
    }

    @Override
    public void handler(ChannelHandlerContext ctx, WebSocketFrame frame) {
        TextWebSocketFrame msg = (TextWebSocketFrame) frame;
        LoginMessage message = JSON.parseObject(msg.text(), LoginMessage.class);
        Long sendId = message.getSendId();
        LoginMessage loginMessage = new LoginMessage();
        // 登录时就将未读消息推送给客户端
        loginMessage.setData(msgService.searchUserUnread(sendId));
        sendMsgService.sendToChannelAndMap(ctx, loginMessage, sendId);
    }
}
