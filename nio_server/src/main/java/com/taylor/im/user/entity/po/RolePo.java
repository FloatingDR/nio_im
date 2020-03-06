package com.taylor.im.user.entity.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 角色表
 * </p>
 *
 * @author taylor
 * @since 2020-03-04
 */
@Data
@TableName("role")
@ApiModel(value = "RolePo对象", description = "角色表")
public class RolePo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty(value = "角色")
    private String role;

    @ApiModelProperty(value = "角色名")
    private String name;

    @ApiModelProperty(value = "优先级（0-10）")
    private Integer priority;


}
