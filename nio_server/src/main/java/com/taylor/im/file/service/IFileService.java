package com.taylor.im.file.service;

import com.taylor.im.file.entity.HeaderImg;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 * file服务层接口
 * </p>
 *
 * @author taylor
 * @date 2020/3/1 13:40
 */
public interface IFileService {

    /**
     * <p>
     * 上传图片
     * </p>
     *
     * @param userId userId
     * @param file   file
     * @return {@link String }
     * @throws Exception 异常
     * @author taylor
     * @date 2020/3/1 14:19
     */
    String upload(Long userId, MultipartFile file) throws Exception;

    /**
     * <p>
     * 压缩图片
     * </p>
     *
     * @param userId userId
     * @param img    img
     * @return {@link String }
     * @throws Exception 异常
     * @author taylor
     * @date 2020/3/1 15:41
     */
    String reduceImg(Long userId, MultipartFile img) throws Exception;

    /**
     * <p>
     * 上传头像，返回原图和压缩图地址
     * </p>
     *
     * @param userId userId
     * @param file   file
     * @return {@link HeaderImg }
     * @throws Exception 异常
     * @author taylor
     * @date 2020/3/1 16:45
     */
    HeaderImg uploadHeaderImg(Long userId, MultipartFile file) throws Exception;

}
