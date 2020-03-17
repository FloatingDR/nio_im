package com.taylor.im.user.entity.bo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 用户缓存对话消息
 * </p>
 *
 * @author taylor
 * @date 2020/3/16 10:11
 */
@Data
@ApiModel(value = "UserChatCache对象，用户缓存对话消息")
public class UserChatCache implements Serializable {

    private static final long serialVersionUID = 9126118478119585583L;

    @ApiModelProperty(value = "消息id")
    private Long msgId;

    @ApiModelProperty(value = "消息发送者id")
    private Long userId;

    @ApiModelProperty(value = "是否是我发送的消息")
    private Boolean isMe;

    @ApiModelProperty(value = "消息发送者头像")
    private String headImg;

    @ApiModelProperty(value = "是否签收")
    private Boolean singed;

    @ApiModelProperty(value = "消息内容")
    private String content;

}
