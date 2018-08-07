package com.foo.manage.common.base;

/**
 * 字段属性和值 实体类
 * @author quchangzhong
 * @time 2018年2月12日 下午8:05:10
 */
public class Field {

	private String cloumn;
	private Object value;
	public String getCloumn() {
		return cloumn;
	}
	public void setCloumn(String cloumn) {
		this.cloumn = cloumn;
	}
	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}
	
}
