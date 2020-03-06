package com.taylor.im.strategys.impl;

import com.taylor.im.annotation.HandlerMsg;
import com.taylor.im.strategys.BaseStrategy;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.WebSocketFrame;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 订阅号消息/推送消息策略
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 11:26
 */
@Service
@HandlerMsg("PUSH")
public class PushStrategy implements BaseStrategy {
    @Override
    public void handler(ChannelHandlerContext ctx, WebSocketFrame frame) {
        System.out.println("订阅号消息/推送消息策略");
    }
}
