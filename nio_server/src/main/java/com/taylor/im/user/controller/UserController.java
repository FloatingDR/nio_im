package com.taylor.im.user.controller;

import com.taylor.im.response.HttpResult;
import com.taylor.im.user.entity.bo.EditBo;
import com.taylor.im.user.entity.bo.EditPswBo;
import com.taylor.im.user.entity.bo.RegisterBo;
import com.taylor.im.user.entity.bo.UserBo;
import com.taylor.im.user.entity.dto.UserDto;
import com.taylor.im.user.entity.po.LoginPo;
import com.taylor.im.user.entity.po.UserRolePo;
import com.taylor.im.user.entity.po.UserPo;
import com.taylor.im.user.entity.qo.LoginQo;
import com.taylor.im.user.service.ILoginService;
import com.taylor.im.user.service.IUserRoleService;
import com.taylor.im.user.service.IUserService;
import com.taylor.im.util.MD5Util;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

/**
 * <p>
 * 用户相关 前端控制器
 * </p>
 *
 * @author taylor
 * @since 2020-02-17
 */
@RestController
@RequestMapping("/user")
@CrossOrigin
@Api(tags = "用户相关")
public class UserController {


    /**
     * 本类缓存前缀
     */
    final private String CACHE_PRE = "com.taylor.im.user.controller.UserController#user";


    private final IUserService userService;
    private final ILoginService loginService;
    private final IUserRoleService roleService;

    @Autowired
    public UserController(IUserService userService, ILoginService loginService, IUserRoleService roleService) {
        this.userService = userService;
        this.loginService = loginService;
        this.roleService = roleService;
    }

    //------------------------------------------------------------------
    //        业务
    //------------------------------------------------------------------

    /**
     * <p>
     * 用户注册
     * </p>
     *
     * @author taylor
     * @date 2020/2/19 11:40
     */
    @PostMapping("register")
    @Transactional(rollbackFor = Exception.class)
    @ApiOperation("用户注册")
    @CacheEvict(value = CACHE_PRE, key = "#result.data")
    public HttpResult<Long> register(@RequestBody @ApiParam("账号密码") RegisterBo bo) {
        // 1.插入用户基础信息，返回账号
        UserBo userBo = new UserBo();
        BeanUtils.copyProperties(bo, userBo);
        UserPo userPo = userService.bo2po(userBo);
        BeanUtils.copyProperties(userBo, userPo);
        Long id = userService.addUser(userPo);
        // 2.给账号设置密码
        LoginPo loginPo = new LoginPo();
        loginPo.setUserId(id);
        loginPo.setPassword(MD5Util.md5(bo.getPassword()));
        loginService.save(loginPo);
        // 添加用户角色，默认为 user
        UserRolePo userRolePo = new UserRolePo();
        userRolePo.setUserId(id);
        roleService.save(userRolePo);
        return HttpResult.success(id, "注册成功");
    }

    /**
     * <p>
     * 登录
     * </p>
     *
     * @author taylor
     * @date 2020/2/19 11:40
     */
    @PostMapping("login")
    @ApiOperation("登录")
    public HttpResult<UserDto> login(@RequestBody @ApiParam("账号密码") LoginQo qo) {
        if (loginService.login(qo)) {
            UserPo po = userService.getById(qo.getUserId());
            return HttpResult.success(userService.po2dto(po), "登录成功");
        }
        return HttpResult.error("账号或密码不正确，请重试");
    }


    /**
     * <p>
     * 根据id查询用户信息,如果有缓存的话从缓存中取
     * </p>
     *
     * @author taylor
     * @date 2020/2/19 11:41
     */
    @GetMapping("getById/{id}")
    @ApiOperation("根据id查询用户信息")
    @Cacheable(value = CACHE_PRE, key = "#p0")
    public HttpResult<UserDto> getById(@PathVariable @ApiParam("用户id") Long id) {
        UserPo po = userService.getById(id);
        return po != null ?
                HttpResult.success(userService.po2dto(po)) :
                HttpResult.error("用户不存在");
    }

    /**
     * <p>
     * 根据id注销用户,删除缓存
     * </p>
     *
     * @author taylor
     * @date 2020/2/19 11:41
     */
    @DeleteMapping("delete/{id}")
    @ApiOperation("根据id注销用户")
    @CacheEvict(value = CACHE_PRE, key = "#p0", beforeInvocation = true)
    public HttpResult<Boolean> deleteById(@PathVariable @ApiParam("用户id") Long id) {
        return userService.removeUser(id) ?
                HttpResult.success(true, "注销成功") :
                HttpResult.error("注销失败");
    }


    /**
     * <p>
     * 更新用户信息,缓存失效
     * </p>
     *
     * @param bo bo
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/2/19 12:12
     */
    @PutMapping("update/{id}")
    @ApiOperation("更新用户信息")
    @CacheEvict(value = CACHE_PRE, key = "#p0", beforeInvocation = true)
    public HttpResult<UserDto> updateUserInfo(@PathVariable @ApiParam("用户id") Long id,
                                              @RequestBody @ApiParam("用户更新信息") EditBo bo) {
        UserBo userBo = new UserBo();
        // 如果性别不为空，转换并更改性别
        Optional.ofNullable(bo.getGender()).ifPresent(g -> userBo.setGender("男".equals(g)));
        BeanUtils.copyProperties(bo, userBo);
        UserPo po = userService.bo2po(userBo);
        po.setUserId(id);
        userService.updateById(po);
        UserDto cache = userService.po2dto(userService.getById(id));
        return HttpResult.success(cache, "更改成功");
    }


    /**
     * <p>
     * 更新用户密码
     * </p>
     *
     * @param bo bo
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/2/19 13:18
     */
    @PutMapping("update_password")
    @ApiOperation("更新用户密码")
    public HttpResult<Boolean> updatePaw(@RequestBody @ApiParam("用户更新信息") EditPswBo bo) {
        if (bo.getNewPsw().equals(bo.getOldPsw())) {
            return HttpResult.error("新密码与原密码相同，无法更改");
        }
        return loginService.updatePassword(bo) ?
                HttpResult.success(true, "更改成功") :
                HttpResult.error("更改失败");
    }

    /**
     * <p>
     * 添加用户权限
     * </p>
     *
     * @param userId usrId
     * @param role   role
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/3/3 17:27
     */
    @PutMapping("addRole/{userId}/{role}")
    @ApiOperation("添加用户权限")
    public HttpResult<Boolean> addRole(@ApiParam("用户id") @PathVariable Long userId,
                                       @ApiParam("要添加的角色") @PathVariable String role) {
        return roleService.addRole(userId, role) ?
                HttpResult.success(true, "添加成功") :
                HttpResult.error("添加失败");
    }

    /**
     * <p>
     * 移除用户权限
     * </p>
     *
     * @param userId usrId
     * @param role   role
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/3/3 17:27
     */
    @PutMapping("removeRole/{userId}/{role}")
    @ApiOperation("移除用户权限")
    public HttpResult<Boolean> removeRole(@ApiParam("用户id") @PathVariable Long userId,
                                          @ApiParam("要移除的角色") @PathVariable String role) {
        return roleService.removeRole(userId, role) ?
                HttpResult.success(true, "移除成功") :
                HttpResult.error("移除失败");
    }

}
