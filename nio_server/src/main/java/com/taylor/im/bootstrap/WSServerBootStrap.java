package com.taylor.im.bootstrap;

import com.taylor.im.WSServer;
import com.taylor.im.config.NettyConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

/**
 * <p>
 * netty 启动类
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 11:36
 */
@Component
public class WSServerBootStrap implements ApplicationListener<ContextRefreshedEvent> {

    private final NettyConfig nettyConfig;
    final private WSServer wsServer;

    @Autowired
    public WSServerBootStrap(NettyConfig nettyConfig, WSServer wsServer) {
        this.nettyConfig = nettyConfig;
        this.wsServer = wsServer;
    }


    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        // web项目中会有2个context，一个是root,一个是projectName-servlet context（作为root application context的子容器）
        // 这种情况下，就会造成onApplicationEvent方法被执行两次
        // root application context 没有parent
        if (event.getApplicationContext().getParent() == null && nettyConfig.isAutoStart()) {
            wsServer.start(nettyConfig.getPort());
        }
    }

    /**
     * 启动netty服务，监听默认端口
     */
    public void start() {
        this.wsServer.start(nettyConfig.getPort());
    }

    /**
     * 关闭netty服务
     */
    public void shutdown() {
        this.wsServer.shutdown();
    }

}
