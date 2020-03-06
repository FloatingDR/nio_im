package com.taylor.im.system;

import com.taylor.im.annotation.RequireRole;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * <p>
 * 获取主机或系统信息
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 14:40
 */
@RequireRole("admin")
@RestController
@RequestMapping("/system")
@CrossOrigin
@Api(tags = "获取主机或系统信息-api")
public class SystemController {

    private final Environment env;

    @Autowired
    public SystemController(Environment env) {
        this.env = env;
    }

    /**
     * <p>
     * jdk获取计算机属性
     * </p>
     *
     * @author taylor
     * @date 2020/2/17 14:47
     */
    @GetMapping("/properties")
    @ApiOperation(value = "jdk获取计算机属性", notes = "jdk获取计算机属性")
    public Map<String, String> properties() {
        Properties properties = System.getProperties();
        Map<String, String> map = new HashMap<>(16);
        map.put("Java 运行时环境版本", properties.getProperty("java.version"));
        map.put("Java 运行时环境供应商", properties.getProperty("java.vendor"));
        map.put("Java 安装目录", properties.getProperty("java.home"));
        map.put("Java 虚拟机规范版本", properties.getProperty("java.vm.specification.version"));
        map.put("Java lib路径", properties.getProperty("java.library.path"));
        map.put("操作系统名称", properties.getProperty("os.name"));
        map.put("操作系统架构", properties.getProperty("os.arch"));
        map.put("操作系统版本", properties.getProperty("os.version"));

        return map;
    }

    /**
     * <p>
     * 获取应用程序信息
     * </p>
     *
     * @author taylor
     * @date 2020/2/17 15:37
     */
    @GetMapping("/application")
    @ApiOperation(value = "获取应用程序信息", notes = "获取应用程序信息")
    public Map<String, String> application() {
        Properties properties = System.getProperties();
        Map<String, String> map = new HashMap<>(16);
        map.put("tomcat启动端口", env.getProperty("server.port"));
        map.put("netty默认监听端口", env.getProperty("netty.port"));
        map.put("netty是否随服务自动启动", env.getProperty("netty.auto_start"));
        map.put("nginx端口", env.getProperty("nginx.port"));
        map.put("nginx根目录", env.getProperty("nginx.root_path"));
        map.put("当前程序所在目录", properties.getProperty("user.dir"));
        map.put("应用接口文档", "/v2/api-docs");
        map.put("应用接口测试", "/swagger-ui.html#/");
        return map;
    }

}
