package com.foo.manage;

import java.util.LinkedHashMap;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;

import com.foo.manage.common.redis.ShiroRedisCacheManager;
import com.foo.manage.modules.sys.realm.UserRealm;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Configuration
public class ShiroConfig {
	@Bean
	public ShiroRedisCacheManager shiroRedisCacheManager(RedisTemplate redisTemplate) {
		ShiroRedisCacheManager redisCacheManager = new ShiroRedisCacheManager(redisTemplate);
		// name是key的前缀，可以设置任何值，无影响，可以设置带项目特色的值
		redisCacheManager.createCache("shiro_redis");
		return redisCacheManager;
	}

	@Bean
	public UserRealm userRealm(RedisTemplate redisTemplate) {
		UserRealm userRealm = new UserRealm();
		// 设置缓存管理器
		userRealm.setCacheManager(shiroRedisCacheManager(redisTemplate));
		
		// 加密设置
		HashedCredentialsMatcher credentialsMatcher = new HashedCredentialsMatcher();
		credentialsMatcher.setHashAlgorithmName("MD5");
		credentialsMatcher.setHashIterations(1024);
		// 设置认证密码算法及迭代复杂度
		userRealm.setCredentialsMatcher(credentialsMatcher);
		userRealm.setCachingEnabled(true);
		// 认证
		userRealm.setAuthenticationCachingEnabled(false);
		// 授权
		userRealm.setAuthorizationCachingEnabled(false);
		return userRealm;
	}

	@Bean
	SecurityManager securityManager(RedisTemplate redisTemplate) {
		DefaultWebSecurityManager manager = new DefaultWebSecurityManager();
		manager.setRealm(userRealm(redisTemplate));
		manager.setCacheManager(shiroRedisCacheManager(redisTemplate));
		return manager;
	}

	@Bean
	ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		shiroFilterFactoryBean.setSecurityManager(securityManager);
		shiroFilterFactoryBean.setLoginUrl("/loginPage");
		shiroFilterFactoryBean.setSuccessUrl("/");
		shiroFilterFactoryBean.setUnauthorizedUrl("/403");
		LinkedHashMap<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();
		filterChainDefinitionMap.put("/login", "anon");
		filterChainDefinitionMap.put("/exit", "anon");
		filterChainDefinitionMap.put("/favicon.ico", "anon");
		filterChainDefinitionMap.put("/static/**", "anon");
		filterChainDefinitionMap.put("/**/list", "anon");
		filterChainDefinitionMap.put("/**/exportData", "anon");
		filterChainDefinitionMap.put("/**", "authc");

		shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
		return shiroFilterFactoryBean;
	}

	@Bean
	public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(@Qualifier("securityManager") SecurityManager securityManager) {
		AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
		authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
		return authorizationAttributeSourceAdvisor;
	}
}
