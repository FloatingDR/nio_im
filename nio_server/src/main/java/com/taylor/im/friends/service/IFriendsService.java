package com.taylor.im.friends.service;

import com.taylor.im.user.entity.dto.UserDto;

import java.util.List;

/**
 * <p>
 * friends interface
 * </p>
 *
 * @author taylor
 * @date 2020/3/28 10:56
 */
public interface IFriendsService {

    /**
     * <p>
     * 添加朋友
     * </p>
     *
     * @param userId1 用户1
     * @param userId2 用户2
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/28 10:58
     */
    boolean addFriends(Long userId1, Long userId2);

    /**
     * <p>
     * 移除朋友关系
     * </p>
     *
     * @param userId1 用户1
     * @param userId2 用户2
     * @return {@link boolean }
     * @author taylor
     * @date 2020/3/28 10:59
     */
    boolean removeFriends(Long userId1, Long userId2);

    /**
     * <p>
     * 获取我的所有好友
     * </p>
     *
     * @param userId 用户id
     * @return {@link List<UserDto> }
     * @author taylor
     * @date 2020/3/28 11:01
     */
    List<UserDto> listMyFriends(Long userId);

    /**
     * <p>
     * 获取两个用户的公共好友
     * </p>
     *
     * @param userId1 用户1
     * @param userId2 用户2
     * @return {@link List<UserDto> }
     * @author taylor
     * @date 2020/3/28 11:02
     */
    List<UserDto> listCommonFriends(Long userId1, Long userId2);
}
