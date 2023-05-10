package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Expend;

public interface ExpendMapper {
	/*添加支出信息*/
	public void addExpend(Expend expend) throws Exception;

	/*按照查询条件分页查询支出记录*/
	public ArrayList<Expend> queryExpend(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有支出记录*/
	public ArrayList<Expend> queryExpendList(@Param("where") String where) throws Exception;

	/*按照查询条件的支出记录数*/
	public int queryExpendCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条支出记录*/
	public Expend getExpend(int expendId) throws Exception;

	/*更新支出记录*/
	public void updateExpend(Expend expend) throws Exception;

	/*删除支出记录*/
	public void deleteExpend(int expendId) throws Exception;

}
