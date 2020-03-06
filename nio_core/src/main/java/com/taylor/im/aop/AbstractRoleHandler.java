package com.taylor.im.aop;

import com.taylor.im.annotation.Logical;
import com.taylor.im.exception.NotPermissionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 角色handler抽象类
 * </p>
 *
 * @author taylor
 * @date 2020/3/3 18:07
 */
public abstract class AbstractRoleHandler {

    private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    /**
     * 默认处理handler，处理单个角色
     */
    public void handler(String role) {
        List<String> roles = getRoles();
        logger.info("该用户拥有的权限是：{}", roles);
        // 如果设置了优先级且满足优先级，直接返回
        if (rolesPriority() != null && isEnoughPriority(role, roles)) {
            return;
        }
        if (!roles.contains(role)) {
            throw new NotPermissionException();
        }
    }

    /**
     * 默认处理handler，处理多个角色
     */
    public void handler(String[] role, Logical logical) {
        List<String> requires = Arrays.asList(role);
        List<String> list = getRoles();
        logger.info("该用户拥有的权限是：{}", list);
        boolean flag = false;
        // 如果是或，只需要匹配一个即可
        if (logical.equals(Logical.OR) && list != null) {
            // 如果设置了优先级且满足优先级，直接返回
            if (rolesPriority() != null && isEnoughPriority(role, list)) {
                return;
            }
            for (String s : list) {
                if (requires.contains(s)) {
                    flag = true;
                    return;
                }
            }
        }
        // 如果是与，必须全部匹配
        else if (logical.equals(Logical.AND) && list != null) {
            for (String s : requires) {
                if (!list.contains(s)) {
                    flag = false;
                    throw new NotPermissionException();
                }
                flag = true;
            }
        }
        if (!flag) {
            throw new NotPermissionException();
        }
    }

    /**
     * 获取Authorization的方式，
     * 默认从Http Header中获取 Authorization 字段，
     * 如需自定义，重写即可
     *
     * @apiNote 其返回值token用于解析出 userId
     */
    protected String doGetAuthorizationInfo() {
        return getAuthorizationInfoFromHeader();
    }

    /**
     * <p>
     * 从http头字段中获取token
     * </p>
     *
     * @return {@link String }
     */
    protected String getAuthorizationInfoFromHeader() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
            return request.getHeader("Authorization");
        }
        return null;
    }

    /**
     * <p>
     * 从session字段中获取token
     * </p>
     *
     * @return {@link String }
     */
    protected String getAuthorizationInfoFromSession() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
            return (String) request.getSession().getAttribute("Authorization");
        }
        return null;
    }

    /**
     * <p>
     * 获取角色，抽象方法,
     *
     * @return {@link List<String> }
     * @apiNote 尽量不要返回null，避免引起空指针
     * </p>
     */
    protected abstract List<String> getRoles();

    /**
     * 角色优先级
     * eg:
     * guest --> 0
     * user  --> 1
     * admin --> 3
     *
     * @return {@link  Map<String,Integer> }
     */
    protected abstract Map<String, Integer> rolesPriority();

    /**
     * 判断是否有足够权限
     *
     * @return boolean
     */
    private boolean isEnoughPriority(String requireRole, List<String> userRole) {
        Map<String, Integer> rolesPriority = rolesPriority();
        Integer requiredPro = rolesPriority.get(requireRole);
        Integer maxUserRolePro = getMaxRole(userRole);
        return requiredPro <= maxUserRolePro;
    }

    /**
     * 判断是否有足够权限
     *
     * @return boolean
     */
    private boolean isEnoughPriority(String[] requireRole, List<String> userRole) {
        List<String> list = Arrays.asList(requireRole);
        Integer requiredPro = getMaxRole(list);
        Integer maxUserRolePro = getMaxRole(userRole);
        return requiredPro <= maxUserRolePro;
    }

    /**
     * 判断 用户角色列表 里面最高的权限等级
     */
    private Integer getMaxRole(List<String> userRole) {
        Map<String, Integer> rolesPriority = rolesPriority();
        Integer maxPro = -1;
        for (String s : userRole) {
            Integer current = rolesPriority.get(s);
            if (current > maxPro) {
                maxPro = current;
            }
        }
        return maxPro;
    }
}
