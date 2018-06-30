package com.foo.manage.common.base;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foo.manage.common.utils.LimitParams;

/**
 * 基础dao类
 * 
 * @author quchangzhong
 * @time 2018年1月19日 下午7:53:45
 */
public interface BaseDao {
	/**
	 * 新增
	 * @param table 表名
	 * @param cloumns 字段名
	 * @param list 字段对应的值
	 * @return
	 */
	int insert(@Param("table") String table, @Param("cloumns") String cloumns, @Param("list") List<Object> list);

	/**
	 * 单个删除
	 * @param table
	 * @param fieldName
	 * @param fieldValue
	 * @return
	 */
	int delete(@Param("table") String table, @Param("fieldName") String fieldName, @Param("fieldValue") Object fieldValue);

	/**
	 * 通过特定字段删除
	 * @param table
	 * @param fieldName
	 * @param fieldValue
	 * @return
	 */
	int deleteBy(@Param("table") String table, @Param("fieldName") String fieldName, @Param("fieldValue") Object fieldValue);

	int deleteByFieldList(@Param("table") String table, @Param("list") List<Field> fields);
	
	/**
	 * 批量删除记录
	 * @param table
	 * @param idCloumn
	 * @param ids
	 * @return
	 */
	int batchDelete(@Param("table") String table, @Param("idCloumn") String idCloumn, @Param("ids") Object[] ids);

	/**
	 * 更新
	 * @param table
	 * @param list
	 * @param idField
	 * @return
	 */
	int update(@Param("table") String table, @Param("list") List<Field> list, @Param("idField") Field idField);

	/**
	 * 通过id查询记录
	 * @param table 表名
	 * @param fieldName ID字段名
	 * @param id id值
	 * @return
	 */
	HashMap<String, Object> find(@Param("table") String table, @Param("columnsStr") String columnsStr, @Param("fieldName") String fieldName, @Param("id") Object id);

	/**
	 * 通过特定字段查询记录
	 * @param table
	 * @param cloumn
	 * @param fieldValue
	 * @return
	 */
	List<HashMap<String, Object>> findBy(@Param("table") String table, @Param("columnsStr") String columnsStr, @Param("cloumn") String cloumn, @Param("fieldValue") Object fieldValue);

	/**
	 * 查询所有记录
	 * @param table
	 * @param pageReq
	 * @return
	 */
	List<HashMap<String, Object>> findAll(@Param("table") String table, @Param("columnsStr") String columnsStr);

	List<HashMap<String, Object>> findAll(@Param("table") String table, @Param("columnsStr") String columnsStr, @Param("limitParams") LimitParams limitParams);

	List<HashMap<String, Object>> findByFieldList(@Param("table") String table, @Param("columnsStr") String columnsStr, @Param("list") List<Field> fields);

	List<HashMap<String, Object>> findByFieldList(@Param("table") String table, @Param("columnsStr") String columnsStr, @Param("list") List<Field> fields, @Param("limitParams") LimitParams limitParams);

	List<HashMap<String, Object>> findByFieldListLike(@Param("table") String table, @Param("columnsStr") String columnsStr, @Param("list") List<Field> fields, @Param("limitParams") LimitParams limitParams);

	/**
	 * 查询总记录数
	 * @param table
	 * @return
	 */
	long count(@Param("table") String table);

	long countBy(@Param("table") String table, @Param("cloumn") String cloumn, @Param("fieldValue") Object fieldValue);

	long countByFieldList(@Param("table") String table, @Param("list") List<Field> fields);

	long countByFieldListLike(@Param("table") String table, @Param("list") List<Field> fields);

}
