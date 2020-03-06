package com.taylor.im.user.entity.qo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * LoginQo
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 14:21
 */
@Data
@ApiModel(value="用户登录信息实体", description="用户登录信息实体")
public class LoginQo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户id")
    private Long userId;

    @ApiModelProperty(value = "用户登录密码")
    private String password;

}
