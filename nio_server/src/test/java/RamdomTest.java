import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.taylor.im.NioImApplication;
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
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = NioImApplication.class)
public class RamdomTest {

    @Autowired
    private IUserService userService;
    @Autowired
    private ILoginService loginService;

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
    public void test3() {
        List<Integer> target = new ArrayList<>();
        List<Integer> list = new ArrayList<>();

        for (Integer i : list) {
            // 存在
            if (target.indexOf(i) >= 0) {
                continue;
            }
            target.add(i);
        }
    }

}
