package com.foo.manage.modules.sys.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 操作日志 实体类
 * @author changzhongq
 * @time 2018年6月22日 下午6:08:08
 */
@Table(name = "sys_operate_log")
public class SysOperateLog implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	private String logId;

	private String operateType;

	private String operateName;

	private String operateUserId;

	private String operateUserName;

	private Date operateTime;

	private String updateParams;
	
	private String requestUrl;
	
	private String tableName;

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getRequestUrl() {
		return requestUrl;
	}

	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}

	public String getLogId() {
		return logId;
	}

	public void setLogId(String logId) {
		this.logId = logId;
	}

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

	public String getOperateName() {
		return operateName;
	}

	public void setOperateName(String operateName) {
		this.operateName = operateName;
	}

	public String getOperateUserId() {
		return operateUserId;
	}

	public void setOperateUserId(String operateUserId) {
		this.operateUserId = operateUserId;
	}

	public String getOperateUserName() {
		return operateUserName;
	}

	public void setOperateUserName(String operateUserName) {
		this.operateUserName = operateUserName;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public String getUpdateParams() {
		return updateParams;
	}

	public void setUpdateParams(String updateParams) {
		this.updateParams = updateParams;
	}
	
}
