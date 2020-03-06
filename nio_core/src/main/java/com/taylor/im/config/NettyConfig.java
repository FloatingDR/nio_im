package com.taylor.im.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * <p>
 * netty 的配置信息
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 17:01
 */
@Component
@Data
@ConfigurationProperties(
        prefix = "netty"
)
public class NettyConfig {

    private boolean autoStart;
    private Integer port;
    private Integer readerIdle;
    private Integer writerIdle;
    private Integer allIdle;
    private boolean openHeart;

}
