package com.taylor.im.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.taylor.im.user.entity.po.UserRolePo;
import com.taylor.im.user.dao.UserRoleDao;
import com.taylor.im.user.service.IUserRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * 用户-角色表 服务实现类
 * </p>
 *
 * @author taylor
 * @since 2020-03-03
 */
@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleDao, UserRolePo> implements IUserRoleService {

    @Override
    public List<String> getUserRolesById(Long userId) {
        UserRolePo userRolePo = getByUserId(userId);
        if (userRolePo != null) {
            String[] role = userRolePo.getRole().split(",");
            return Arrays.asList(role);
        }
        return null;
    }

    @Override
    public boolean addRole(Long userId, String role) {
        UserRolePo userRolePo = getByUserId(userId);
        String roles = userRolePo.getRole();
        roles = roles.endsWith(",") ? roles + role : roles + "," + role;
        userRolePo.setRole(roles);
        return updateById(userRolePo);
    }

    @Override
    public boolean removeRole(Long userId, String role) {
        UserRolePo userRolePo = getByUserId(userId);
        StringBuilder sb = new StringBuilder();
        String[] array = userRolePo.getRole().split(",");
        for (int i = 0; i < array.length; i++) {
            if (array[i].equals(role)) {
                continue;
            }
            if (i > 0) {
                sb.append(",");
            }
            sb.append(array[i]);
        }
        userRolePo.setRole(sb.toString());
        return updateById(userRolePo);
    }

    @Override
    public boolean deleteByUserId(Long userId) {
        UserRolePo userRolePo = getByUserId(userId);
        if (userRolePo != null) {
            return removeById(userRolePo.getId());
        }
        return true;
    }

    //------------------------------------------------------------------
    //        util methods
    //------------------------------------------------------------------


    /**
     * <p>
     * 根据用户id获取 Role持久化对象
     * </p>
     *
     * @param userId userId
     * @return {@link UserRolePo }
     * @author taylor
     * @date 2020/3/3 17:19
     */
    UserRolePo getByUserId(Long userId) {
        LambdaQueryWrapper<UserRolePo> condition = new QueryWrapper<UserRolePo>()
                .lambda()
                .eq(UserRolePo::getUserId, userId);
        return this.baseMapper.getUserRoleByCondition(condition);
    }
}
