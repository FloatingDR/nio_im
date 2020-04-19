package com.taylor.im.message.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.taylor.im.message.dao.MessageDao;
import com.taylor.im.message.entity.po.MessagePo;
import com.taylor.im.message.service.IMessageService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 消息表 服务实现类
 * </p>
 *
 * @author taylor
 * @since 2020-02-23
 */
@Service
public class MessageServiceImpl extends ServiceImpl<MessageDao, MessagePo> implements IMessageService {

    @Override
    public void saveMessage(MessagePo messagePo) {
        baseMapper.saveMessage(messagePo);
    }

    @Override
    public List<MessagePo> searchUserUnread(Long userId) {
        LambdaQueryWrapper<MessagePo> q = new QueryWrapper<MessagePo>()
                .lambda()
                .eq(MessagePo::getType, "CHAT")
                .eq(MessagePo::getUserId, userId)
                .eq(MessagePo::getSigned, false);
        return baseMapper.searchUserUnread(q);
    }
}
