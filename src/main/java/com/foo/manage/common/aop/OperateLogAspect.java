package com.foo.manage.common.aop;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.druid.support.json.JSONUtils;
import com.foo.manage.common.base.BaseService;
import com.foo.manage.common.utils.CommonUtils;
import com.foo.manage.common.utils.SpringContextUtil;
import com.foo.manage.common.utils.SubjectUtils;
import com.foo.manage.common.utils.TimeUtils;
import com.foo.manage.common.utils.UUIDUtils;
import com.foo.manage.modules.sys.entity.CurrentUser;
import com.foo.manage.modules.sys.entity.SysOperateLog;

/**
 * 操作日志处理类
 * @author changzhongq
 * @time 2018年6月22日 下午4:38:38
 */
@Aspect
@Configuration
public class OperateLogAspect {

	private static final Logger logger = LoggerFactory.getLogger(OperateLogAspect.class);

	private HttpServletRequest request = null;

	@Pointcut("execution(* com.foo.manage..*.*Controller.*(..))")
	public void webLog() {

	}

	/**
	 * 方法调用前触发 记录开始时间
	 */
	@Before("webLog()")
	public void before(JoinPoint joinPoint) {

	}

	/**
	 * 获取request
	 */
	public HttpServletRequest getHttpServletRequest() {
		RequestAttributes ra = RequestContextHolder.getRequestAttributes();
		ServletRequestAttributes sra = (ServletRequestAttributes) ra;
		HttpServletRequest request = sra.getRequest();
		return request;
	}

	/**
	 * 环绕触发 插入日志时可以使查询、新增、修改、删除、保存（包括新增或删除，至于是哪一种自行判断）操作
	 * 新增、修改、保存操作会将调用方法的参数直接保存到数据库 删除会先用id值查询出删除的数据，然后保存到实体中，然后插入数据库
	 * 
	 * 如果整个类都不需要记录日志，则在类上加上@NoRecordLog注解即可
	 * 如果方法上需要记录日志，则需要标记插入的类型（查询、新增、修改等）、操作标题（自行填写标题），注解使用@OperateLog
	 * 如果需要记录表名，则需要在类上加入操作类注解@OperateClass，不加则不记录
	 */
	@Around("webLog()")
	public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
		Class<?> targetClass = joinPoint.getTarget().getClass();
		// 如果类上有不记录日志的注解，则操作记录将不会插入到数据库
		if (targetClass.getAnnotation(NoRecordLog.class) == null) {
			MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
			Method method = methodSignature.getMethod();
			OperateLog operateLog = method.getAnnotation(OperateLog.class);
			// 存在日志注解才进行方法拦截
			if (operateLog != null) {
				logger.info("插入操作日志...");
				OperateClass operateClass = targetClass.getAnnotation(OperateClass.class);
				request = getHttpServletRequest();
				// 插入操作痕迹到数据库
				insertOperateLog(operateLog, operateClass, joinPoint.getArgs());
			}
		}
		return joinPoint.proceed();
	}

	/**
	 * 插入操作日志
	 * @param operateLog 方法上的注解，包含操作类型和操作标题
	 * @param operateClass 操作实体Class
	 * @param args 方法参数
	 */
	public void insertOperateLog(OperateLog operateLog, OperateClass operateClass, Object[] args) {
		BaseService baseService = (BaseService) SpringContextUtil.getBean(BaseService.class);
		SysOperateLog log = new SysOperateLog();
		log.setLogId(UUIDUtils.getUUID());
		CurrentUser currentUser = SubjectUtils.getUser();
		log.setOperateUserId(currentUser.getUserId());
		log.setOperateUserName(currentUser.getUserName());
		log.setOperateTime(TimeUtils.getTimestamp());
		String operationType = operateLog.operationType();
		log.setOperateType(operationType);
		log.setOperateName(operateLog.operationName());
		log.setRequestUrl(request.getServletPath());
		Object params = null;

		switch (operationType) {
		case "2":// 新增
			params = CommonUtils.objToMap(args[0]);
			break;
		case "3":// 更新
			params = CommonUtils.objToMap(args[0]);
			break;
		case "4":// 删除
			if (args[0] instanceof Object[]) {// 批量删除
				Object[] ids = (Object[]) args[0];
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				for (Object id : ids) {
					list.add(baseService.findNoTrans(operateClass.value(), id));
				}
				params = list;
			} else {
				params = baseService.findNoTrans(operateClass.value(), args[0]);
			}
			break;
		case "5":// 保存
			params = CommonUtils.objToMap(args[0]);
			break;
		}
		if (operateClass != null) {
			log.setTableName(baseService.getTable(operateClass.value()));
		}
		log.setUpdateParams(params != null ? JSONUtils.toJSONString(params) : null);
		baseService.insert(log);
	}
}
