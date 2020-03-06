package com.taylor.im;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * <p>
 * 项目启动类
 * </p>
 *
 * @author taylor
 * @date 2020/2/17 11:26
 */
@SpringBootApplication(scanBasePackages = "com.taylor.im.**")
@EnableTransactionManagement
@MapperScan("com.taylor.im.**.dao")
@EnableConfigurationProperties
@EnableCaching
@EnableAspectJAutoProxy(proxyTargetClass = true)
public class NioImApplication {

    public static void main(String[] args) {
        SpringApplication.run(NioImApplication.class, args);
    }

}
