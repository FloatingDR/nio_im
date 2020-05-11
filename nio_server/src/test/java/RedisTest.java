import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.taylor.im.NioImApplication;
import com.taylor.im.message.HeartMessage;
import com.taylor.im.message.LoginMessage;
import com.taylor.im.user.entity.po.UserPo;
import com.taylor.im.user.service.IUserService;
import io.netty.channel.ChannelId;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.support.atomic.RedisAtomicLong;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

/**
 * <p>
 *
 * </p>
 *
 * @author taylor
 * @date 2020/2/20 14:53
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = NioImApplication.class)
public class RedisTest {

    @Autowired
    @Qualifier("RedisTemplate")
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    @Qualifier("JdkTemplate")
    private RedisTemplate<String, Object> jdkTemplate;

    @Autowired
    private IUserService userService;

    @Test
    public void setValue() {
        LocalDateTime now = LocalDateTime.now();
        String key = "key";
        redisTemplate.boundValueOps("localdateTime_key").set(now);
        redisTemplate.boundValueOps("key").set(key);
        List<UserPo> list = userService.list();
        redisTemplate.boundValueOps("list").set(list);
    }

    @Test
    public void getValue() {

        System.out.println(redisTemplate.boundValueOps("getById::3520745329").get());
        System.out.println(redisTemplate.boundValueOps("localdateTime_key").get());
        System.out.println((String) redisTemplate.boundValueOps("key").get());

        JSONArray jsonArray = (JSONArray) redisTemplate.boundValueOps("list").get();
        assert jsonArray != null;
        List<UserPo> list = jsonArray.toJavaList(UserPo.class);
        for (UserPo userPo : list) {
            System.out.println(userPo);
        }


    }

    @Test
    public void deleteValue() {
        redisTemplate.delete("localdateTime_key");
        redisTemplate.delete("key");
        redisTemplate.delete("list");
        LocalDateTime now = LocalDateTime.now();
        String key = "key";
        redisTemplate.boundValueOps("localdateTime_key").set(now);
        redisTemplate.boundValueOps("key").set(key);
        List<UserPo> list = userService.list();
        redisTemplate.boundValueOps("list").set(list);
    }

    @Test
    public void test() {

        HeartMessage heartMessage = new HeartMessage();
        LoginMessage loginMessage = new LoginMessage();

        System.out.println(heartMessage);
        System.out.println(loginMessage);

        String heart = JSON.toJSONString(heartMessage);
        String login = JSON.toJSONString(loginMessage);

        System.out.println(heart);
        System.out.println(login);
    }

    @Test
    public void uuidTest() {
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        System.out.println(uuid);
    }

    @Test
    public void redisKeys() {
        String PRE_UC = "USER_CHANNEL#";
        Optional.ofNullable(jdkTemplate.keys(PRE_UC + "*")).ifPresent(keys -> keys.forEach(key -> {
            ChannelId channelId = (ChannelId) jdkTemplate.boundValueOps(key).get();
            assert channelId != null;
            System.out.println(channelId.asLongText() + " / " + channelId.asShortText());
        }));
    }


    @Test
    public void AutoLong() {
        RedisAtomicLong counter = new RedisAtomicLong("ATOMIC_LONG", Objects.requireNonNull(redisTemplate.getConnectionFactory()));
        System.out.println(counter.incrementAndGet());
    }

    @Test
    public void test3() {

        jdkTemplate.boundSetOps("goup#398080800").add(83204820, 1213124, 2141241);

    }
}

