package com.taylor.im.message.service;

import com.taylor.im.message.entity.po.MessagePo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 消息表 服务类
 * </p>
 *
 * @author taylor
 * @since 2020-02-23
 */
public interface IMessageService extends IService<MessagePo> {

    /**
     * <p>
     * 保存 message，自动生成 id，可以通过getId得到
     * </p>
     *
     * @param messagePo messagePo
     * @author taylor
     * @date 2020/2/23 13:16
     */
    void saveMessage(MessagePo messagePo);

    /**
     * <p>
     * 获取用户未读消息
     * </p>
     *
     * @param userId 用户id
     * @return {@link List<MessagePo> }
     * @author taylor
     * @date 2020/2/23 15:42
     */
    List<MessagePo> searchUserUnread(Long userId);
}
