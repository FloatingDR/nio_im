package com.taylor.im.context;

import com.taylor.im.annotation.HandlerMsg;
import com.taylor.im.strategys.BaseStrategy;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * <p>
 * 策略核心功能, 获取所有策略注解的类型
 * 并将对应的class初始化到TransOrderContext中
 * 当一个类实现了这个接口（ApplicationContextAware）之后，
 * 这个类就可以方便获得ApplicationContext中的所有bean
 * 换句话说，就是这个类可以直接获取spring配置文件中，所有引用到的bean对象.
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 11:45
 */
@Service
public class MsgContextProcessor implements ApplicationContextAware {
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        Map<String, Object> map = applicationContext.getBeansWithAnnotation(HandlerMsg.class);
        map.forEach((k, v) -> {
            Class<BaseStrategy> strategyClass = (Class<BaseStrategy>) v.getClass();
            String value = strategyClass.getAnnotation(HandlerMsg.class).value();
            // 将class加入map中，value作为key
            MsgContextHandler.strategyBeanMap.put(value, strategyClass);
        });
    }
}
