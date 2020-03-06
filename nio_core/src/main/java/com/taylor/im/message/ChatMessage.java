package com.taylor.im.message;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 点对点消息实体
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 10:20
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel(value="消息实体基类")
public class ChatMessage extends BaseMessage {

    private static final long serialVersionUID = 6124567989452469500L;

    /**
     * 发送者id
     */
    @ApiModelProperty(value = "发送者id")
    private Long sendId;

    /**
     * 接收者id
     */
    @ApiModelProperty(value = "接收者id")
    private Long receiverId;

    /**
     * 是否已经签收
     */
    @ApiModelProperty(value = "是否已经签收")
    protected boolean signed;

}
