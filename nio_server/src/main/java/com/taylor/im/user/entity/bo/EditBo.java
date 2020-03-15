package com.taylor.im.user.entity.bo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

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

    @ApiModelProperty(value = "性别 男/女")
    private String gender;

    @ApiModelProperty(value = "生日", example = "1998-07-17 18:16:59")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime birthday;

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

    @ApiModelProperty(value = "用户背景图片地址", example = "http://xxx.com/img/23.jpg")
    private String backgroundImg;

}
