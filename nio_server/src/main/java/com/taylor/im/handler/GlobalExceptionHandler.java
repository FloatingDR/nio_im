package com.taylor.im.handler;

import com.taylor.im.exception.BaseException;
import com.taylor.im.response.HttpResult;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 * 自定义springboot异常
 * </p>
 *
 * @author taylor
 * @date 2020/3/3 22:47
 */
@ControllerAdvice
@ResponseBody
public class GlobalExceptionHandler {

    @Value("${spring.servlet.multipart.max-file-size}")
    private String maxFileSize;

    @ExceptionHandler(BaseException.class)
    public HttpResult<Object> baseExceptionHandler(Exception e) {
        return HttpResult.error(e.getMessage());
    }

    @ExceptionHandler(org.apache.tomcat.util.http.fileupload.impl.FileSizeLimitExceededException.class)
    public HttpResult<Object> fileSizeLimitExceededExceptionHandler() {
        return HttpResult.error(String.format("文件大小超过限制:%s", maxFileSize));
    }

}
