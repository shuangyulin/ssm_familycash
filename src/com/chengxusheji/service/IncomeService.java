package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.IncomeType;
import com.chengxusheji.po.PayWay;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Income;

import com.chengxusheji.mapper.IncomeMapper;
@Service
public class IncomeService {

	@Resource IncomeMapper incomeMapper;
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

    /*添加收入记录*/
    public void addIncome(Income income) throws Exception {
    	incomeMapper.addIncome(income);
    }

    /*按照查询条件分页查询收入记录*/
    public ArrayList<Income> queryIncome(IncomeType incomeTypeObj,String incomeFrom,PayWay payWayObj,String payAccount,String incomeDate,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != incomeTypeObj && incomeTypeObj.getTypeId()!= null && incomeTypeObj.getTypeId()!= 0)  where += " and t_income.incomeTypeObj=" + incomeTypeObj.getTypeId();
    	if(!incomeFrom.equals("")) where = where + " and t_income.incomeFrom like '%" + incomeFrom + "%'";
    	if(null != payWayObj && payWayObj.getPayWayId()!= null && payWayObj.getPayWayId()!= 0)  where += " and t_income.payWayObj=" + payWayObj.getPayWayId();
    	if(!payAccount.equals("")) where = where + " and t_income.payAccount like '%" + payAccount + "%'";
    	if(!incomeDate.equals("")) where = where + " and t_income.incomeDate like '%" + incomeDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_income.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return incomeMapper.queryIncome(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Income> queryIncome(IncomeType incomeTypeObj,String incomeFrom,PayWay payWayObj,String payAccount,String incomeDate,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != incomeTypeObj && incomeTypeObj.getTypeId()!= null && incomeTypeObj.getTypeId()!= 0)  where += " and t_income.incomeTypeObj=" + incomeTypeObj.getTypeId();
    	if(!incomeFrom.equals("")) where = where + " and t_income.incomeFrom like '%" + incomeFrom + "%'";
    	if(null != payWayObj && payWayObj.getPayWayId()!= null && payWayObj.getPayWayId()!= 0)  where += " and t_income.payWayObj=" + payWayObj.getPayWayId();
    	if(!payAccount.equals("")) where = where + " and t_income.payAccount like '%" + payAccount + "%'";
    	if(!incomeDate.equals("")) where = where + " and t_income.incomeDate like '%" + incomeDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_income.userObj='" + userObj.getUser_name() + "'";
    	return incomeMapper.queryIncomeList(where);
    }

    /*查询所有收入记录*/
    public ArrayList<Income> queryAllIncome()  throws Exception {
        return incomeMapper.queryIncomeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(IncomeType incomeTypeObj,String incomeFrom,PayWay payWayObj,String payAccount,String incomeDate,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != incomeTypeObj && incomeTypeObj.getTypeId()!= null && incomeTypeObj.getTypeId()!= 0)  where += " and t_income.incomeTypeObj=" + incomeTypeObj.getTypeId();
    	if(!incomeFrom.equals("")) where = where + " and t_income.incomeFrom like '%" + incomeFrom + "%'";
    	if(null != payWayObj && payWayObj.getPayWayId()!= null && payWayObj.getPayWayId()!= 0)  where += " and t_income.payWayObj=" + payWayObj.getPayWayId();
    	if(!payAccount.equals("")) where = where + " and t_income.payAccount like '%" + payAccount + "%'";
    	if(!incomeDate.equals("")) where = where + " and t_income.incomeDate like '%" + incomeDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_income.userObj='" + userObj.getUser_name() + "'";
        recordNumber = incomeMapper.queryIncomeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取收入记录*/
    public Income getIncome(int incomeId) throws Exception  {
        Income income = incomeMapper.getIncome(incomeId);
        return income;
    }

    /*更新收入记录*/
    public void updateIncome(Income income) throws Exception {
        incomeMapper.updateIncome(income);
    }

    /*删除一条收入记录*/
    public void deleteIncome (int incomeId) throws Exception {
        incomeMapper.deleteIncome(incomeId);
    }

    /*删除多条收入信息*/
    public int deleteIncomes (String incomeIds) throws Exception {
    	String _incomeIds[] = incomeIds.split(",");
    	for(String _incomeId: _incomeIds) {
    		incomeMapper.deleteIncome(Integer.parseInt(_incomeId));
    	}
    	return _incomeIds.length;
    }
}
