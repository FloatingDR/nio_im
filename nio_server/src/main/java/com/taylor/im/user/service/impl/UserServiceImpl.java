package com.taylor.im.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.taylor.im.dictionary.service.IDictionaryService;
import com.taylor.im.user.dao.UserDao;
import com.taylor.im.user.entity.bo.UserBo;
import com.taylor.im.user.entity.dto.UserDto;
import com.taylor.im.user.entity.po.LoginPo;
import com.taylor.im.user.entity.po.UserPo;
import com.taylor.im.user.service.ILoginService;
import com.taylor.im.user.service.IUserRoleService;
import com.taylor.im.user.service.IUserService;
import com.taylor.im.util.DateUtil;
import com.taylor.im.util.RandomId;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author taylor
 * @since 2020-02-17
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserDao, UserPo> implements IUserService {

    /**
     * 生肖
     */
    @Value("${dictionary.zodiac}")
    private String ZODIAC;

    /**
     * 星座
     */
    @Value("${dictionary.constellation}")
    private String CONSTELLATION;

    private final ILoginService loginService;
    private final IDictionaryService dictionaryService;
    private final IUserRoleService roleService;


    @Autowired
    public UserServiceImpl(ILoginService loginService, IDictionaryService dictionaryService,
                           IUserRoleService roleService) {
        this.loginService = loginService;
        this.dictionaryService = dictionaryService;
        this.roleService = roleService;
    }

    @Override
    public Long addUser(UserPo user) {
        Long id;
        do {
            id = RandomId.id();
        } while (getById(id) != null);
        user.setUserId(id);
        save(user);
        return id;
    }

    @Override
    public List<UserPo> getByCondition(Wrapper<UserPo> wrapper) {
        return baseMapper.getByCondition(wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeUser(Long id) {
        LoginPo loginPo = new LoginPo();
        loginPo.setUserId(id);
        return loginService.remove(new QueryWrapper<>(loginPo))
                && this.removeById(id)
                && roleService.deleteByUserId(id);
    }


    //------------------------------------------------------------------
    //        util 方法
    //------------------------------------------------------------------


    @Override
    public UserDto po2dto(UserPo userPo) {
        UserDto dto = new UserDto();
        Optional.ofNullable(userPo).ifPresent(po -> {
            BeanUtils.copyProperties(po, dto);
            // 转换性别
            if (po.getGender() != null) {
                String gender = po.getGender() ? "男" : "女";
                dto.setGender(gender);
            }
            // 转换生肖
            if (po.getZodiac() != null) {
                dto.setZodiac(dictionaryService.getByCode(ZODIAC).get(po.getZodiac()));
            }
            // 转换星座
            if (po.getConstellation() != null) {
                dto.setConstellation(dictionaryService.getByCode(CONSTELLATION).get(po.getConstellation()));
            }

        });
        return dto;
    }

    @Override
    public UserPo bo2po(UserBo userBo) {
        UserPo po = new UserPo();
        Optional.ofNullable(userBo).ifPresent(bo -> {
            BeanUtils.copyProperties(bo, po);
            Optional.ofNullable(bo.getBirthday()).ifPresent(day -> {
                LocalDateTime now = LocalDateTime.now();
                int age = bo.getBirthday().toLocalDate().until(now.toLocalDate()).getYears();
                String zodiac = DateUtil.getZodiac(bo.getBirthday());
                String constellation = DateUtil.getConstellation(bo.getBirthday());
                po.setAge(age);
                po.setZodiac(dictionaryService.getByCode_en(ZODIAC).get(zodiac));
                po.setConstellation(dictionaryService.getByCode_en(CONSTELLATION).get(constellation));
            });
        });
        return po;
    }

}
