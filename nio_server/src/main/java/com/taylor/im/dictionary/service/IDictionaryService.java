package com.taylor.im.dictionary.service;

import com.taylor.im.dictionary.entity.po.DictionaryPo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 * 数据字典表 服务类
 * </p>
 *
 * @author taylor
 * @since 2020-02-18
 */
public interface IDictionaryService extends IService<DictionaryPo> {

    /**
     * 根据字典项获取字典映射
     *
     * @param code 字典项
     * @return {@link Map<Integer,String>}
     */
    Map<Integer, String> getByCode(String code);

    /**
     * 根据字典项获取字典映射
     *
     * @param code 字典项
     * @return {@link Map<Integer,String>}
     */
    Map<String, Integer> getByCode_en(String code);
}
