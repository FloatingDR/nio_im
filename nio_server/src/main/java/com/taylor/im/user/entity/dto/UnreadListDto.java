package com.taylor.im.user.entity.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 用户未读消息中的最近消息dto
 * </p>
 *
 * @author taylor
 * @date 2020/3/15 15:37
 */
@Data
@Builder
@ApiModel(value = "用户未读消息中的最近消息dto", description = "用户未读消息中的最近消息dto")
public class UnreadListDto implements Serializable {

    private static final long serialVersionUID = 9126118478119585583L;

    @ApiModelProperty(value = "发送消息者id")
    private Long sendId;

    @ApiModelProperty(value = "来自发送者的未读消息条数")
    private Long count;

    @ApiModelProperty(value = "发送者的头像")
    private String sendHeaderImg;

    @ApiModelProperty(value = "发送者的昵称")
    private String sendHeaderNickname;

    @ApiModelProperty(value = "消息")
    private String message;

    @ApiModelProperty(value = "消息发送时间", example = "1998-07-17 18:16:59")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime time;

}
