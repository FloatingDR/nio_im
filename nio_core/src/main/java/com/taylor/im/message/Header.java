package com.taylor.im.message;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * 消息头
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 10:12
 */
@Data
@ApiModel(value="消息头")
public class Header {
    /**
     * 消息id,如果id<0,表示该消息不需要持久化
     */
    @ApiModelProperty(value = "消息id,如果id<0,表示该消息不需要持久化")
    private Long id;

    /**
     * 消息类型
     */
    @ApiModelProperty(value = "消息类型")
    private MsgType msgType;

    /**
     * 消息优先级
     */
    @ApiModelProperty(value = "消息优先级")
    private byte priority;
}
