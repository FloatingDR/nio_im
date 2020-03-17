package com.taylor.im.message;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 群聊消息实体
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 10:20
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel(value="群聊消息实体")
public class GroupMessage extends BaseMessage{

    private static final long serialVersionUID = -2462154270406876423L;

    /**
     * 群 id
     */
    @ApiModelProperty(value = "群 id")
    private Long groupId;

}
