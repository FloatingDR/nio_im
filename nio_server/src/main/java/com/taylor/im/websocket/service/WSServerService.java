package com.taylor.im.websocket.service;

/**
 * <p>
 * websocket 服务接口
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 13:14
 */
public interface WSServerService {

    /**
     * 启动netty服务
     */
    void start();

    /**
     * 重启netty服务
     */
    void restart();

    /**
     * 关闭netty服务
     */
    void shutdown();

}
