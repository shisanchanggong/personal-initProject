package com.foo.manage.common.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.foo.manage.common.utils.ServiceResult;

/**
 * 全局异常处理类
 * @author changzhongq
 * @time 2018年7月31日 下午5:48:30
 */
@ControllerAdvice
public class AdviceController {

	/**
	 * 全局处理异常
	 * @param ex
	 */
	@ExceptionHandler(Exception.class)
	public String errorHandle(Exception ex) {
		return "/common/error";
	}
	
	/**
	 * 运行时异常
	 * @param ex
	 */
	@ExceptionHandler(RuntimeException.class)
	public ServiceResult errorHandle(RuntimeException ex) {
		return ServiceResult.newErrorInstance(ex.getMessage());
	}
}