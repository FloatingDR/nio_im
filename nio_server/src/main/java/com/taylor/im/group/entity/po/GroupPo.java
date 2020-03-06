package com.taylor.im.group.entity.po;

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
 * 群信息表
 * </p>
 *
 * @author taylor
 * @since 2020-03-01
 */
@Data
@TableName("group_table")
@ApiModel(value="GroupPo对象", description="群信息表")
public class GroupPo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    @TableId(value = "id")
    private Long id;

    @ApiModelProperty(value = "群聊名称")
    private String name;

    @ApiModelProperty(value = "群主")
    private Long groupOwner;

    @ApiModelProperty(value = "备注")
    private String remark;

    @ApiModelProperty(value = "创建时间", example = "1998-07-17 18:16:59")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "群公告")
    private String notice;

    @ApiModelProperty(value = "群头像图片地址（压缩图片）")
    private String groupImgReduce;

    @ApiModelProperty(value = "群头像（原图）")
    private String groupImg;

}
