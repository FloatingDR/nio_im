package com.taylor.im.strategys.impl;

import com.alibaba.fastjson.JSON;
import com.taylor.im.annotation.HandlerMsg;
import com.taylor.im.config.NettyConfig;
import com.taylor.im.message.HeartMessage;
import com.taylor.im.service.ISendMsgService;
import com.taylor.im.strategys.BaseStrategy;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import io.netty.handler.codec.http.websocketx.WebSocketFrame;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 客户端心跳策略处理
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 11:06
 */
@Service
@HandlerMsg("PING")
public class PingStrategy implements BaseStrategy {

    private final NettyConfig nettyConfig;
    private final ISendMsgService sendMsgService;

    @Autowired
    public PingStrategy(NettyConfig nettyConfig, ISendMsgService sendMsgService) {
        this.nettyConfig = nettyConfig;
        this.sendMsgService = sendMsgService;
    }

    @Override
    public void handler(ChannelHandlerContext ctx, WebSocketFrame frame) {
        TextWebSocketFrame msg = (TextWebSocketFrame) frame;
        HeartMessage message = JSON.parseObject(msg.text(), HeartMessage.class);
        String ping = "PING";
        // 校验成功
        if (nettyConfig.isOpenHeart() && message.verify() && ping.equals(message.getData())) {
            // 回复pang心跳包
            HeartMessage pang = new HeartMessage();
            sendMsgService.sendChannel(ctx, pang);
            // 维护缓存,未测试redis并发量,暂时不做缓存更新
//            sendMsgService.sendToChannelAndMap(ctx, pang, message.getSendId());
        }
    }
}
