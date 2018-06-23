package com.foo.manage.common.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 * 公共 工具类
 * @author changzhongq
 * @time 2018年6月23日 上午10:56:53
 */
public class CommonUtils {
	/**
	 * hashmap 转为 obj
	 * @param clazz 类类型
	 * @param map属性
	 * @return object属性
	 */
	public static Object hashMapToObj(Class<?> clazz, HashMap<String, Object> map) {
		Object obj = null;
		try {
			obj = clazz.newInstance();
		} catch (InstantiationException e1) {
			e1.printStackTrace();
		} catch (IllegalAccessException e1) {
			e1.printStackTrace();
		}
		Class<?> objClazz = obj.getClass();
		for (Map.Entry<String, Object> entry : map.entrySet()) {
			try {
				Field field = objClazz.getDeclaredField(StringUtils.camelCaseName(entry.getKey()));
				field.setAccessible(true);
				try {
					field.set(obj, entry.getValue());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
			} catch (NoSuchFieldException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			}
		}

		return obj;
	}

	/**
	 * hashMap 集合转为 对象集合
	 * @param clazz 类类型
	 * @param list map属性的list集合
	 * @return object属性的list集合
	 */
	public static List<Object> listMapToObj(Class<?> clazz, List<HashMap<String, Object>> list) {
		List<Object> listObj = new ArrayList<Object>();
		for (HashMap<String, Object> hashMap : list) {
			Object obj = hashMapToObj(clazz, hashMap);
			listObj.add(obj);
		}
		return listObj;
	}

	/**
	 * map转为数据库字段和值
	 * @param map 需要转换的map数据
	 * @return 字段属性值数组
	 */
	public static List<com.foo.manage.common.base.Field> mapToField(Map<String, Object> map) {
		List<com.foo.manage.common.base.Field> fields = new ArrayList<com.foo.manage.common.base.Field>();
		for (Entry<String, Object> entry : map.entrySet()) {
			String fieldName = entry.getKey();
			Object fieldValue = entry.getValue();
			com.foo.manage.common.base.Field field = new com.foo.manage.common.base.Field();
			field.setCloumn(StringUtils.underUpperScoreName(fieldName));
			field.setValue(fieldValue);
			fields.add(field);
		}
		return fields;
	}
	
	/**
	 * object对象到map的转换
	 * @param obj object对象
	 * @return map集合
	 */
	public static Map<String, Object> objToMap(Object obj){
		Map<String, Object> map = new HashMap<>();
		Class<?> clazz = obj.getClass();
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields) {
			String fieldName = field.getName();
			if ("serialVersionUID".equals(fieldName)) {
				continue;
			}
			field.setAccessible(true);
			try {
				map.put(fieldName, field.get(obj));
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return map;
	}

}
