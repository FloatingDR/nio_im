package com.taylor.im.message;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 登录消息实体
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 10:20
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "登录消息实体")
public class LoginMessage extends BaseMessage {

    private static final long serialVersionUID = 6124567989452469500L;

    public LoginMessage() {
        this.setSendId(0L);
        Header header = new Header();
        header.setId(-1L);
        header.setMsgType(MsgType.LOGIN);
        header.setPriority((byte) 0);
        this.header = header;
        this.setData("连接成功");
    }

    public LoginMessage(Object data) {
        this.setSendId(0L);
        Header header = new Header();
        header.setId(-1L);
        header.setMsgType(MsgType.LOGIN);
        header.setPriority((byte) 0);
        this.header = header;
        this.data = data;
        this.setData("连接成功");
    }

}
