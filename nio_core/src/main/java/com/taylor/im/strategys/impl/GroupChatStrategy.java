package com.taylor.im.strategys.impl;

import com.taylor.im.annotation.HandlerMsg;
import com.taylor.im.strategys.BaseStrategy;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.WebSocketFrame;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 群聊消息策略类型
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 11:11
 */
@Service
@HandlerMsg("GROUP_CHAT")
public class GroupChatStrategy implements BaseStrategy {
    @Override
    public void handler(ChannelHandlerContext ctx, WebSocketFrame frame) {
        System.out.println("群聊消息策略类型");
    }
}
