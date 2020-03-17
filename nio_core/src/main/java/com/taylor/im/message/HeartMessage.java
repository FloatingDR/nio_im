package com.taylor.im.message;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * <p>
 * 心跳包,用于服务器检测客户端心跳
 * 维持TCP连接
 * </p>
 *
 * @author taylor
 * @date 2020/2/22 13:58
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "心跳包")
public class HeartMessage extends BaseMessage {

    private static final long serialVersionUID = -3841014031637048904L;

    /**
     * 校验码 (980717)
     */
    private static final int CRC_CODE = 0xEF6ED;

    /**
     * 心跳包校验码
     */
    @ApiModelProperty(value = "心跳包校验码")
    private int crcCode;

    /**
     * 简单校验心跳包
     */
    public boolean verify() {
        return CRC_CODE == crcCode;
    }

    /**
     * 构造pang返回消息
     */
    public HeartMessage() {
        this.setSendId(0L);
        this.crcCode = 0xEF6ED;
        this.data = "PANG";
        this.sendTime = LocalDateTime.now();
        Header header = new Header();
        header.setMsgType(MsgType.PANG);
        header.setId(-1L);
        header.setPriority((byte) 0);
        this.header = header;
    }

}
