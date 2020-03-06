package com.taylor.im.exception;

/**
 * <p>
 * 没有权限异常
 * </p>
 *
 * @author taylor
 * @date 2020/3/4 17:27
 */
public class NotPermissionException extends BaseException {

    private static final long serialVersionUID = -3203230498456157762L;

    public NotPermissionException() {
        super("权限不足！");
    }

}
