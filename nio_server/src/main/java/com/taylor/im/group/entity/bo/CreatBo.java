package com.taylor.im.group.entity.bo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Set;

/**
 * <p>
 * 创建群聊实体
 * </p>
 *
 * @author taylor
 * @date 2020/3/1 18:31
 */
@Data
@ApiModel(value = "CreatBo对象", description = "创建群聊实体")
public class CreatBo {

    @ApiModelProperty(value = "群主")
    private Long groupOwner;

    @ApiModelProperty(value = "群聊名称")
    private String name;

    @ApiModelProperty(value = "备注")
    private String remark;

    @ApiModelProperty(value = "群公告")
    private String notice;

    @ApiModelProperty(value = "群头像图片地址（压缩图片）")
    private String groupImgReduce;

    @ApiModelProperty(value = "群头像（原图）")
    private String groupImg;

    @ApiModelProperty(value = "群成员")
    private Set<Long> member;

}
