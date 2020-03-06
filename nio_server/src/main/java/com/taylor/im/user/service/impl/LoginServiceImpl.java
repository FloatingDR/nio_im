package com.taylor.im.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.taylor.im.user.dao.LoginDao;
import com.taylor.im.user.entity.bo.EditPswBo;
import com.taylor.im.user.entity.po.LoginPo;
import com.taylor.im.user.entity.qo.LoginQo;
import com.taylor.im.user.service.ILoginService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Optional;

import static com.taylor.im.util.MD5Util.md5;

/**
 * <p>
 * 用户-登录 表 服务实现类
 * </p>
 *
 * @author taylor
 * @since 2020-02-17
 */
@Service
public class LoginServiceImpl extends ServiceImpl<LoginDao, LoginPo> implements ILoginService {

    @Override
    public boolean login(LoginQo qo) {
        LoginPo condition = new LoginPo();
        BeanUtils.copyProperties(qo, condition);
        Optional.of(condition).ifPresent(c ->
                Optional.of(md5(condition.getPassword()))
                        .ifPresent(c::setPassword)
        );
        LoginPo result = this.getOne(new QueryWrapper<>(condition));
        return result != null;
    }

    @Override
    public boolean updatePassword(EditPswBo bo) {
        // 验证原密码是否通过
        LoginPo condition = new LoginPo();
        condition.setUserId(bo.getUserId());
        condition.setPassword(bo.getOldPsw());
        Optional.of(condition).ifPresent(c ->
                Optional.of(md5(condition.getPassword()))
                        .ifPresent(c::setPassword)
        );
        LoginPo result = this.getOne(new QueryWrapper<>(condition));
        // 如果原密码通过
        if (result != null) {
            result.setPassword(md5(bo.getNewPsw()));
            return this.updateById(result);
        }
        return false;
    }

}
