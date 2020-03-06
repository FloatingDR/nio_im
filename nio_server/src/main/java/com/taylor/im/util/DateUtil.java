package com.taylor.im.util;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Calendar;
import java.util.Date;

/**
 * <p>
 * 日期工具类
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 21:08
 */
public class DateUtil {
    private final static int[] dayArr = new int[]{20, 19, 21, 20, 21, 22, 23, 23, 23, 24, 23, 22};
    private final static String[] constellationArr = new String[]{"摩羯座",
            "水瓶座", "双鱼座", "白羊座", "金牛座", "双子座", "巨蟹座", "狮子座", "处女座", "天秤座",
            "天蝎座", "射手座", "摩羯座"};

    /**
     * 计算星座
     */
    public static String getConstellation(LocalDateTime localDateTime) {
        int month = localDateTime.getMonthValue();
        int day = localDateTime.getDayOfMonth();
        return day < dayArr[month - 1] ? constellationArr[month - 1]
                : constellationArr[month];
    }

    /**
     * 获取生肖
     */
    public static String getZodiac(LocalDateTime birthday) {
        Calendar calendar = Calendar.getInstance();
        ZoneId zoneId = ZoneId.systemDefault();
        ZonedDateTime zdt = birthday.atZone(zoneId);
        Date date = Date.from(zdt.toInstant());
        calendar.setTime(date);
        Birth birth = new Birth(calendar);
        return birth.animalsYear();
    }

}

