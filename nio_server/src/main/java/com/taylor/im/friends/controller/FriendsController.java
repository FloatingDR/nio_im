package com.taylor.im.friends.controller;

import com.taylor.im.friends.service.IFriendsService;
import com.taylor.im.response.HttpResult;
import com.taylor.im.user.entity.dto.UserDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * Friends controller
 * </p>
 *
 * @author taylor
 * @date 2020/3/28 10:57
 */
@RestController
@RequestMapping("/friends")
@CrossOrigin
@Api(tags = "好友")
public class FriendsController {

    private final IFriendsService friendsService;

    @Autowired
    public FriendsController(IFriendsService friendsService) {
        this.friendsService = friendsService;
    }

    @PostMapping("/add_friends/{id1}/{id2}")
    @ApiOperation(value = "添加朋友")
    public HttpResult<Boolean> addFriends(@PathVariable @ApiParam("用户id")Long id1,@PathVariable @ApiParam("用户id")Long id2){
        return HttpResult.success(friendsService.addFriends(id1,id2));
    }

    @DeleteMapping("/remove_friends/{id1}/{id2}")
    @ApiOperation(value = "移除朋友关系")
    public HttpResult<Boolean> removeFriends(@PathVariable @ApiParam("用户id")Long id1,@PathVariable @ApiParam("用户id")Long id2){
        return HttpResult.success(friendsService.removeFriends(id1,id2));
    }

    @GetMapping("/listMyFriends/{userId}")
    @ApiOperation(value = "获取我的所有好友")
    public HttpResult<List<UserDto>> listMyFriends(@PathVariable @ApiParam("用户id")Long userId){
        return HttpResult.success(friendsService.listMyFriends(userId));
    }

    @GetMapping("/listCommonFriends/{id1}/{id2}")
    @ApiOperation(value = "获取两个用户的公共好友")
    public HttpResult<List<UserDto>> listCommonFriends(@PathVariable @ApiParam("用户id")Long id1,@PathVariable @ApiParam("用户id")Long id2){
        return HttpResult.success(friendsService.listCommonFriends(id1,id2));
    }

}
