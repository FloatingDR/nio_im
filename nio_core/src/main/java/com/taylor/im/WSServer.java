package com.taylor.im;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelFuture;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * netty 服务端
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 11:38
 */
@Service
public class WSServer {

    private final WSServerInitialzer wsServerInitialzer;

    private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    private EventLoopGroup bossGroup;
    private EventLoopGroup workerGroup;

    @Autowired
    public WSServer(WSServerInitialzer wsServerInitialzer) {
        this.wsServerInitialzer = wsServerInitialzer;
    }

    /**
     * netty 启动，监听端口
     *
     * @param port netty监听端口
     */
    public void start(Integer port) {
        bossGroup = new NioEventLoopGroup();
        workerGroup = new NioEventLoopGroup();
        try {
            ServerBootstrap b = new ServerBootstrap();
            b.group(bossGroup, workerGroup)
                    .channel(NioServerSocketChannel.class)
                    .childHandler(wsServerInitialzer);
            ChannelFuture future = b.bind(port).sync();
            logger.info("netty服务启动，正在监听端口 " + port + " ...");
            // 此处非同步启动，否则会阻塞tomcat启动
            future.channel().closeFuture();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * netty 服务关闭
     */
    public void shutdown() {
        bossGroup.shutdownGracefully();
        workerGroup.shutdownGracefully();
        logger.info("netty服务已关闭");
    }

}
