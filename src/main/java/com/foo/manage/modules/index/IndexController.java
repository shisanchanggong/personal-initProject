package com.foo.manage.modules.index;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foo.manage.common.aop.OperateLog;
import com.foo.manage.common.base.BaseService;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.common.utils.UUIDUtils;
import com.foo.manage.modules.sys.entity.User;
import com.foo.manage.modules.sys.service.MenuService;

/**
 * 首页
 * @author quchangzhong
 * @time 2018年5月19日 上午10:54:23
 */
@Controller
public class IndexController {

	@Autowired
	private BaseService baseService;

	@Autowired
	private MenuService menuService;

	/**
	 * 登录成功，进入首页，导入菜单数据
	 * @return
	 */
	@RequestMapping("/")
	@OperateLog(operationType = "0", operationName = "进入系统")
	public String index(Model model) {
		model.addAttribute("menuTrees", menuService.menuTreesData());
		return "index";
	}

	@RequestMapping("/index1")
	public String index1() {
		return "index1";
	}

	@RequestMapping("/loginPage")
	public String loginPage() {
		return "login";
	}

	/**
	 * 根据登录名和密码验证用户信息
	 * @param user
	 * @return
	 */
	@ResponseBody
	@GetMapping("/login")
	public ServiceResult findByLoginNameAndPassword(User user) {
		UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginName(), user.getLoginPassword());
		Subject subject = SecurityUtils.getSubject();
		ServiceResult serviceResult = new ServiceResult();
		try {
			subject.getSession().setTimeout(60 * 30 * 1000);
			subject.login(token);
			serviceResult.setIsSuccess(true);
			return serviceResult;
		} catch (AuthenticationException e) {
			e.printStackTrace();
			serviceResult.setIsSuccess(false);
			serviceResult.setMessage(e.getMessage());
			return serviceResult;
		}
	}

	/**
	 * 退出，返回登录界面
	 * @return
	 */
	@OperateLog(operationType = "-1", operationName = "退出系统")
	@GetMapping("/exit")
	public String exit() {
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "redirect:loginPage";
	}

	@RequestMapping("/testBatchInsert")
	public void testBatchInsert() {
		List<User> users = new ArrayList<User>();
		for (int i = 0; i < 10; i++) {
			User user = new User();
			user.setUserId(UUIDUtils.getUUID());
			user.setUserName("test" + i);
			users.add(user);
		}
		baseService.batchInsert(users.toArray());
	}
	
	public static void main(String[] args) throws IOException {
		URL url = new URL("http://localhost:8080/manage/user/list?page=1&rows=9999");
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.connect();
		BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		StringBuilder result = new StringBuilder();
		String line = "";
		while ((line = br.readLine()) != null) {
			result.append(line);
		}
		br.close();
		connection.disconnect();
		System.out.println(result.toString());
	}
}
