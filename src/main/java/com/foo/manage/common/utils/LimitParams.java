package com.foo.manage.common.utils;

/**
 * 分页参数，用于分页查询，将pageRequest对象中的分页转换成数据库查询参数
 * @author changzhongq
 * @time 2018年6月15日 下午11:37:30
 */
public class LimitParams {

	private int start;

	private int size;
	
	private String orderBy;

	public LimitParams() {
	}
	
	public LimitParams(PageRequest pageReq) {
		this.start = (pageReq.getPage() - 1) * pageReq.getRows();
		this.size = pageReq.getRows();
		if (!StringUtils.isEmpty(pageReq.getSidx())) {
			this.orderBy = pageReq.getSidx() + " " + pageReq.getSord();
		}
	}

	public LimitParams(int start, int size) {
		this.start = start;
		this.size = size;
	}


	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

}
