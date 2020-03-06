package com.taylor.im.annotation;

import java.lang.annotation.*;

/**
 * <p>
 * 用于同级角色的多种不同角色
 * 需要的角色权限级逻辑
 * </p>
 *
 * @author taylor
 * @date 2020/3/3 13:42
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface RequireRoles {

    /**
     * 角色列表
     */
    String[] value();

    /**
     * 角色关系（与、或）
     */
    Logical logical() default Logical.AND;

}
