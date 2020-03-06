package com.taylor.im.group.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.taylor.im.group.dao.GroupDao;
import com.taylor.im.group.entity.bo.CreatBo;
import com.taylor.im.group.entity.dto.GroupDto;
import com.taylor.im.group.entity.po.GroupPo;
import com.taylor.im.group.service.IGroupService;
import com.taylor.im.user.entity.dto.UserDto;
import com.taylor.im.user.entity.po.UserPo;
import com.taylor.im.user.service.IUserService;
import com.taylor.im.util.RandomId;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;

/**
 * <p>
 * 群信息表 服务实现类
 * </p>
 *
 * @author taylor
 * @since 2020-03-01
 */
@Service
public class GroupServiceImpl extends ServiceImpl<GroupDao, GroupPo> implements IGroupService {

    private final RedisTemplate<String, Object> jdkTemplate;
    private final IUserService userService;

    @Autowired
    public GroupServiceImpl(@Qualifier("JdkTemplate") RedisTemplate<String, Object> jdkTemplate,
                            IUserService userService) {
        this.jdkTemplate = jdkTemplate;
        this.userService = userService;
    }

    private final String group_member_pre = "com.taylor.im.group.member#";
    private final String group_admin_pre = "com.taylor.im.group.admin#";

    @Override
    public GroupDto creatGroup(CreatBo bo) {
        // 1.添加群聊信息
        GroupPo po = new GroupPo();
        BeanUtils.copyProperties(bo, po);
        // 2.生成群聊id,保证唯一性
        Long id;
        do {
            id = RandomId.id();
            po.setId(id);
        } while (this.getById(id) != null);
        // 3.mysql持久化群聊信息
        save(po);
        // 4.Redis持久化群聊信息
        if (bo.getMember().isEmpty()) {
            Set<Long> set = new HashSet<>();
            set.add(bo.getGroupOwner());
            bo.setMember(set);
        }
        bo.getMember().add(bo.getGroupOwner());
        final Long groupId = id;
        // 添加群成员
        bo.getMember().forEach(userId ->
                jdkTemplate.boundSetOps(group_member_pre + groupId).add(userId)
        );
        // 添加管理员信息，创建群聊时只有群主为管理员，之后才可以添加其他成员
        jdkTemplate.boundSetOps(group_admin_pre + id).add(bo.getGroupOwner());

        // 5.返回群聊信息
        return po2dto(po);
    }

    @Override
    public GroupDto getGroupById(Long groupId) {
        GroupPo po = this.getById(groupId);
        if (po == null) {
            return null;
        }
        return po2dto(po);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean delete(Long groupId) {
        this.removeById(groupId);
        jdkTemplate.delete(group_admin_pre + groupId);
        jdkTemplate.delete(group_member_pre + groupId);
        return true;
    }

    @Override
    public boolean removeMember(Long groupId, Long userId) {
        // 任何人无法移除群主，除非群主退群并删除该群
        Optional.ofNullable(this.getById(groupId)).ifPresent(po -> {
            if (!po.getGroupOwner().equals(userId)) {
                jdkTemplate.boundSetOps(group_member_pre + groupId).remove(userId);
            }
        });
        return true;
    }

    @Override
    public boolean addMember(Long groupId, Long userId) {
        jdkTemplate.boundSetOps(group_member_pre + groupId).add(userId);
        return true;
    }

    @Override
    public boolean removeAdmin(Long groupId, Long userId) {
        // 群主必须是管理员
        String key = group_admin_pre + groupId;
        Optional.ofNullable(this.getById(groupId)).ifPresent(po -> {
            // 如果要删除的管理员不是群主
            if (!po.getGroupOwner().equals(userId)) {
                jdkTemplate.boundSetOps(key).remove(userId);
            }
        });
        return true;
    }

    @Override
    public boolean addAdmin(Long groupId, Long userId) {
        jdkTemplate.boundSetOps(group_admin_pre + groupId).add(userId);
        return true;
    }

    @Override
    public Set<Long> members(Long groupId) {
        String key = group_member_pre + groupId;
        return getRedisSet(key);
    }

    @Override
    public Set<Long> admins(Long groupId) {
        String key = group_admin_pre + groupId;
        return getRedisSet(key);
    }


    //------------------------------------------------------------------
    //        util methods
    //------------------------------------------------------------------


    /**
     * <p>
     * 持久化类转化为传输实体
     * </p>
     *
     * @param groupPo po
     * @return {@link GroupDto }
     * @author taylor
     * @date 2020/3/1 19:03
     */
    private GroupDto po2dto(GroupPo groupPo) {
        GroupDto dto = new GroupDto();
        Optional.ofNullable(groupPo).ifPresent(po -> {
            BeanUtils.copyProperties(po, dto);
            Long groupId = po.getId();
            // 群成员和管理员转换
            Set<UserDto> members = new HashSet<>();
            copySet(group_member_pre + groupId, members);
            dto.setMember(members);
            Set<UserDto> admins = new HashSet<>();
            copySet(group_admin_pre + groupId, admins);
            dto.setAdministrator(admins);
        });
        return dto;
    }

    /**
     * <p>
     * 从redis中获取对应的set
     * </p>
     *
     * @param key redis key
     * @return {@link Set<T> }
     * @author taylor
     * @date 2020/3/1 21:52
     */
    private <T> Set<T> getRedisSet(String key) {
        Set<Object> members = jdkTemplate.boundSetOps(key).members();
        if (members != null) {
            return members.stream()
                    .map(id -> (T) id)
                    .collect(Collectors.toSet());
        }
        return null;
    }

    /**
     * <p>
     * 从redis中拷贝set
     * </p>
     *
     * @param key    redis key
     * @param target 拷贝目标set
     * @author taylor
     * @date 2020/3/1 19:40
     */
    private void copySet(String key, Set<UserDto> target) {
        Optional.ofNullable(jdkTemplate.boundSetOps(key).members())
                .ifPresent(ids ->
                        ids.forEach(id -> {
                            Long i = (Long) id;
                            UserPo userPo = userService.getById(i);
                            Optional.ofNullable(userPo).ifPresent(po
                                    -> target.add(userService.po2dto(po))
                            );
                        })
                );
    }

    /**
     * <p>
     * 查找是否含有对应的值
     * </p>
     *
     * @param key   redis key
     * @param value 要查找的值
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/1 21:35
     */
    private boolean containValue(String key, Long value) {
        AtomicBoolean flag = new AtomicBoolean(false);
        Set<Object> members = jdkTemplate.boundSetOps(key).members();
        Optional.ofNullable(members)
                .ifPresent(ms ->
                        ms.forEach(v -> {
                            Long id = (Long) v;
                            if (id.equals(value)) {
                                flag.set(true);
                            }
                        })
                );
        return flag.get();
    }

}
