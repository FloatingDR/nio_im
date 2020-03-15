package com.taylor.im.message.entity.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 消息表
 * </p>
 *
 * @author taylor
 * @since 2020-02-23
 */
@Data
@TableName("message")
@ApiModel(value = "MessagePo对象", description = "消息表")
public class MessagePo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty(value = "消息属于者，如果为负数，表示该消息属于多用户，具体用户由服务端自己来根据data解析")
    private Long userId;

    @ApiModelProperty(value = "消息发送者")
    private Long sendId;

    @ApiModelProperty(value = "消息类型")
    private String type;

    @ApiModelProperty(value = "消息内容，JSON格式")
    private String data;

    @ApiModelProperty(value = "消息是否签收 1：签收 0：未签收")
    private Boolean signed;


}
