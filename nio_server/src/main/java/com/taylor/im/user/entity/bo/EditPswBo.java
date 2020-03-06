package com.taylor.im.user.entity.bo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 用户更改密码实体
 * </p>
 *
 * @author taylor
 * @date 2020/2/19 12:51
 */
@Data
@ApiModel(value = "EditPswBo对象，用户更改密码实体")
public class EditPswBo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户id")
    private Long userId;

    @ApiModelProperty(value = "用户旧密码")
    private String oldPsw;

    @ApiModelProperty(value = "用户新密码")
    private String newPsw;

}
