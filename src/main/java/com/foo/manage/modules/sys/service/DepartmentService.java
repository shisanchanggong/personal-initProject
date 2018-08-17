package com.foo.manage.modules.sys.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foo.manage.common.base.BaseService;
import com.foo.manage.modules.sys.entity.Department;

/**
 * 部门 Service
 * @author changzhongq
 * @time 2018年6月17日 下午3:27:55
 */
@Service
public class DepartmentService extends BaseService implements DepartmentInterface {

	@Override
	@Transactional
	public void testTransactional() {
		this.delete(Department.class, "c3942dac-2a5a-4bc9-a5e3-065d2c019652");
		throw new RuntimeException();
	}
	
}
