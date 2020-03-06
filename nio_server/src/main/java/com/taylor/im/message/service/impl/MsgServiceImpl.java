package com.taylor.im.message.service.impl;

import com.alibaba.fastjson.JSON;
import com.taylor.im.message.entity.po.MessagePo;
import com.taylor.im.message.service.IMessageService;
import com.taylor.im.service.IMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 查询数据库消息表接口实现类
 * </p>
 *
 * @author taylor
 * @date 2020/2/23 15:52
 */
@Service
public class MsgServiceImpl implements IMsgService {

    private final IMessageService messageService;

    @Autowired
    public MsgServiceImpl(IMessageService messageService) {
        this.messageService = messageService;
    }

    @Override
    public String searchUserUnread(Long userId) {
        List<MessagePo> messagePos = messageService.searchUserUnread(userId);
        return JSON.toJSONString(messagePos);
    }
}
