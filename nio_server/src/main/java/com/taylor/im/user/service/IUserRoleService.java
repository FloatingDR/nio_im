package com.taylor.im.user.service;

import com.taylor.im.user.entity.po.UserRolePo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 用户-角色表 服务类
 * </p>
 *
 * @author taylor
 * @since 2020-03-03
 */
public interface IUserRoleService extends IService<UserRolePo> {

    /**
     * <p>
     * 根据userId获取用户角色列表
     * </p>
     *
     * @param userId userId
     * @return {@link List<String> }
     * @author taylor
     * @date 2020/3/3 16:32
     */
    List<String> getUserRolesById(Long userId);

    /**
     * <p>
     * 添加用户权限
     * </p>
     *
     * @param userId userId
     * @param role   role
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/3 16:50
     */
    boolean addRole(Long userId, String role);

    /**
     * <p>
     * 移除用户权限
     * </p>
     *
     * @param userId userId
     * @param role   role
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/3 16:50
     */
    boolean removeRole(Long userId, String role);

    /**
     * <p>
     * 移除用户
     * </p>
     *
     * @param userId userId
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/3 16:50
     */
    boolean deleteByUserId(Long userId);
}
