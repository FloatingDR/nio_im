package com.taylor.im;

import com.alibaba.fastjson.JSON;
import com.taylor.im.config.NettyConfig;
import com.taylor.im.context.ChannelManager;
import com.taylor.im.context.MsgContextHandler;
import com.taylor.im.message.BaseMessage;
import com.taylor.im.strategys.BaseStrategy;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.ChannelHandler.Sharable;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.channel.group.ChannelGroup;
import io.netty.handler.codec.http.*;
import io.netty.handler.codec.http.websocketx.*;
import io.netty.handler.timeout.IdleStateEvent;
import io.netty.util.CharsetUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用于处理消息的handler
 * TextWebSocketFrame：在netty中，是用于为websocket专门处理文本的对象，frame是消息的载体
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 11:41
 */
@Service
@Sharable
public class WSServerHandler extends SimpleChannelInboundHandler<Object> {

    private final NettyConfig nettyConfig;
    private final MsgContextHandler msgContextHandler;
    private WebSocketServerHandshaker handshake;

    private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    private static ChannelGroup channelPool = ChannelManager.channelPool;

    @Autowired
    public WSServerHandler(MsgContextHandler msgContextHandler, NettyConfig nettyConfig) {
        this.msgContextHandler = msgContextHandler;
        this.nettyConfig = nettyConfig;
    }

    /**
     * 消息处理，自定义协议
     */
    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Object msg)
            throws Exception {
        // 传统HTTP接入，第一次握手请求消息由Http协议承载
        if (msg instanceof FullHttpRequest) {
            handleHttpRequest(ctx, (FullHttpRequest) msg);
        }
        // websocket接入
        else if (msg instanceof WebSocketFrame) {
            handleWebSocketFrame(ctx, (WebSocketFrame) msg);
        }
    }

    /**
     * <p>
     * websocket消息处理
     * </p>
     *
     * @param ctx   ctx
     * @param frame websocket frame
     * @author taylor
     * @date 2020/2/22 11:18
     */
    private void handleWebSocketFrame(ChannelHandlerContext ctx, WebSocketFrame frame) {
        // 判断是否是关闭链路的指令
        if (frame instanceof CloseWebSocketFrame) {
            handshake.close(ctx.channel(), ((CloseWebSocketFrame) frame).retain());
            return;
        }
        // 判断是否是Ping信号
        if (frame instanceof PingWebSocketFrame) {
            ctx.channel().write(new PongWebSocketFrame(frame.content().retain()));
            return;
        }
        // 判断是否是二进制消息
        if (frame instanceof BinaryWebSocketFrame) {
            return;
        }
        // 如果是普通文本消息
        if (frame instanceof TextWebSocketFrame) {
            TextWebSocketFrame msg = (TextWebSocketFrame) frame;
            BaseMessage baseMessage = JSON.parseObject(msg.text(), BaseMessage.class);
            String msgType = baseMessage.getHeader().getMsgType().type();
            // 策略处理客户端消息
            BaseStrategy strategy = msgContextHandler.getStrategy(msgType);
            strategy.handler(ctx, frame);
        }
    }


    /**
     * <p>
     * http消息处理
     * </p>
     *
     * @param ctx ctx
     * @param req req
     * @author taylor
     * @date 2020/2/22 11:42
     */
    private void handleHttpRequest(ChannelHandlerContext ctx, FullHttpRequest req) {
        // 如果Http解码失败，返回http异常
        if (!req.decoderResult().isSuccess()
                || (!"websocket".equals(req.headers().get("Upgrade")))) {
            sendHttpResponse(ctx, req, new DefaultFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.BAD_REQUEST));
            return;
        }
        // 构造握手响应返回，本机测试
        WebSocketServerHandshakerFactory wsFactory = new WebSocketServerHandshakerFactory("ws://localhost:8081/websocket", null, false);
        handshake = wsFactory.newHandshaker(req);
        if (handshake == null) {
            WebSocketServerHandshakerFactory.sendUnsupportedVersionResponse(ctx.channel());
        } else {
            handshake.handshake(ctx.channel(), req);
        }
    }

    /**
     * <p>
     * 发送http响应
     * </p>
     *
     * @param ctx ctx
     * @param req req
     * @param res res
     * @author taylor
     * @date 2020/2/22 11:43
     */
    private void sendHttpResponse(ChannelHandlerContext ctx, FullHttpRequest req, FullHttpResponse res) {
        // 返回应答给客户端
        if (res.status().code() != HttpStatus.OK.value()) {
            ByteBuf buf = Unpooled.copiedBuffer(res.status().toString(), CharsetUtil.UTF_8);
            res.content().writeBytes(buf);
            buf.release();
            HttpUtil.setContentLength(res, res.content().readableBytes());
        }
        // 如果是非Keep-Alive，关闭连接
        ChannelFuture f = ctx.channel().writeAndFlush(res);
        if (!HttpUtil.isKeepAlive(req) || res.status().code() != HttpStatus.OK.value()) {
            f.addListener(ChannelFutureListener.CLOSE);
        }
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        super.exceptionCaught(ctx, cause);
        logger.info("客户端：" + ctx.channel().id().asLongText() + "异常关闭");
        ctx.close();
    }

    @Override
    public void handlerAdded(ChannelHandlerContext ctx) throws Exception {
        logger.info("客户端加入连接：" + ctx.channel().id().asLongText());
        channelPool.add(ctx.channel());
    }

    @Override
    public void handlerRemoved(ChannelHandlerContext ctx) throws Exception {
        // 当触发handlerRemoved，ChannelGroup会自动移除对应客户端的channel
        channelPool.remove(ctx.channel());
        logger.info("客户端断开连接：长id为 " + ctx.channel().id().asLongText());
    }

    @Override
    public void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception {
        if (nettyConfig.isOpenHeart() && evt instanceof IdleStateEvent) {
            IdleStateEvent event = (IdleStateEvent) evt;
            String eventType = null;
            switch (event.state()) {
                case READER_IDLE:
                    eventType = "读空闲";
                    break;
                case WRITER_IDLE:
                    eventType = "写空闲";
                    break;
                case ALL_IDLE:
                    eventType = "读写空闲";
                    break;
                default:
                    eventType = null;
            }
            logger.info(ctx.channel().remoteAddress() + " 超时事件: " + eventType);
            // 超时断开连接
            ctx.channel().close();
        }
    }

}
