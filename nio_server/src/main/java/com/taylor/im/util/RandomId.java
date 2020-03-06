package com.taylor.im.util;

import java.util.concurrent.ThreadLocalRandom;

/**
 * <p>
 * 生成随机id,类似于qq号
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 15:34
 */
public class RandomId {

    /**
     * 生成随机id
     */
    public static Long id() {
        return ThreadLocalRandom.current().nextLong(100000000L, 3999999999L);
    }

}
