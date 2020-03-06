package com.taylor.im.message;

/**
 * <p>
 * 消息类型枚举类
 * 消息类型分为
 * 1.客户端心跳（用于客户端与服务器维持心跳状态,客户端向服务器发送维持客户端在线状态）
 * 2.点对点聊天消息
 * 3.群聊消息
 * 4.订阅号消息/推送消息
 * 5.客户端登录消息，用于将userId与ChannelId映射
 * </p>
 *
 * @author taylor
 * @date 2020/2/9 10:48
 */
public enum MsgType {


    /**
     * 客户端心跳
     */
    PING("PING"),

    /**
     * 服务端心跳返回
     */
    PANG("PANG"),

    /**
     * 点对点聊天消息
     */
    CHAT("CHAT"),

    /**
     * 群聊消息
     */
    GROUP_CHAT("GROUP_CHAT"),

    /**
     * 订阅号消息/推送消息
     */
    PUSH("PUSH"),

    /**
     * 客户端登录或第一次连接
     */
    LOGIN("LOGIN");

    /**
     * 消息类型
     */
    private String type;

    MsgType(String type) {
        this.type = type;
    }

    public String type() {
        return type;
    }
}
