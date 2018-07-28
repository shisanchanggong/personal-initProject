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
	 * 环绕触发
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
				Object[] args = joinPoint.getArgs();
				BaseService baseService = (BaseService) SpringContextUtil.getBean(BaseService.class);
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
				if (operateClass != null ) {
					log.setTableName(baseService.getTable(operateClass.value()));
				}
				log.setUpdateParams(params != null ? JSONUtils.toJSONString(params) : null);
				baseService.insert(log);
			}
		}
		return joinPoint.proceed();
	}
}
