package com.taylor.im.group.controller;


import com.taylor.im.group.entity.bo.CreatBo;
import com.taylor.im.group.entity.dto.GroupDto;
import com.taylor.im.group.service.IGroupService;
import com.taylor.im.response.HttpResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

/**
 * <p>
 * 群组管理 前端控制器
 * </p>
 *
 * @author taylor
 * @since 2020-03-01
 */
@RestController
@RequestMapping("/group")
@CrossOrigin
@Api(tags = "群组管理")
public class GroupController {

    private final IGroupService groupService;

    @Autowired
    public GroupController(IGroupService groupService) {
        this.groupService = groupService;
    }

    @PutMapping("creat_group")
    @ApiOperation(value = "创建群聊", notes = "创建群聊，返回创建的群聊id")
    public HttpResult<GroupDto> creatGroup(@RequestBody @ApiParam("创建群聊实体") CreatBo bo) {
        GroupDto groupDto = groupService.creatGroup(bo);
        return groupDto != null ?
                HttpResult.success(groupDto) :
                HttpResult.error("创建失败");
    }

    @GetMapping("/get_group/{id}")
    @ApiOperation(value = "根据id获取群组信息")
    public HttpResult<GroupDto> getGroupById(@PathVariable @ApiParam("group id") Long id) {
        GroupDto group = groupService.getGroupById(id);
        return group != null ?
                HttpResult.success(group) :
                HttpResult.error("没有该群组");
    }

    @GetMapping("/members/{groupId}")
    @ApiOperation(value = "获取所有群组成员")
    public HttpResult<Set<Long>> members(@PathVariable @ApiParam("group id") Long groupId) {
        return HttpResult.success(groupService.members(groupId));
    }

    @GetMapping("/admins/{groupId}")
    @ApiOperation(value = "获取所有管理员")
    public HttpResult<Set<Long>> admins(@PathVariable @ApiParam("group id") Long groupId) {
        return HttpResult.success(groupService.admins(groupId));
    }


    //------------------------------------------------------------------
    //        TODO 权限设置
    //------------------------------------------------------------------


    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "删除群组")
    public HttpResult<Boolean> delete(@PathVariable @ApiParam("group id") Long id) {
        return HttpResult.success(groupService.delete(id));
    }

    @DeleteMapping("/removeMember/{groupId}/{userId}")
    @ApiOperation(value = "移出群组")
    public HttpResult<Boolean> removeMember(@PathVariable @ApiParam("group id") Long groupId,
                                            @PathVariable @ApiParam("user id") Long userId) {
        return HttpResult.success(groupService.removeMember(groupId, userId));
    }

    @PutMapping("/addMember/{groupId}/{userId}")
    @ApiOperation(value = "加入群组")
    public HttpResult<Boolean> addMember(@PathVariable @ApiParam("group id") Long groupId,
                                         @PathVariable @ApiParam("user id") Long userId) {
        return HttpResult.success(groupService.addMember(groupId, userId));
    }

    @DeleteMapping("/removeAdmin/{groupId}/{userId}")
    @ApiOperation(value = "移出群组管理员")
    public HttpResult<Boolean> removeAdmin(@PathVariable @ApiParam("group id") Long groupId,
                                           @PathVariable @ApiParam("user id") Long userId) {
        return HttpResult.success(groupService.removeAdmin(groupId, userId));
    }

    @PutMapping("/addAdmin/{groupId}/{userId}")
    @ApiOperation(value = "添加群组管理员")
    public HttpResult<Boolean> addAdmin(@PathVariable @ApiParam("group id") Long groupId,
                                        @PathVariable @ApiParam("user id") Long userId) {
        return HttpResult.success(groupService.addAdmin(groupId, userId));
    }

}
