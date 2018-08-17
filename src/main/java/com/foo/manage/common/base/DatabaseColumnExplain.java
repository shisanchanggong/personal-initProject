package com.foo.manage.common.base;

import java.io.Serializable;

/**
 * 数据库字段和注释
 * @author changzhongq
 * @time 2018年8月8日 上午11:05:41
 */
public class DatabaseColumnExplain implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 字段名
	 */
	private String columnName;
	
	/**
	 * 字段注释
	 */
	private String columnComment;

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnComment() {
		return columnComment;
	}

	public void setColumnComment(String columnComment) {
		this.columnComment = columnComment;
	}
	
}
