package com.foo.manage.common.utils;

import java.util.List;
import java.util.Map;

import com.foo.manage.common.base.BaseService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

/**
 * 
 * @author changzhongq
 * @time 2018年6月12日 上午9:16:44
 */
public class PageResultHelper extends PageHelper {

	public PageResultHelper() {
		baseService = (BaseService) SpringContextUtil.getBean(BaseService.class);
	}

	private BaseService baseService;

	public static <T> PageResult parseResult(List<T> list) {
		Page<T> pages = (Page<T>) list;
		PageResult res = new PageResult();
		res.setPage(pages.getPageNum());
		res.setRecords(pages.getTotal());
		res.setTotal(pages.getPages());
		res.setRows(pages.getResult());
		return res;
	}

	public static <E> Page<E> startPage(PageRequest pageReq) {
		String sidx = pageReq.getSidx();
		if (StringUtils.isEmpty(sidx)) {
			return PageHelper.startPage(pageReq.getPage(), pageReq.getRows());
		} else {
			return PageHelper.startPage(pageReq.getPage(), pageReq.getRows(), sidx + " " + pageReq.getSord());
		}
	}

	/**
	 * 通用的分页查询
	 * @param clazz 实体类类型
	 * @param pageReq 分页参数
	 * @param param 过滤条件
	 * @param like 是否模糊匹配
	 * @return
	 */
	public <T> PageResult exeQuery(Class<?> clazz, PageRequest pageReq, Map<String, Object> param, boolean like) {
		PageResult pageResult = new PageResult();
		List<Object> list = null;
		Long records = null;
		if (StringUtils.isEmpty(param)) {
			records = baseService.count(clazz);
			list = baseService.findAll(clazz, pageReq);
		} else {
			if (like) {
				records = baseService.countByLike(clazz, param);
				list = baseService.findByLike(clazz, pageReq, param);
			} else {
				records = baseService.countBy(clazz, param);
				list = baseService.findBy(clazz, pageReq, param);
			}
		}
		Long total = (records - 1) / pageReq.getRows() + 1;
		pageResult.setRows(list);
		pageResult.setRecords(records);
		pageResult.setPage(pageReq.getPage());
		pageResult.setTotal(total.intValue());
		return pageResult;
	}

	/**
	 * 直接执行分页查询
	 * @param clazz
	 * @param pageReq
	 * @return
	 */
	public <T> PageResult exeQuery(Class<?> clazz, PageRequest pageReq, boolean like) {
		return exeQuery(clazz, pageReq, null, like);
	}

	/**
	 * 默认查询方式 模糊搜索
	 */
	public <T> PageResult exeQuery(Class<?> clazz, PageRequest pageReq) {
		return exeQuery(clazz, pageReq, true);
	}

	/**
	 * 默认查询方式 模糊搜索
	 */
	public <T> PageResult exeQuery(Class<?> clazz, PageRequest pageReq, Map<String, Object> param) {
		return exeQuery(clazz, pageReq, param, true);
	}
}
