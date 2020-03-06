package com.taylor.im.config;

import com.alibaba.fastjson.support.spring.FastJsonRedisSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.lang.reflect.Method;

/**
 * <p>
 * 缓存配置（使用Redis缓存）
 * </p>
 *
 * @author taylor
 * @date 2020/2/20 15:16
 */
@Configuration
@EnableCaching
public class CachingConfig extends CachingConfigurerSupport {

    /**
     * key前缀，用于区分不同项目的缓存
     */
    @Value("${cache.pre}")
    private String PRE_KEY;
    /**
     * 缓存分隔符
     */
    @Value("${cache.sp}")
    private char sp;

    @Bean
    public CacheManager cacheManager(RedisConnectionFactory factory) {
        // 使用JDK序列化方式
        RedisSerializationContext.SerializationPair<Object> pair = RedisSerializationContext.SerializationPair
                .fromSerializer(new JdkSerializationRedisSerializer());

        RedisCacheConfiguration defaultCacheConfig = RedisCacheConfiguration.defaultCacheConfig()
                .serializeValuesWith(pair);
                // 过期时间
//                .entryTtl(Duration.ofHours(1));
        return RedisCacheManager
                .builder(RedisCacheWriter.nonLockingRedisCacheWriter(factory))
                .cacheDefaults(defaultCacheConfig)
                .build();
    }

    /**
     * 自定义key生成策略 ==> PRE_KEY:Class SimpleName:MethodName:params
     * 缓存对象集合中，缓存是以 key-value 形式保存的。
     * 当不指定缓存的 key 时，SpringBoot 会使用 SimpleKeyGenerator 生成 key。
     */
    @Bean
    @Override
    public KeyGenerator keyGenerator() {
        return this::cacheKey;
    }

    @Bean("JdkTemplate")
    public RedisTemplate<String, Object> jdkTemplate(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory);

        // 设置值（value）JdkSerializationRedisSerializer。
        redisTemplate.setValueSerializer(new JdkSerializationRedisSerializer());
        redisTemplate.setHashValueSerializer(new JdkSerializationRedisSerializer());
        // 设置键（key）的序列化采用StringRedisSerializer。
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());

        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }

    @Bean("RedisTemplate")
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory);
        FastJsonRedisSerializer<Object> fastJsonRedisSerializer = new FastJsonRedisSerializer<>(Object.class);

        // 设置值（value）的序列化采用FastJsonRedisSerializer。
        redisTemplate.setValueSerializer(fastJsonRedisSerializer);
        redisTemplate.setHashValueSerializer(fastJsonRedisSerializer);
        // 设置键（key）的序列化采用StringRedisSerializer。
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());

        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }

    /**
     * 生成缓存key值
     * @param o 对象
     * @param method 方法
     * @param params 参数
     * @return key
     */
    public String cacheKey(Object o, Method method, Object... params){
        StringBuilder sb = new StringBuilder();
        sb.append(PRE_KEY);
        sb.append(sp);
        sb.append(o.getClass().getSimpleName());
        sb.append(sp);
        sb.append(method.getName());
        for (Object obj : params) {
            sb.append(sp);
            sb.append(obj.toString());
        }
        return sb.toString();
    }

}
