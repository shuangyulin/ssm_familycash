package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ExpendType;

import com.chengxusheji.mapper.ExpendTypeMapper;
@Service
public class ExpendTypeService {

	@Resource ExpendTypeMapper expendTypeMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加支出类型记录*/
    public void addExpendType(ExpendType expendType) throws Exception {
    	expendTypeMapper.addExpendType(expendType);
    }

    /*按照查询条件分页查询支出类型记录*/
    public ArrayList<ExpendType> queryExpendType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return expendTypeMapper.queryExpendType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ExpendType> queryExpendType() throws Exception  { 
     	String where = "where 1=1";
    	return expendTypeMapper.queryExpendTypeList(where);
    }

    /*查询所有支出类型记录*/
    public ArrayList<ExpendType> queryAllExpendType()  throws Exception {
        return expendTypeMapper.queryExpendTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = expendTypeMapper.queryExpendTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取支出类型记录*/
    public ExpendType getExpendType(int expendTypeId) throws Exception  {
        ExpendType expendType = expendTypeMapper.getExpendType(expendTypeId);
        return expendType;
    }

    /*更新支出类型记录*/
    public void updateExpendType(ExpendType expendType) throws Exception {
        expendTypeMapper.updateExpendType(expendType);
    }

    /*删除一条支出类型记录*/
    public void deleteExpendType (int expendTypeId) throws Exception {
        expendTypeMapper.deleteExpendType(expendTypeId);
    }

    /*删除多条支出类型信息*/
    public int deleteExpendTypes (String expendTypeIds) throws Exception {
    	String _expendTypeIds[] = expendTypeIds.split(",");
    	for(String _expendTypeId: _expendTypeIds) {
    		expendTypeMapper.deleteExpendType(Integer.parseInt(_expendTypeId));
    	}
    	return _expendTypeIds.length;
    }
}
