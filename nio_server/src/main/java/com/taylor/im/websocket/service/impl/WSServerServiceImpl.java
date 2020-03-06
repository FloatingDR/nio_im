package com.taylor.im.websocket.service.impl;

import com.taylor.im.bootstrap.WSServerBootStrap;
import com.taylor.im.websocket.service.WSServerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * websocket 服务接口实现类
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 13:14
 */
@Service
public class WSServerServiceImpl implements WSServerService {

    final private WSServerBootStrap serverBootStrap;

    @Autowired
    public WSServerServiceImpl(WSServerBootStrap serverBootStrap) {
        this.serverBootStrap = serverBootStrap;
    }

    @Override
    public void start() {
        serverBootStrap.start();
    }

    @Override
    public void restart() {
        serverBootStrap.shutdown();
        serverBootStrap.start();
    }

    @Override
    public void shutdown() {
        serverBootStrap.shutdown();
    }
}
