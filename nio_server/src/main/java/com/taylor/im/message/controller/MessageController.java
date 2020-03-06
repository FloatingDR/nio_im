package com.taylor.im.message.controller;


import com.taylor.im.message.entity.po.MessagePo;
import com.taylor.im.message.service.IMessageService;
import com.taylor.im.response.HttpResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 消息表 前端控制器
 * </p>
 *
 * @author taylor
 * @since 2020-02-23
 */
@RestController
@RequestMapping("/message")
@CrossOrigin
@Api(tags = "消息-api")
public class MessageController {

    private final IMessageService messageService;

    @Autowired
    public MessageController(IMessageService messageService) {
        this.messageService = messageService;
    }


    /**
     * <p>
     * 查找用户的未读消息
     * </p>
     *
     * @param userId userId
     * @return {@link HttpResult<List<MessagePo>> }
     * @author taylor
     * @date 2020/2/23 15:32
     */
    @GetMapping("search_message_unread/{userId}")
    @ApiOperation(value = "查找用户的未读消息", notes = "查找用户的未读消息")
    public HttpResult<List<MessagePo>> searchUserUnread(@PathVariable @ApiParam("用户id") Long userId) {
        return HttpResult.success(messageService.searchUserUnread(userId));
    }

    /**
     * <p>
     * 标记id为已读消息
     * </p>
     *
     * @param id id
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/2/23 15:07
     */
    @PutMapping("read/{id}")
    @ApiOperation(value = "标记id为已读消息", notes = "标记id为已读消息")
    public HttpResult<Boolean> readById(@PathVariable @ApiParam("消息id") Long id) {
        MessagePo messagePo = new MessagePo();
        messagePo.setId(id);
        messagePo.setSigned(true);
        return messageService.updateById(messagePo) ?
                HttpResult.success(true, "已读") :
                HttpResult.error("未读");
    }

    /**
     * <p>
     * 标记ids为已读消息
     * </p>
     *
     * @param ids ids
     * @return {@link HttpResult<Boolean> }
     * @author taylor
     * @date 2020/2/23 15:07
     */
    @PutMapping("read_batch")
    @ApiOperation(value = "标记ids为已读消息", notes = "标记ids为已读消息")
    public HttpResult<Boolean> deleteById(@ApiParam("消息ids") @RequestBody List<Long> ids) {
        List<MessagePo> messagePos = ids.stream()
                .map(id -> {
                    MessagePo messagePo = new MessagePo();
                    messagePo.setId(id);
                    messagePo.setSigned(true);
                    return messagePo;
                }).collect(Collectors.toList());
        return HttpResult.success(messageService.updateBatchById(messagePos), "已读");
    }

}
