package com.taylor.im.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.taylor.im.user.entity.bo.EditPswBo;
import com.taylor.im.user.entity.po.LoginPo;
import com.taylor.im.user.entity.qo.LoginQo;

/**
 * <p>
 * 用户-登录 表 服务类
 * </p>
 *
 * @author taylor
 * @since 2020-02-17
 */
public interface ILoginService extends IService<LoginPo> {

    /**
     * <p>
     * 用户登录
     * </p>
     *
     * @param qo qo
     * @return {@link boolean }
     * @author taylor
     * @date 2020/2/18 14:32
     */
    boolean login(LoginQo qo);

    /**
     * <p>
     * 更改密码
     * </p>
     *
     * @param bo bo
     * @return {@link boolean }
     * @author taylor
     * @date 2020/2/19 11:57
     */
    boolean updatePassword(EditPswBo bo);
}
