package com.taylor.im.service;

/**
 * <p>
 * 查询数据库消息表接口
 * </p>
 *
 * @author taylor
 * @date 2020/2/23 15:49
 */
public interface IMsgService {

    /**
     * <p>
     * 获取用户未读消息
     * </p>
     *
     * @param userId userId
     * @return {@link String }
     * @author taylor
     * @date 2020/2/23 15:51
     */
    String searchUserUnread(Long userId);

}
