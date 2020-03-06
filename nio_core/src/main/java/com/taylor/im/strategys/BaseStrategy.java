package com.taylor.im.strategys;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.WebSocketFrame;

/**
 * <p>
 * 消息处理策略接口
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 11:03
 */
public interface BaseStrategy {

    /**
     * <p>
     * 策略处理
     * </p>
     *
     * @param ctx ChannelHandlerContext
     * @param frame websocket frame
     * @author taylor
     * @date 2020/2/18 11:07
     */
    void handler(ChannelHandlerContext ctx, WebSocketFrame frame);
}
