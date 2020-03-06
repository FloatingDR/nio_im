package com.taylor.im.user.dao;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.taylor.im.user.entity.po.UserRolePo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 * 用户-角色表 Mapper 接口
 * </p>
 *
 * @author taylor
 * @since 2020-03-03
 */
public interface UserRoleDao extends BaseMapper<UserRolePo> {

    /**
     * <p>
     * 根据条件获取用户-角色信息
     * </p>
     *
     * @param wrapper 条件
     * @return {@link UserRolePo}
     * @author taylor
     * @date 2020/3/3 16:37
     */
    @Select("SELECT id,user_id,role FROM user_role ${ew.customSqlSegment}")
    UserRolePo getUserRoleByCondition(@Param(Constants.WRAPPER) Wrapper<UserRolePo> wrapper);

}
