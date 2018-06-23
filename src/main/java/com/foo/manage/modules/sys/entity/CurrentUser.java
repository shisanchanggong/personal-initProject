package com.foo.manage.modules.sys.entity;

import java.io.Serializable;

/**
 * 
 * @author changzhongq
 * @time 2018年6月10日 上午11:03:55
 */
public class CurrentUser implements Serializable {
	private static final long serialVersionUID = 1L;

	private String userId;

	private String userName;

	private String loginName;
	
	private String loginPassword;
	
	private String locked;
	
	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

	public String getLocked() {
		return locked;
	}

	public void setLocked(String locked) {
		this.locked = locked;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
