package com.taylor.im.user.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.taylor.im.user.entity.bo.UserBo;
import com.taylor.im.user.entity.dto.UserDto;
import com.taylor.im.user.entity.po.UserPo;

import java.util.List;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author taylor
 * @since 2020-02-17
 */
public interface IUserService extends IService<UserPo> {

    /**
     * 添加用户
     *
     * @param po 用户信息
     * @return 账号id
     */
    Long addUser(UserPo po);

    /**
     * <p>
     * 获取符合条件的集合
     * </p>
     *
     * @param wrapper where条件
     * @return {@link List<UserPo> }
     * @author taylor
     * @date 2020/2/19 17:55
     */
    List<UserPo> getByCondition(Wrapper<UserPo> wrapper);

    /**
     * <p>
     * 注销用户
     * </p>
     *
     * @param id id
     * @return {@link boolean }
     * @author taylor
     * @date 2020/2/20 16:12
     */
    boolean removeUser(Long id);

    //------------------------------------------------------------------
    //        util 方法
    //------------------------------------------------------------------


    /**
     * <p>
     * po 转换为 dto
     * 转换星座
     * 转换生肖
     * 转换性别
     * </p>
     * +--------+       +---------+
     * | UserPo |  -->  | UserDto |
     * +--------+       +---------+
     *
     * @param po po
     * @return dto
     */
     UserDto po2dto(UserPo po);

    /**
     * <p>
     * 业务对象转为持久化对象
     * 如果生日修改，修改星座和生肖、年龄
     * </p>
     * +--------+       +--------+
     * | UserBo |  -->  | UserPo |
     * +--------+       +--------+
     *
     * @param bo 业务对象
     * @return {@link UserPo }
     * @author taylor
     * @date 2020/2/18 20:21
     */
    public UserPo bo2po(UserBo bo);
}
