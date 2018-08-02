package com.foo.manage.common.base;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
@SuppressWarnings("unchecked")
public abstract class BaseController<T> {

	/**
	 * 子类Class类型
	 */
	public Class<T> classT;

	@Autowired
	private BaseService baseService;

	/**
	 * 根据ID查询单条记录
	 * @param id 数据ID
	 */
	@RequestMapping("/data/{id}")
	@ResponseBody
	public T data(@PathVariable("id") String id) {
		return baseService.find(classT, id);
	}

	/**
	 * 单条记录删除
	 * @param id 数据ID
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_DELETE, operationName = "单条删除")
	public boolean delete(@PathVariable("id") String id) {
		return baseService.delete(classT, id);
	}

	/**
	 * 批量删除
	 * @param ids id数组
	 */
	@RequestMapping("/batchDelete")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_DELETE, operationName = "批量删除")
	public boolean batchDelete(String[] ids) {
		return baseService.batchDelete(classT, ids);
	}

	/**
	 * 新增或修改操作
	 * @param data 需要保存的数据
	 */
	@RequestMapping("/save")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_SAVE, operationName = "保存（新增或更新）")
	public ServiceResult insertOrUpdate(T data) {
		return baseService.insertOrUpdate(classT, data);
	}

	/**
	 * 精确搜索
	 * @param request 请求参数
	 * @param pageReq 分页信息实体
	 * @return
	 */
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
	 * @param request 请求参数
	 * @param pageReq 分页信息实体
	 * @return
	 */
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

	/**
	 * 通用导出方法
	 * @param request 请求信息
	 * @param response 响应信息
	 */
	@RequestMapping("/export")
	@ResponseBody
	public void export(HttpServletRequest request, HttpServletResponse response) {
		String param = (String) request.getParameter("param");
		Map<String, Object> paramMap = (Map<String, Object>) JSONUtils.parse(StringUtils.isEmpty(param) ? "{}" : param);
		// 创建HSSFWorkbook
		try {
			HSSFWorkbook wb = baseService.getHSSFWorkbook(paramMap);
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode((String) paramMap.get("fileName"), "UTF-8"));
			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 构造方法，同时为继承的类赋Class值
	 */
	public BaseController() {
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		classT = (Class<T>) params[0];
	}

	/**
	 * 发送响应流方法
	 * @param response 响应信息
	 * @param fileName 文件名
	 */
	public void setResponseHeader(HttpServletResponse response, String fileName) {
		try {
			fileName = new String(fileName.getBytes(), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setContentType("application/octet-stream;charset=ISO8859-1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		response.addHeader("Pargam", "no-cache");
		response.addHeader("Cache-Control", "no-cache");
	}
}
