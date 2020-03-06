package com.taylor.im.dictionary.entity.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 数据字典表
 * </p>
 *
 * @author taylor
 * @since 2020-02-18
 */
@Data
@TableName("dictionary")
@ApiModel(value = "DictionaryPo对象", description = "数据字典表")
public class DictionaryPo {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id", example = "1")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty(value = "字典项")
    private String code;

    @ApiModelProperty(value = "值")
    private Integer value;

    @ApiModelProperty(value = "对应的名称")
    private String name;

    @ApiModelProperty(value = "父id",example = "0")
    private Integer parent;


}
