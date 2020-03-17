package com.taylor.im.message;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 消息实体基类
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 10:07
 */
@Data
@ApiModel(value="消息实体基类")
public class BaseMessage implements Serializable {

    private static final long serialVersionUID = -9049253953118711176L;

    /**
     * 消息头
     */
    @ApiModelProperty(value = "消息头")
    protected Header header;

    /**
     * 消息体
     */
    @ApiModelProperty(value = "消息体")
    protected Object data;

    /**
     * 发送时间
     */
    @ApiModelProperty(value = "发送时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    protected LocalDateTime sendTime;


    /**
     * 发送者id
     */
    @ApiModelProperty(value = "发送者id")
    private Long sendId;

}
