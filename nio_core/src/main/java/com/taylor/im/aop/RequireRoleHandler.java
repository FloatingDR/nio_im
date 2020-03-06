package com.taylor.im.aop;

import com.taylor.im.annotation.Logical;
import com.taylor.im.annotation.RequireRole;
import com.taylor.im.annotation.RequireRoles;
import com.taylor.im.exception.NotPermissionException;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.lang.reflect.Method;
import java.util.Arrays;

/**
 * <p>
 * 权限切面类
 * </p>
 *
 * @author taylor
 * @date 2020/3/3 12:47
 */
@Aspect
@Component
public class RequireRoleHandler {

    private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    private final AbstractRoleHandler roleHandler;

    /**
     * 处理注解在方法上的注解
     */
    @Autowired
    public RequireRoleHandler(AbstractRoleHandler roleHandler) {
        this.roleHandler = roleHandler;
    }

    @Pointcut("@annotation(com.taylor.im.annotation.RequireRole) || @annotation(com.taylor.im.annotation.RequireRoles) || " +
            "@within(com.taylor.im.annotation.RequireRole) || @within(com.taylor.im.annotation.RequireRoles)")
    private void permissionCheck() {
    }

    @Around("permissionCheck()")
    public Object interceptor(ProceedingJoinPoint pjp) throws Throwable {
        // 日志记录
        Signature signature = pjp.getSignature();
        Class<?> targetClass = pjp.getTarget().getClass();
        String className = targetClass.getSimpleName();
        String methodName = signature.getName();
        logger.info("className:{},methodName:{}", className, methodName);
        // 角色校验
        MethodSignature methodSignature = (MethodSignature) signature;
        Method targetMethod = methodSignature.getMethod();
        // 如果是 RequireRole
        if (targetMethod.isAnnotationPresent(RequireRole.class) ||
                targetClass.isAnnotationPresent(RequireRole.class)) {
            // 获取方法上注解中的权限
            RequireRole methodAnnotation = targetMethod.getAnnotation(RequireRole.class);
            RequireRole classAnnotation = targetClass.getAnnotation(RequireRole.class);
            RequireRole annotation = methodAnnotation != null ? methodAnnotation : classAnnotation;
            String role = annotation.value();
            logger.info("需要的用户角色为role:{}", role);
            if (!StringUtils.isEmpty(role)) {
                roleHandler.handler(role);
                return pjp.proceed();
            }
        }
        // 如果是 RequireRoles
        else if (targetMethod.isAnnotationPresent(RequireRoles.class) ||
                targetClass.isAnnotationPresent(RequireRoles.class)) {
            // 获取方法上注解中的权限
            RequireRoles methodAnnotation = targetMethod.getAnnotation(RequireRoles.class);
            RequireRoles classAnnotation = targetClass.getAnnotation(RequireRoles.class);
            RequireRoles annotation = methodAnnotation != null ? methodAnnotation : classAnnotation;
            String[] roles = annotation.value();
            logger.info("需要的用户角色为role:{}", Arrays.toString(roles));
            Logical logical = annotation.logical();
            if (roles.length > 0) {
                roleHandler.handler(roles, logical);
                return pjp.proceed();
            }
        }
        throw new NotPermissionException();
    }

}
