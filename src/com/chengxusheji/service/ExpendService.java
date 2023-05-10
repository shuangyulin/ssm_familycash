package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ExpendType;
import com.chengxusheji.po.PayWay;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Expend;

import com.chengxusheji.mapper.ExpendMapper;
@Service
public class ExpendService {

	@Resource ExpendMapper expendMapper;
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

    /*添加支出记录*/
    public void addExpend(Expend expend) throws Exception {
    	expendMapper.addExpend(expend);
    }

    /*按照查询条件分页查询支出记录*/
    public ArrayList<Expend> queryExpend(ExpendType exprendTypeObj,String expendPurpose,PayWay payWayObj,String payAccount,String expendDate,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != exprendTypeObj && exprendTypeObj.getExpendTypeId()!= null && exprendTypeObj.getExpendTypeId()!= 0)  where += " and t_expend.exprendTypeObj=" + exprendTypeObj.getExpendTypeId();
    	if(!expendPurpose.equals("")) where = where + " and t_expend.expendPurpose like '%" + expendPurpose + "%'";
    	if(null != payWayObj && payWayObj.getPayWayId()!= null && payWayObj.getPayWayId()!= 0)  where += " and t_expend.payWayObj=" + payWayObj.getPayWayId();
    	if(!payAccount.equals("")) where = where + " and t_expend.payAccount like '%" + payAccount + "%'";
    	if(!expendDate.equals("")) where = where + " and t_expend.expendDate like '%" + expendDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_expend.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return expendMapper.queryExpend(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Expend> queryExpend(ExpendType exprendTypeObj,String expendPurpose,PayWay payWayObj,String payAccount,String expendDate,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != exprendTypeObj && exprendTypeObj.getExpendTypeId()!= null && exprendTypeObj.getExpendTypeId()!= 0)  where += " and t_expend.exprendTypeObj=" + exprendTypeObj.getExpendTypeId();
    	if(!expendPurpose.equals("")) where = where + " and t_expend.expendPurpose like '%" + expendPurpose + "%'";
    	if(null != payWayObj && payWayObj.getPayWayId()!= null && payWayObj.getPayWayId()!= 0)  where += " and t_expend.payWayObj=" + payWayObj.getPayWayId();
    	if(!payAccount.equals("")) where = where + " and t_expend.payAccount like '%" + payAccount + "%'";
    	if(!expendDate.equals("")) where = where + " and t_expend.expendDate like '%" + expendDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_expend.userObj='" + userObj.getUser_name() + "'";
    	return expendMapper.queryExpendList(where);
    }

    /*查询所有支出记录*/
    public ArrayList<Expend> queryAllExpend()  throws Exception {
        return expendMapper.queryExpendList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(ExpendType exprendTypeObj,String expendPurpose,PayWay payWayObj,String payAccount,String expendDate,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != exprendTypeObj && exprendTypeObj.getExpendTypeId()!= null && exprendTypeObj.getExpendTypeId()!= 0)  where += " and t_expend.exprendTypeObj=" + exprendTypeObj.getExpendTypeId();
    	if(!expendPurpose.equals("")) where = where + " and t_expend.expendPurpose like '%" + expendPurpose + "%'";
    	if(null != payWayObj && payWayObj.getPayWayId()!= null && payWayObj.getPayWayId()!= 0)  where += " and t_expend.payWayObj=" + payWayObj.getPayWayId();
    	if(!payAccount.equals("")) where = where + " and t_expend.payAccount like '%" + payAccount + "%'";
    	if(!expendDate.equals("")) where = where + " and t_expend.expendDate like '%" + expendDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_expend.userObj='" + userObj.getUser_name() + "'";
        recordNumber = expendMapper.queryExpendCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取支出记录*/
    public Expend getExpend(int expendId) throws Exception  {
        Expend expend = expendMapper.getExpend(expendId);
        return expend;
    }

    /*更新支出记录*/
    public void updateExpend(Expend expend) throws Exception {
        expendMapper.updateExpend(expend);
    }

    /*删除一条支出记录*/
    public void deleteExpend (int expendId) throws Exception {
        expendMapper.deleteExpend(expendId);
    }

    /*删除多条支出信息*/
    public int deleteExpends (String expendIds) throws Exception {
    	String _expendIds[] = expendIds.split(",");
    	for(String _expendId: _expendIds) {
    		expendMapper.deleteExpend(Integer.parseInt(_expendId));
    	}
    	return _expendIds.length;
    }
}
