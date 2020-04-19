package com.taylor.im.user.dao;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.taylor.im.user.entity.po.UserPo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 用户表 Mapper 接口
 * </p>
 *
 * @author taylor
 * @since 2020-02-17
 */
public interface UserDao extends BaseMapper<UserPo> {

    /**
     * user表中所有字段
     */
    String COLUMNS = "user_id,username,nickname,birthday,age,gender,identity_id,telephone,signature," +
            "profession,company,address,hometown,constellation,zodiac,create_time,modify_time";

    /**
     * <p>
     * 获取符合条件的集合（仅包含部分字段）
     * </p>
     *
     * @param wrapper where条件
     * @return {@link List <UserPo> }
     * @author taylor
     * @date 2020/2/19 17:55
     */
    @Select("SELECT " + COLUMNS + " FROM user ${ew.customSqlSegment}")
    List<UserPo> getByCondition(@Param(Constants.WRAPPER) Wrapper<UserPo> wrapper);
}
