package com.taylor.im.user.entity.po;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 用户表
 * </p>
 *
 * @author taylor
 * @since 2020-02-17
 */
@Data
@TableName("user")
@ApiModel(value = "UserPO对象", description = "用户表")
public class UserPo implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId
    @ApiModelProperty(value = "用户id")
    private Long userId;

    @ApiModelProperty(value = "用户姓名")
    private String username;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "生日", example = "1998-07-17 00:00:00")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime birthday;

    @ApiModelProperty(value = "年龄", example = "1")
    private Integer age;

    @ApiModelProperty(value = "性别 1:男性 0:女性")
    private Boolean gender;

    @ApiModelProperty(value = "身份证号")
    private String identityId;

    @ApiModelProperty(value = "电话号码")
    private String telephone;

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

    @ApiModelProperty(value = "星座1-12分别对应", example = "1")
    private Integer constellation;

    @ApiModelProperty(value = "属相 1-12分别对应", example = "1")
    private Integer zodiac;

    @ApiModelProperty(value = "创建时间", example = "1998-07-17 18:16:59")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "修改时间", example = "1998-07-17 18:16:59")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime modifyTime;

    @ApiModelProperty(value = "用户图片地址（缩略图）", example = "http://xxx.com/img/23.jpg")
    private String imgReduce;

    @ApiModelProperty(value = "用户图片地址（原图）", example = "http://xxx.com/img/23.jpg")
    private String img;

    @ApiModelProperty(value = "用户背景图片地址", example = "http://xxx.com/img/23.jpg")
    private String backgroundImg;

}
