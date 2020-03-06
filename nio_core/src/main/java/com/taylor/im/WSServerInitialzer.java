package com.taylor.im;

import com.taylor.im.config.NettyConfig;
import io.netty.channel.ChannelHandler.Sharable;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.http.HttpObjectAggregator;
import io.netty.handler.codec.http.HttpServerCodec;
import io.netty.handler.codec.http.websocketx.WebSocketServerProtocolHandler;
import io.netty.handler.logging.LogLevel;
import io.netty.handler.logging.LoggingHandler;
import io.netty.handler.stream.ChunkedWriteHandler;
import io.netty.handler.timeout.IdleStateHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * <p>
 * netty 服务端初始化类
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 11:40
 */
@Service
@Sharable
public class WSServerInitialzer extends ChannelInitializer<SocketChannel> {

    private final NettyConfig nettyConfig;
    private final WSServerHandler wsServerHandler;

    @Autowired
    public WSServerInitialzer(NettyConfig nettyConfig, WSServerHandler wsServerHandler) {
        this.nettyConfig = nettyConfig;
        this.wsServerHandler = wsServerHandler;
    }

    @Override
    protected void initChannel(SocketChannel ch) throws Exception {

        ChannelPipeline pipeline = ch.pipeline();

        // websocket基于http，添加http编解码器
        // websocket只需一次req/res，之后都用socket
        pipeline.addLast(new HttpServerCodec());
        // 对写大数据流的支持
        pipeline.addLast(new ChunkedWriteHandler());
        // 对httpMessage聚合，聚合成FullHttpRequest或FullHttpResponse
        // 几乎在netty中的编码，都会使用到此handler
        pipeline.addLast(new HttpObjectAggregator(1024 * 64));

        // websocket服务器处理的协议，用于指定给客户端连接访问的路由：/ws
        // 本handler会帮你处理一些繁重复杂的事
        // 会帮你处理握手动作：handshaking(close,ping,pong)
        // 对于websocket来讲，都是以frames进行传输的，不同的数据类型对应的frames也不同
        pipeline.addLast(new WebSocketServerProtocolHandler("/websocket"));
        // 日志记录
        pipeline.addLast(new LoggingHandler(LogLevel.INFO));
        /*
         * netty 空闲状态处理器
         * 读空闲 readerIdle
         * 写空闲 writerIdle
         * 读写空闲 allIdle
         * 在本系统中用于心跳检测以维持TCP连接状态，当检测到超时时，做相应处理
         */
        pipeline.addLast(new IdleStateHandler(nettyConfig.getReaderIdle(), nettyConfig.getWriterIdle(),
                nettyConfig.getAllIdle(), TimeUnit.SECONDS));

        // 自定义handler
        pipeline.addLast(wsServerHandler);
    }

}
