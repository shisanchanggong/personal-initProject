package com.foo.manage;

import java.util.Properties;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

import com.foo.manage.common.filter.XSSFilter;
import com.foo.manage.common.utils.SpringContextUtil;
import com.github.pagehelper.PageHelper;

@MapperScan(basePackages = "com.foo.manage")
@SpringBootApplication
public class ManageApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		ApplicationContext app = SpringApplication.run(ManageApplication.class, args);
		SpringContextUtil.setApplicationContext(app);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(ManageApplication.class);
	}

	// 配置mybatis的分页插件pageHelper
	@Bean
	public PageHelper pageHelper() {
		PageHelper pageHelper = new PageHelper();
		Properties properties = new Properties();
		properties.setProperty("offsetAsPageNum", "true");
		properties.setProperty("rowBoundsWithCount", "true");
		properties.setProperty("reasonable", "true");
		properties.setProperty("dialect", "mysql"); // 配置mysql数据库的方言
		pageHelper.setProperties(properties);
		return pageHelper;
	}

	// 配置xssFilter
	@Bean
	public FilterRegistrationBean MyFilterRegistration() {
		FilterRegistrationBean registration = new FilterRegistrationBean();
		registration.setFilter(new XSSFilter());
		registration.addUrlPatterns("/*");
		registration.addInitParameter("paramName", "paramValue");
		registration.setName("xssFilter");
		registration.setOrder(1);
		return registration;
	}

}