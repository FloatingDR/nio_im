package com.taylor.im.annotation;

import java.lang.annotation.*;

/**
 * <p>
 * 角色权限注解
 * </p>
 *
 * @author taylor
 * @date 2020/3/3 13:29
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface RequireRole {

    /**
     * 需要的角色,默认为系统用户,即需要登录
     */
    String value() default "user";
}
