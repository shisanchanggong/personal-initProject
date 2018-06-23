package com.foo.manage.common.utils;

import java.io.Serializable;

/**
 * 分页请求参数
 * @author changzhongq
 * @time 2018年6月12日 上午9:56:55
 */
public class PageRequest implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer page;
	private Integer rows;
	private String sidx;
	private String sord;

	public PageRequest() {

	}

	public PageRequest(Integer page, Integer rows, String sidx, String sord) {
		this.page = page;
		this.rows = rows;
		this.sidx = sidx;
		this.sord = sord;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}
}
