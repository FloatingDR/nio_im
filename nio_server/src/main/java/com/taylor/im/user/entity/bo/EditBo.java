package com.taylor.im.user.entity.bo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * EditBo
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 14:21
 */
@Data
@ApiModel(value = "用户更新信息实体", description = "用户更新信息实体")
public class EditBo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户姓名")
    private String username;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "性别 1:男性 0:女性")
    private Boolean gender;

    @ApiModelProperty(value = "个性签名")
    private String signature;

    @ApiModelProperty(value = "职业")
    private String profession;

    @ApiModelProperty(value = "公司")
    private String company;

    @ApiModelProperty(value = "所在地")
    private String address;

    @ApiModelProperty(value = "故乡")
    private String hometown;

    @ApiModelProperty(value = "用户图片地址（缩略图）", example = "http://xxx.com/img/23.jpg")
    private String imgReduce;

    @ApiModelProperty(value = "用户图片地址（原图）", example = "http://xxx.com/img/23.jpg")
    private String img;

}
