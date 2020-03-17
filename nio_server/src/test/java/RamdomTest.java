import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.taylor.im.NioImApplication;
import com.taylor.im.message.entity.po.MessagePo;
import com.taylor.im.message.service.IMessageService;
import com.taylor.im.user.entity.po.UserPo;
import com.taylor.im.user.service.ILoginService;
import com.taylor.im.user.service.IUserService;
import com.taylor.im.util.DateUtil;
import io.swagger.models.auth.In;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = NioImApplication.class)
public class RamdomTest {

    @Autowired
    private IUserService userService;
    @Autowired
    private ILoginService loginService;
    @Autowired
    private IMessageService messageService;

    @Test
    public void ramdon() {
        System.out.println(ThreadLocalRandom.current().nextLong(100000000L, 3999999999L));
    }

    @Test
    public void test() {
        LocalDateTime t1 = LocalDateTime.now();
        LocalDateTime t2 = LocalDateTime.of(1998, 7, 17, 19, 0, 0);
        LocalDateTime t3 = LocalDateTime.parse("2000-12-03T10:15:30");
        LocalDateTime t4 = LocalDateTime.parse("2001-04-23 12:30", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        LocalDateTime t5 = LocalDateTime.parse("2017-01-08 00:00:00", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        LocalDate t6 = t3.toLocalDate();
        LocalDate t7 = t2.toLocalDate();
        int age = t7.until(t6).getYears();
        System.out.println(age);

        int month = t2.getMonthValue();
        int day = t2.getDayOfMonth();
        System.out.println(month + " " + day);
        System.out.println(DateUtil.getConstellation(t2));
    }

    @Test
    public void test2() {
        LocalDateTime now = LocalDateTime.now();
        LambdaQueryWrapper<UserPo> q = new QueryWrapper<UserPo>()
                .lambda()
                .lt(UserPo::getBirthday, now)
                .eq(UserPo::getGender, false)
                .orderByAsc(UserPo::getUsername);
        System.out.println(userService.getByCondition(q));

        UserPo userPo = new UserPo();
        userPo.setProfession("计算机");
        System.out.println(userService.list(new QueryWrapper<>(userPo)));
    }


    @Test
    public void test4() {
        Long userId = 3520745329L;
        Long sendId = 3444614016L;
        String type = "CHAT";
        List<MessagePo> unreadList = messageService.searchUserUnread(userId);

        List<Long> sendIds = unreadList.stream().map(MessagePo::getSendId).distinct().collect(Collectors.toList());
        List<String> types = unreadList.stream().map(MessagePo::getType).distinct().collect(Collectors.toList());
        System.out.println(sendIds);
        System.out.println(types);

        // 根据 userId 、sendId、type分组
        List<MessagePo> collect = unreadList.stream()
                .filter(messagePo -> messagePo.getSendId().equals(sendId)
                        && messagePo.getType().equals(type))
                .sorted(Comparator.comparing(MessagePo::getId).reversed())
                .collect(Collectors.toList());
        MessagePo max = collect.get(0);
        System.out.println(max);
        System.out.println(collect);

        // 得到每个组 id 最大的元素 （按id从大到小排序取第一个）
        // 聚合每个组的元素个数

        //
        Map<MessagePo, Long> result = new HashMap<>();
        Map<String, Long> countMap = unreadList.stream()
                .collect(Collectors.groupingBy(messagePo ->
                        messagePo.getSendId() + "_" + messagePo.getType(), Collectors.counting()));
        System.out.println(countMap);

        countMap.keySet().forEach(key -> {
            String[] s = key.split("_");
            Long send_id = Long.valueOf(s[0]);
            String s_type = s[1];
            MessagePo max1 = getMax(unreadList, send_id, s_type);
            result.put(max1,countMap.get(key));
        });
        System.out.println(result);

    }


    /**
     * 获取符合条件的数据中最近的一条数据
     */
    public MessagePo getMax(List<MessagePo> unreadList, Long sendId, String type) {
        List<MessagePo> collect = unreadList.stream()
                .filter(messagePo -> messagePo.getSendId().equals(sendId)
                        && messagePo.getType().equals(type))
                .sorted(Comparator.comparing(MessagePo::getId).reversed())
                .collect(Collectors.toList());
        return collect.get(0);
    }


}
