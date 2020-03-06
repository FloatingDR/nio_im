package com.taylor.im.websocket.service.impl;

import com.taylor.im.aop.AbstractRoleHandler;
import com.taylor.im.user.entity.po.RolePo;
import com.taylor.im.user.service.IRoleService;
import com.taylor.im.user.service.IUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * <p>
 * 角色handler抽象类实现方法
 * </p>
 *
 * @author taylor
 * @date 2020/3/3 20:36
 */
@Service
public class AuthRoleHandler extends AbstractRoleHandler {

    /**
     * 缓存
     */
    private static Map<String, Integer> cache = new ConcurrentHashMap<>();

    private final IUserRoleService userRoleService;
    private final IRoleService roleService;

    @Autowired
    public AuthRoleHandler(IUserRoleService userRoleService, IRoleService roleService) {
        this.userRoleService = userRoleService;
        this.roleService = roleService;
    }

    @Override
    protected List<String> getRoles() {
        String token = doGetAuthorizationInfo();
        if (token != null) {
            Long userId = Long.valueOf(token);
            List<String> list = userRoleService.getUserRolesById(userId);
            if (list != null) {
                return list;
            }
        }
        return new ArrayList<>();
    }

    @Override
    protected Map<String, Integer> rolesPriority() {
        return cache;
    }

    @Override
    protected String doGetAuthorizationInfo() {
        // 以默认方式获取 token
        return super.doGetAuthorizationInfo();
    }

    /**
     * 设置缓存
     */
    @PostConstruct
    private void setCache() {
        Map<String, Integer> collect = roleService.list()
                .stream()
                .collect(Collectors.toMap(RolePo::getRole, RolePo::getPriority));
        cache.putAll(collect);
    }

}
