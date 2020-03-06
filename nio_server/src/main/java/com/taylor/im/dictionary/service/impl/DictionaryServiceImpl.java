package com.taylor.im.dictionary.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.taylor.im.dictionary.dao.DictionaryDao;
import com.taylor.im.dictionary.entity.po.DictionaryPo;
import com.taylor.im.dictionary.service.IDictionaryService;
import com.taylor.im.exception.BaseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 * 数据字典表 服务实现类
 * </p>
 *
 * @author taylor
 * @since 2020-02-18
 */
@Service
public class DictionaryServiceImpl extends ServiceImpl<DictionaryDao, DictionaryPo> implements IDictionaryService {

    @Value("${dictionary.zodiac}")
    private String zodiac;

    @Value("${dictionary.constellation}")
    private String constellation;

    /**
     * 缓存 Map<code, Map<value, name>>
     */
    final private static Map<String, Map<Integer, String>> CACHE = new HashMap<>();

    /**
     * 缓存 Map<code, Map<name, code>>
     */
    final private static Map<String, Map<String, Integer>> EN_CACHE = new HashMap<>();

    private void mapByCode(String code) {
        DictionaryPo condition = new DictionaryPo();
        condition.setCode(code);
        List<DictionaryPo> list = list(new QueryWrapper<>(condition));
        Map<Integer, String> map = list.stream()
                .collect(Collectors.toMap(DictionaryPo::getValue, DictionaryPo::getName));
        Map<String, Integer> enMap = list.stream()
                .collect(Collectors.toMap(DictionaryPo::getName, DictionaryPo::getValue));
        CACHE.put(code, map);
        EN_CACHE.put(code, enMap);
    }

    /**
     * Constructor(构造方法) -> @Autowired(依赖注入) -> @PostConstruct(注释的方法)
     */
    @PostConstruct
    private void cache() {
        mapByCode(zodiac);
        mapByCode(constellation);
    }

    @Override
    public Map<Integer, String> getByCode(String code) {
        Map<Integer, String> map = CACHE.get(code);
        if (map == null) {
            throw new BaseException(String.format("没有 %s 类型的数据字典项", code));
        }
        return map;
    }

    @Override
    public Map<String, Integer> getByCode_en(String code) {
        Map<String, Integer> map = EN_CACHE.get(code);
        if (map == null) {
            throw new BaseException(String.format("没有 %s 类型的数据字典项", code));
        }
        return map;
    }


}

