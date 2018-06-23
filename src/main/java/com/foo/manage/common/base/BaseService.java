package com.foo.manage.common.base;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.foo.manage.common.utils.CommonUtils;
import com.foo.manage.common.utils.LimitParams;
import com.foo.manage.common.utils.PageRequest;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.common.utils.StringUtils;
import com.foo.manage.common.utils.UUIDUtils;

/**
 * 基础服务类
 * 
 * @author quchangzhong
 * @time 2018年1月19日 下午7:54:24
 */
@SuppressWarnings("unchecked")
public abstract class BaseService {

	@Autowired
	private BaseDao baseDao;

	/**
	 * 通过ID 获取记录信息
	 * @param clazz
	 * @param id
	 */
	public <T> T find(Class<?> clazz, Object id) {
		String table = getTable(clazz);
		String idColumn = getIdColumn(clazz);
		HashMap<String, Object> map = baseDao.find(table, getColumnsStr(clazz), idColumn, id);
		if (map == null) {
			return null;
		}
		return (T) CommonUtils.hashMapToObj(clazz, map);
	}

	public Map<String, Object> findNoTrans(Class<?> clazz, Object id) {
		String table = getTable(clazz);
		String idColumn = getIdColumn(clazz);
		HashMap<String, Object> map = baseDao.find(table, getColumnsStr(clazz), idColumn, id);
		Map<String, Object> transMap = new HashMap<>();
		for (Entry<String, Object> entry : map.entrySet()) {
			String key = entry.getKey();
			Object value = entry.getValue();
			transMap.put(StringUtils.camelCaseName(key), value);
		}
		return transMap;
	}

	/**
	 * 通过属性值 获取记录信息
	 * @param clazz
	 * @param fieldName 属性名
	 * @param fieldValue 属性值
	 */
	public <T> List<T> findBy(Class<?> clazz, String fieldName, Object fieldValue) {
		String table = getTable(clazz);
		String cloumn = StringUtils.underUpperScoreName(fieldName);
		List<HashMap<String, Object>> list = baseDao.findBy(table, getColumnsStr(clazz), cloumn, fieldValue);
		if (list == null || list.size() <= 0) {
			return null;
		}
		return (List<T>) CommonUtils.listMapToObj(clazz, list);
	}

	public <T> List<T> findBy(Class<?> clazz, Map<String, Object> map) {
		String table = getTable(clazz);
		List<com.foo.manage.common.base.Field> fields = CommonUtils.mapToField(map);
		List<HashMap<String, Object>> list = baseDao.findByFieldList(table, getColumnsStr(clazz), fields);
		if (list == null || list.size() <= 0) {
			return null;
		}
		return (List<T>) CommonUtils.listMapToObj(clazz, list);
	}

	public <T> List<T> findBy(Class<?> clazz, PageRequest pageReq, Map<String, Object> map) {
		String table = getTable(clazz);
		List<com.foo.manage.common.base.Field> fields = CommonUtils.mapToField(map);
		List<HashMap<String, Object>> list = baseDao.findByFieldList(table, getColumnsStr(clazz), fields, new LimitParams(pageReq));
		if (list == null || list.size() <= 0) {
			return null;
		}
		return (List<T>) CommonUtils.listMapToObj(clazz, list);
	}

	/**
	 * 模糊方式的数据查询
	 * @param clazz 类类型
	 * @param pageReq 分页参数
	 * @param map 过滤条件
	 */
	public <T> List<T> findByLike(Class<?> clazz, PageRequest pageReq, Map<String, Object> map) {
		String table = getTable(clazz);
		List<com.foo.manage.common.base.Field> fields = CommonUtils.mapToField(map);
		List<HashMap<String, Object>> list = baseDao.findByFieldListLike(table, getColumnsStr(clazz), fields, new LimitParams(pageReq));
		if (list == null || list.size() <= 0) {
			return null;
		}
		return (List<T>) CommonUtils.listMapToObj(clazz, list);
	}

	/**
	 * 查询所有记录
	 * @param clazz 类类型
	 */
	public <T> List<T> findAll(Class<?> clazz) {
		String table = getTable(clazz);
		List<HashMap<String, Object>> list = baseDao.findAll(table, getColumnsStr(clazz));
		if (list == null || list.size() <= 0) {
			return null;
		}
		return (List<T>) CommonUtils.listMapToObj(clazz, list);
	}

