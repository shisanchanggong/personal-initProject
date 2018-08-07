package com.foo.manage.common.utils;

/**
 * 返回结果统一处理
 * @author quchangzhong
 * @time 2018年1月19日 下午8:17:30
 */
public class ServiceResult {

	private boolean isSuccess;

	private String message;

	private Object businessObject;

	public ServiceResult(boolean isSuccess, String message, Object businessObject) {
		super();
		this.isSuccess = isSuccess;
		this.message = message;
		this.businessObject = businessObject;
	}

	public ServiceResult() {
	}

	public static ServiceResult newOkInstance(String message, Object businessObject) {
		return new ServiceResult(true, message, businessObject);
	}
	
	public static ServiceResult newOkInstance(Object businessObject) {
		return new ServiceResult(true, null, businessObject);
	}

	public static ServiceResult newErrorInstance(String message) {
		return new ServiceResult(false, message, null);
	}

	public boolean getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getBusinessObject() {
		return businessObject;
	}

	public void setBusinessObject(Object businessObject) {
		this.businessObject = businessObject;
	}
}
