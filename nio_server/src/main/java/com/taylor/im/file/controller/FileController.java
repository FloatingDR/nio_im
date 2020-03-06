package com.taylor.im.file.controller;

import com.taylor.im.file.entity.HeaderImg;
import com.taylor.im.file.service.IFileService;
import com.taylor.im.response.HttpResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 * 文件服务
 * </p>
 *
 * @author taylor
 * @date 2020/3/1 13:31
 */
@RestController
@RequestMapping("/file")
@CrossOrigin
@Api(tags = "文件服务")
public class FileController {

    private final IFileService fileService;

    @Autowired
    public FileController(IFileService fileService) {
        this.fileService = fileService;
    }


    @PostMapping("/upload/{userId}")
    @ApiOperation(value = "上传", notes = "上传")
    public HttpResult<String> upload(@PathVariable @ApiParam("用户id") Long userId, @RequestParam("file") @ApiParam("文件") MultipartFile file) {
        String path;
        try {
            path = fileService.upload(userId, file);
            return path != null ?
                    HttpResult.success(path) :
                    HttpResult.error("上传失败");
        } catch (Exception e) {
            e.printStackTrace();
            return HttpResult.error(e.getMessage());
        }
    }

    @PostMapping("/reduceImg/{userId}")
    @ApiOperation(value = "压缩图片", notes = "压缩图片")
    public HttpResult<String> reduceImg(@PathVariable @ApiParam("用户id") Long userId, @RequestParam("file") @ApiParam("原图") MultipartFile file) {
        String path;
        try {
            path = fileService.reduceImg(userId, file);
            return path != null ?
                    HttpResult.success(path) :
                    HttpResult.error("压缩图片失败");
        } catch (Exception e) {
            e.printStackTrace();
            return HttpResult.error(e.getMessage());
        }
    }

    @PostMapping("/uploadHeaderImg/{userId}")
    @ApiOperation(value = "上传原图并压缩图片", notes = "上传原图并压缩图片")
    public HttpResult<HeaderImg> uploadHeaderImg(@PathVariable @ApiParam("用户id") Long userId, @RequestParam("file") @ApiParam("原图") MultipartFile file) throws Exception {
        HeaderImg headerImg = fileService.uploadHeaderImg(userId, file);
        return headerImg != null ?
                HttpResult.success(headerImg) :
                HttpResult.error("上传失败");
    }

}
