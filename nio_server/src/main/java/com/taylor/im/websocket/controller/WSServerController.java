package com.taylor.im.websocket.controller;

import com.taylor.im.annotation.RequireRole;
import com.taylor.im.websocket.service.WSServerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * websocket 服务 controller
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 13:12
 */
@RequireRole("admin")
@RestController
@RequestMapping("/server")
@CrossOrigin
@Api(tags = "websocket 服务")
public class WSServerController {

    final private WSServerService wsServerService;

    @Autowired
    public WSServerController(WSServerService wsServerService) {
        this.wsServerService = wsServerService;
    }

    /**
     * 启动netty服务
     */
    @GetMapping("/start")
    @ApiOperation(value = "启动netty服务", notes = "启动netty服务,监听默认端口")
    public void start() {
        wsServerService.start();
    }

    /**
     * 重启netty服务
     */
    @GetMapping("/restart")
    @ApiOperation(value = "重启netty服务", notes = "重启netty服务,监听默认端口,端口在此期间又可能被占用而无法重启")
    public void restart() {
        wsServerService.restart();
    }

    /**
     * 关闭netty服务
     */
    @GetMapping("/shutdown")
    @ApiOperation(value = "关闭netty服务", notes = "关闭netty服务,若已关闭,可能会抛出空指针异常")
    public void shutdown() {
        wsServerService.shutdown();
    }

}
