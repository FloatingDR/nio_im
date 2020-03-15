package com.taylor.im.websocket.service.impl;

import com.taylor.im.aop.AbstractRoleHandler;
import com.taylor.im.user.entity.po.RolePo;
import com.taylor.im.user.service.IRoleService;
import com.taylor.im.user.service.IUserRoleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;
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

    private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    /**
     * 缓存
     */
    private Map<String, Integer> cache = new ConcurrentHashMap<>();

    /**
     * cache 读写锁,不允许出现多线程写缓存操作
     */
    final private ReadWriteLock readWriteLock = new ReentrantReadWriteLock();

    /**
     * 缓存有效标志
     */
    volatile private boolean cacheValid;

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
        if (!cacheValid) {
            processCacheData();
        }
        return cache;
    }

    @Override
    protected String doGetAuthorizationInfo() {
        // 以默认方式获取 token
        return super.doGetAuthorizationInfo();
    }

    /**
     * 初始化缓存
     *
     * @apiNote 有可能会出现缓存不一致
     * 新增角色后必须调用方法:
     * {@link com.taylor.im.websocket.service.impl.AuthRoleHandler#reCache}
     * 以重新加载缓存
     */
    @PostConstruct
    void processCacheData() {
        readWriteLock.readLock().lock();
        if (!cacheValid) {
            // 如果缓存无效，锁升级，设置缓存
            readWriteLock.readLock().unlock();
            readWriteLock.writeLock().lock();
            try {
                if (!cacheValid) {
                    // 设置缓存
                    setCache();
                    cacheValid = true;
                }
                // 锁降级
                readWriteLock.readLock().lock();
            } finally {
                // 仍然持有读锁
                readWriteLock.writeLock().unlock();
            }
        }
        readWriteLock.readLock().unlock();
        logger.info("系统角色优先级已缓存...");
    }

    /**
     * 设置缓存，写入数据
     */
    private void setCache() {
        Map<String, Integer> collect = roleService.list()
                .stream()
                .collect(Collectors.toMap(RolePo::getRole, RolePo::getPriority));
        cache.putAll(collect);
    }

    /**
     * 读写锁重新加载缓存
     * 新增角色后必须调用此方法
     * 暂无此需求，设为 private
     */
    private void reCache() {
        try {
            readWriteLock.writeLock().lock();
            cache.clear();
            setCache();
        } finally {
            readWriteLock.writeLock().unlock();
        }
    }

}
