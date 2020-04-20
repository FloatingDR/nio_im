package com.taylor.im.group.service;

import com.taylor.im.group.entity.bo.CreatBo;
import com.taylor.im.group.entity.dto.GroupDto;
import com.taylor.im.group.entity.po.GroupPo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Set;

/**
 * <p>
 * 群信息表 服务类
 * </p>
 *
 * @author taylor
 * @since 2020-03-01
 */
public interface IGroupService extends IService<GroupPo> {

    /**
     * <p>
     * 创建群聊，返回新创建的群聊信息
     * </p>
     *
     * @param bo bo
     * @return {@link GroupDto }
     * @author taylor
     * @date 2020/3/1 18:41
     */
    GroupDto creatGroup(CreatBo bo);


    /**
     * <p>
     * 根据id获取群组信息
     * </p>
     *
     * @param groupId groupId
     * @return {@link GroupDto }
     * @author taylor
     * @date 2020/3/1 18:41
     */
    GroupDto getGroupById(Long groupId);

    /**
     * <p>
     * 删除群组
     * </p>
     *
     * @param groupId groupId
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/1 20:28
     */
    boolean delete(Long groupId);

    /**
     * <p>
     * 移出群组
     * </p>
     *
     * @param userId  userId
     * @param groupId groupId
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/1 20:28
     */
    boolean removeMember(Long groupId, Long userId);

    /**
     * <p>
     * 加入群组
     * </p>
     *
     * @param userId  userId
     * @param groupId groupId
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/1 20:28
     */
    boolean addMember(Long groupId, Long userId);

    /**
     * <p>
     * 移出群组管理员
     * </p>
     *
     * @param userId  userId
     * @param groupId groupId
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/1 20:28
     */
    boolean removeAdmin(Long groupId, Long userId);

    /**
     * <p>
     * 添加群组管理员
     * </p>
     *
     * @param userId  userId
     * @param groupId groupId
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/1 20:28
     */
    boolean addAdmin(Long groupId, Long userId);

    /**
     * <p>
     * 获取所有群组成员
     * </p>
     *
     * @param groupId groupId
     * @return {@link Set<Long> }
     * @author taylor
     * @date 2020/3/1 21:43
     */
    Set<Long> members(Long groupId);

    /**
     * <p>
     * 获取所有管理员
     * </p>
     *
     * @param groupId groupId
     * @return {@link Set<Long> }
     * @author taylor
     * @date 2020/3/1 21:43
     */
    Set<Long> admins(Long groupId);

}
