package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ExpendType;

public interface ExpendTypeMapper {
	/*添加支出类型信息*/
	public void addExpendType(ExpendType expendType) throws Exception;

	/*按照查询条件分页查询支出类型记录*/
	public ArrayList<ExpendType> queryExpendType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有支出类型记录*/
	public ArrayList<ExpendType> queryExpendTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的支出类型记录数*/
	public int queryExpendTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条支出类型记录*/
	public ExpendType getExpendType(int expendTypeId) throws Exception;

	/*更新支出类型记录*/
	public void updateExpendType(ExpendType expendType) throws Exception;

	/*删除支出类型记录*/
	public void deleteExpendType(int expendTypeId) throws Exception;

}
