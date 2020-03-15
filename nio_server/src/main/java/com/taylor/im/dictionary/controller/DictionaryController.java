package com.taylor.im.dictionary.controller;


import com.taylor.im.dictionary.service.IDictionaryService;
import com.taylor.im.response.HttpResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * <p>
 * 数据字典表 前端控制器
 * </p>
 *
 * @author taylor
 * @since 2020-02-18
 */
@RestController
@RequestMapping("/dictionary")
@CrossOrigin
public class DictionaryController {

}