	/**
	 * 查询所有记录 （带分页信息）
	 * @param clazz 类类型
	 * @param pageReq 分页参数
	 */
	public <T> List<T> findAll(Class<?> clazz, PageRequest pageReq) {
		String table = getTable(clazz);
		List<HashMap<String, Object>> list = baseDao.findAll(table, getColumnsStr(clazz), new LimitParams(pageReq));
		if (list == null || list.size() <= 0) {
			return null;
		}
		return (List<T>) CommonUtils.listMapToObj(clazz, list);
	}

	/**
	 * 添加记录 成功返回主键Id 失败返回null
	 * @param model
	 */
	public Object insert(Object model) {
		Class<?> clazz = model.getClass();
		String table = getTable(clazz);
		Field[] fields = clazz.getDeclaredFields();
		// 存储需要更新的字段，用逗号隔开
		StringBuilder cloumns = new StringBuilder();
		List<Object> lists = new ArrayList<Object>();
		Object idValue = null;
		for (Field field : fields) {
			String fieldName = field.getName();
			if ("serialVersionUID".equals(fieldName)) {
				continue;
			}
			cloumns.append(StringUtils.underUpperScoreName(fieldName)).append(",");
			Object fieldValue = null;
			// 设置可见性
			field.setAccessible(true);
			try {
				fieldValue = field.get(model);
				if (StringUtils.isEmpty(fieldValue) && field.getAnnotation(Id.class) != null) {
					idValue = fieldValue = UUIDUtils.getUUID();
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
			lists.add(fieldValue);
		}
		return baseDao.insert(table, cloumns.toString().substring(0, cloumns.toString().length() - 1), lists) == 1 ? idValue : null;
	}

	/**
	 * 批量添加
	 * @param models
	 */
	@Transactional
	public boolean batchInsert(Object[] models) {
		for (Object model : models) {
			Object insert = insert(model);
			if (insert == null) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 更新记录
	 * @param model
	 */
	public boolean update(Object model) {
		Class<?> clazz = model.getClass();
		String table = getTable(clazz);
		Field[] fields = clazz.getDeclaredFields();
		List<com.foo.manage.common.base.Field> lists = new ArrayList<com.foo.manage.common.base.Field>();
		// ID字段属性和值，用在where条件后面
		com.foo.manage.common.base.Field idField = new com.foo.manage.common.base.Field();
		for (Field field : fields) {
			com.foo.manage.common.base.Field f = new com.foo.manage.common.base.Field();
			String fieldName = field.getName();
			if ("serialVersionUID".equals(fieldName)) {
				continue;
			}
			String cloumn = StringUtils.underUpperScoreName(fieldName);
			// 设置字段和属性值
			f.setCloumn(cloumn);
			// 设置可见性
			field.setAccessible(true);
			try {
				f.setValue(field.get(model));
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
			// 如果此字段为ID字段则存入idField，否则加入带更新字段集合中
			if (field.getAnnotation(Id.class) != null) {
				idField = f;
			} else {
				lists.add(f);
			}
		}
		return baseDao.update(table, lists, idField) >= 0;
	}

	/**
	 * 批量更新
	 * @param models
	 */
	@Transactional
	public boolean batchUpdate(Object[] models) {
		for (Object model : models) {
			boolean update = update(model);
			if (update == false) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 根据ID删除记录
	 */
	public boolean delete(Class<?> clazz, Object id) {
		if (StringUtils.isEmpty(id)) {
			throw new RuntimeException("id不能为空！");
		}
		String idColumn = getIdColumn(clazz);
		String table = getTable(clazz);
		return baseDao.delete(table, idColumn, id) >= 0;
	}

	/**
	 * 根据字段值删除记录
	 * @param fieldName
	 * @param fieldValue
	 */
	public boolean deleteBy(Class<?> clazz, String fieldName, Object fieldValue) {
		String table = getTable(clazz);
		return baseDao.deleteBy(table, StringUtils.underUpperScoreName(fieldName), fieldValue) >= 0;
	}

	/**
	 * 通过属性删除记录
	 * @param clazz 类类型
	 * @param map 属性值
	 */
	public boolean deleteBy(Class<?> clazz, Map<String, Object> map) {
		String table = getTable(clazz);
		List<com.foo.manage.common.base.Field> fields = CommonUtils.mapToField(map);
		return baseDao.deleteByFieldList(table, fields) >= 0;
	}

	/**
	 * 批量删除记录
	 * @param clazz 类类型
	 * @param ids id数组
	 */
	public boolean batchDelete(Class<?> clazz, Object[] ids) {
		String idColumn = getIdColumn(clazz);
		String table = getTable(clazz);
		return baseDao.batchDelete(table, idColumn, ids) == ids.length;
	}

	/**
	 * 总记录数
	 * @param clazz 类类型
	 */
	public Long count(Class<?> clazz) {
		String table = getTable(clazz);
		return baseDao.count(table);
	}

	/**
	 * 条件记录数
	 * @param clazz 类类型
	 * @param fieldName 过滤属性名称
	 * @param fieldValue 属性值
	 */
	public Long count(Class<?> clazz, String fieldName, Object fieldValue) {
		String table = getTable(clazz);
		return baseDao.countBy(table, StringUtils.underUpperScoreName(fieldName), fieldValue);
	}

	/**
	 * 条件记录数
	 * @param clazz 类类型
	 */
	public Long countBy(Class<?> clazz, Map<String, Object> map) {
		String table = getTable(clazz);
		List<com.foo.manage.common.base.Field> fields = CommonUtils.mapToField(map);
		return baseDao.countByFieldList(table, fields);
	}

	/**
	 * 模糊方式的总数查询
	 * @param clazz 类类型
	 * @param map 过滤条件
	 */
	public Long countByLike(Class<?> clazz, Map<String, Object> map) {
		String table = getTable(clazz);
		List<com.foo.manage.common.base.Field> fields = CommonUtils.mapToField(map);
		return baseDao.countByFieldListLike(table, fields);
	}

	/**
	 * 获取表名
	 * @param clazz 类类型
	 */
	public String getTable(Class<?> clazz) {
		String simpleName = clazz.getSimpleName();
		Table tableAnnotation = clazz.getAnnotation(Table.class);
		String table = null;
		// 如果实体类上有注解，则从注解中获取表名，没有则使用类名驼峰大写转下划线名称（如：AbcDef：ABC_DEF）
		if (tableAnnotation == null) {
			table = StringUtils.underUpperScoreName((simpleName));
		} else {
			table = tableAnnotation.name();
		}
		return table;
	}

	/**
	 * 获取ID字段值 格式 CREATE_USER_ID
	 * @param clazz 类类型
	 */
	private String getIdColumn(Class<?> clazz) {
		String idColumn = null;
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields) {
			if (field.getAnnotation(Id.class) != null) {
				idColumn = StringUtils.underUpperScoreName(field.getName());
				break;
			}
		}
		return idColumn;
	}

	/**
	 * 新增或更新
	 * @param classT 类类型
	 * @param data 实体数据
	 */
	public ServiceResult insertOrUpdate(Class<?> clazz, Object data) {
		ServiceResult serviceResult = new ServiceResult();
		Field[] fields = clazz.getDeclaredFields();
		Object idValue = new Object();
		for (Field field : fields) {
			if (field.getAnnotation(Id.class) != null) {
				field.setAccessible(true);
				try {
					idValue = field.get(data);
				} catch (IllegalArgumentException | IllegalAccessException e) {
					e.printStackTrace();
				}
				break;
			}
		}
		Object obj = find(clazz, idValue);
		if (obj != null) {
			boolean update = update(data);
			serviceResult.setIsSuccess(update);
			serviceResult.setBusinessObject(data);
			return serviceResult;
		}
		Object id = insert(data);
		if (id != null) {
			serviceResult.setIsSuccess(true);
			serviceResult.setBusinessObject(id);
		}
		return serviceResult;
	}

	/*
	 * 获取表所有字段字符串
	 */
	private String getColumnsStr(Class<?> clazz) {
		StringBuilder columnsSb = new StringBuilder();
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields) {
			String fieldName = field.getName();
			if ("serialVersionUID".equals(fieldName)) {
				continue;
			}
			columnsSb.append(StringUtils.underUpperScoreName(fieldName));
			columnsSb.append(",");
		}
		return columnsSb.deleteCharAt(columnsSb.length() - 1).toString();
	}

}
