package com.taylor.im.util;

import org.springframework.util.DigestUtils;

/**
 * <p>
 * MD5 工具类
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 14:57
 */
public class MD5Util {

    /**
     * 加密前缀
     */
    private static String pre = "taylor@0717";

    /**
     * md5 加密
     */
    public static String md5(String text) {
        return DigestUtils.md5DigestAsHex((pre + text).getBytes());
    }

    /**
     * 校验
     *
     * @param text 明文
     * @param md5  密文
     * @return boolean
     */
    public static boolean verify(String text, String md5) {
        return md5(text).equalsIgnoreCase(md5);
    }


}
