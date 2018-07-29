package com.foo.manage.common.utils;

import java.util.List;

/**
 * 分页数据
 * @author changzhongq
 * @time 2018年6月11日 下午7:02:57
 */
public class PageResult {
	private Long records;
	private int page;
	private int total;
	private List<?> rows;

	public PageResult() {

	}
	
	public PageResult(List<?> rows) {
		this.rows = rows;
	}

	public PageResult(Long records, Integer page, int total, List<?> rows) {
		this.records = records;
		this.page = page;
		this.total = total;
		this.rows = rows;
	}

	public Long getRecords() {
		return records;
	}

	public void setRecords(Long records) {
		this.records = records;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}

}
