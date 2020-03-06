package com.taylor.im.annotation;

import java.lang.annotation.*;

/**
 * <p>
 * 注解，用于标注如何处理该种消息类型（策略类型）
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 10:59
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface HandlerMsg {

    /**
     * 策略类型
     */
    String value();
}
