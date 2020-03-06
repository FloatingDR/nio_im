package com.taylor.im.file.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;

/**
 * <p>
 * TODO
 * </p>
 *
 * @author taylor
 * @date 2020/3/1 16:40
 */
@Data
@ApiModel(value="HeaderImg对象", description="头像实体类，包含压缩和未压缩图片地址")
@Builder
public class HeaderImg {

    @ApiModelProperty(value = "用户图片地址（缩略图）", example = "http://xxx.com/img/23.jpg")
    private String imgReduce;

    @ApiModelProperty(value = "用户图片地址（原图）", example = "http://xxx.com/img/23.jpg")
    private String img;
}
