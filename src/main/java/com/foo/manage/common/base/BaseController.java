package com.foo.manage.common.base;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.support.json.JSONUtils;
import com.foo.manage.common.aop.OperateLog;
import com.foo.manage.common.utils.Constants;
import com.foo.manage.common.utils.PageRequest;
import com.foo.manage.common.utils.PageResult;
import com.foo.manage.common.utils.PageResultHelper;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.common.utils.StringUtils;

/**
 * 基础控制器，所有Controller继承它可以使用通用方法
 * @author changzhongq
 * @time 2018年6月11日 下午5:10:55
 */
public abstract class BaseController<T> {

	public Class<T> classT;

	@Autowired
	private BaseService baseService;

	@RequestMapping("/data/{id}")
	@ResponseBody
	public T data(@PathVariable("id") String id) {
		return baseService.find(classT, id);
	}

	@RequestMapping("/delete/{id}")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_DELETE, operationName = "单条删除")
	public boolean delete(@PathVariable("id") String id) {
		return baseService.delete(classT, id);
	}

	@RequestMapping("/batchDelete")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_DELETE, operationName = "批量删除")
	public boolean batchDelete(String[] ids) {
		return baseService.batchDelete(classT, ids);
	}

	@RequestMapping("/save")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_SAVE, operationName = "保存（新增或更新）")
	public ServiceResult insertOrUpdate(T data) {
		return baseService.insertOrUpdate(classT, data);
	}

	/**
	 * 精确搜索
	 * @param request
	 * @param pageReq
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/list")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_GET, operationName = "查询列表")
	public PageResult list(HttpServletRequest request, PageRequest pageReq) {
		String param = (String) request.getParameter("param");
		if (StringUtils.isEmpty(param)) {
			return new PageResultHelper().exeQuery(classT, pageReq, false);
		}
		Map<String, Object> paramMap = (Map<String, Object>) JSONUtils.parse(param);
		return new PageResultHelper().exeQuery(classT, pageReq, paramMap, false);
	}

	/**
	 * 模糊搜索
	 * @param request
	 * @param pageReq
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/list", params = { "like" })
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_GET, operationName = "模糊查询列表")
	public PageResult listLike(HttpServletRequest request, PageRequest pageReq) {
		String param = (String) request.getParameter("param");
		if (StringUtils.isEmpty(param)) {
			return new PageResultHelper().exeQuery(classT, pageReq);
		}
		Map<String, Object> paramMap = (Map<String, Object>) JSONUtils.parse(param);
		return new PageResultHelper().exeQuery(classT, pageReq, paramMap);
	}

	@SuppressWarnings("unchecked")
	public BaseController() {
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		classT = (Class<T>) params[0];
	}

}
