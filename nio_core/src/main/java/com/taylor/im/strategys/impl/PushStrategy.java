package com.taylor.im.strategys.impl;

import com.alibaba.fastjson.JSON;
import com.taylor.im.annotation.HandlerMsg;
import com.taylor.im.message.PushMessage;
import com.taylor.im.service.ISendMsgService;
import com.taylor.im.strategys.BaseStrategy;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import io.netty.handler.codec.http.websocketx.WebSocketFrame;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
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

    private final ISendMsgService sendMsgService;
    private final RedisTemplate<String, Object> jdkTemplate;

    @Autowired
    public PushStrategy(ISendMsgService sendMsgService,
                        @Qualifier("JdkTemplate") RedisTemplate<String, Object> jdkTemplate) {
        this.sendMsgService = sendMsgService;
        this.jdkTemplate = jdkTemplate;
    }

    @Override
    public void handler(ChannelHandlerContext ctx, WebSocketFrame frame) {
        TextWebSocketFrame msg = (TextWebSocketFrame) frame;
        PushMessage message = JSON.parseObject(msg.text(), PushMessage.class);
        Long receiverId = message.getReceiverId();
        // 推送给目标用户消息，不维护对方在线状态
        sendMsgService.sendToUserDontSave(receiverId, message);
        String redisKey = getKey(message.getSendId(), message.getReceiverId(), "PUSH");
        jdkTemplate.boundSetOps(redisKey).add(message);
    }

    private String getKey(Long userId, Long receiveId, String type) {
        return userId + receiveId + "#" + type;
    }
}
