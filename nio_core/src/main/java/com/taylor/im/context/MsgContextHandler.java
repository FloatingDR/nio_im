package com.taylor.im.context;

import com.taylor.im.exception.BaseException;
import com.taylor.im.strategys.BaseStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 消息处理上下文,策略持有类
 * </p>
 *
 * @author taylor
 * @date 2020/2/18 11:39
 */
@Service
public class MsgContextHandler {

    private final ApplicationContext applicationContext;

    @Autowired
    public MsgContextHandler(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    /**
     * 存放所有策略类Bean的map
     */
    public static Map<String, Class<BaseStrategy>> strategyBeanMap = new HashMap<>();

    public BaseStrategy getStrategy(String value) {
        Class<BaseStrategy> strategyClass = strategyBeanMap.get(value);
        if (strategyClass == null) {
            throw new BaseException("没有对应的消息类型");
        }
        // 从容器中获取对应的策略bean
        return applicationContext.getBean(strategyClass);
    }

}
