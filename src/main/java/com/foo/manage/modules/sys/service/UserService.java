package com.foo.manage.modules.sys.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foo.manage.common.base.BaseService;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.common.utils.StringUtils;
import com.foo.manage.common.utils.SubjectUtils;
import com.foo.manage.common.utils.TimeUtils;
import com.foo.manage.common.utils.UUIDUtils;
import com.foo.manage.modules.sys.dao.UserMapper;
import com.foo.manage.modules.sys.entity.CurrentUser;
import com.foo.manage.modules.sys.entity.User;

/**
 * 用户 Service
 * @author changzhongq
 * @time 2018年6月17日 下午3:27:55
 */
@Service
public class UserService extends BaseService {

	@Autowired
	private UserMapper userMapper;
	
	/**
	 * 保存（新增或更新）
	 * @param user 用户信息
	 */
	public ServiceResult save(User user) {
		if (StringUtils.isEmpty(user.getLoginPassword())) {
			String loginPassword = SubjectUtils.md5Encrypt(user.getUserName(), "111111");
			user.setLoginPassword(loginPassword);
		}
		return this.insertOrUpdate(User.class, user);
	}

	/**
	 * 验证登录名唯一性
	 */
	public ServiceResult validateLoginName(String loginName) {
		if (this.findBy(User.class, "loginName", loginName) == null) {// 登录名不存在，可以使用
			return ServiceResult.newOkInstance("恭喜您，此登录名可以使用。", null);
		} else {// 登录名存在，验证失败
			return ServiceResult.newErrorInstance("登录名已经存在，请更换！");
		}
	}

	/**
	 * 导入用户信息
	 */
	public ServiceResult improtExcel(InputStream inputStream) throws EncryptedDocumentException, InvalidFormatException, IOException {
		List<User> users = new ArrayList<User>();

		Workbook workbook = WorkbookFactory.create(inputStream);
		if (workbook == null) {
			throw new RuntimeException("工作簿为空！");
		}
		Sheet sheet = null;
		Row row = null;
		// 记录存在的登录名，用于提示信息
		StringBuilder sb = new StringBuilder();
		int errorLoginNameCount = 0;
		// 记录Excel中总记录数
		int excelSumRecord = 0;
		// 遍历所有sheet
		for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
			sheet = workbook.getSheetAt(i);
			if (sheet == null) {
				continue;
			}
			int lastRowNum = sheet.getLastRowNum();
			excelSumRecord = excelSumRecord + lastRowNum;
			// 遍历当前sheet中所有的行数据
			for (int j = 1; j < lastRowNum + 1; j++) {
				row = sheet.getRow(j);
				if (row == null) {
					continue;
				}
				Cell userNameCell = row.getCell(0);
				Cell loginNameCell = row.getCell(1);
				if (StringUtils.isEmpty(loginNameCell)) {
					return ServiceResult.newErrorInstance("登录名不能为空！请仔细检查模板中是否有登录名为空的情况！");
				}
				String loginName = String.valueOf(loginNameCell);
				if (this.findBy(User.class, "loginName", loginName) != null) {// 登录名已存在
					errorLoginNameCount++;
					sb.append("【");
					sb.append(loginName);
					sb.append("】");
				} else {// 登录名不存在的插入数据
					Cell LoginPasswordCell = row.getCell(2);
					Cell userSexCell = row.getCell(3);
					Cell remarkSex = row.getCell(4);
					// 赋值
					User user = new User();
					user.setUserId(UUIDUtils.getUUID());
					user.setUserName(StringUtils.isEmpty(userNameCell) ? "" : String.valueOf(userNameCell));
					user.setLoginName(loginName);
					user.setLoginPassword(StringUtils.isEmpty(LoginPasswordCell) ? "" : SubjectUtils.md5Encrypt(user.getUserName(), String.valueOf(LoginPasswordCell)));
					user.setUserSex(StringUtils.isEmpty(userSexCell) ? "" : ("男".equals(String.valueOf(userSexCell)) ? "M" : "F"));
					user.setRemark(StringUtils.isEmpty(remarkSex) ? "" : String.valueOf(remarkSex));
					user.setLocked("1");
					user.setCreateTime(TimeUtils.getTimestamp());
					CurrentUser currentUser = SubjectUtils.getUser();
					user.setCreateUserId(currentUser.getUserId());
					user.setCreateUserName(currentUser.getUserName());
					users.add(user);
				}
			}
		}
		int insertSize = users.size();
		List<Object> batchInsert = this.batchInsert(users.toArray());
		if (batchInsert != null && batchInsert.size() == insertSize || batchInsert == null) {
			String errorLoginName = sb.toString();
			return ServiceResult.newOkInstance(
					"共发现 " + excelSumRecord + " 条数据，成功导入 " + insertSize + " 条！" + (errorLoginNameCount == 0 ? "" : "登录名已存在的记录：" + errorLoginName + "共 " + errorLoginNameCount + " 条！"), batchInsert);
		}
		return ServiceResult.newErrorInstance("导入失败，请检查Excel模板是否最新或是否有误！");
	}

	/**
	 * 用户导出
	 */
	public List<User> exportUserData(Map<String, Object> paramMap) {
		return userMapper.exportUserData(paramMap);
	}

}
