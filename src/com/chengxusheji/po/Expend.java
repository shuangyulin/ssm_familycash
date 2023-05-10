package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Expend {
    /*支出id*/
    private Integer expendId;
    public Integer getExpendId(){
        return expendId;
    }
    public void setExpendId(Integer expendId){
        this.expendId = expendId;
    }

    /*支出类型*/
    private ExpendType exprendTypeObj;
    public ExpendType getExprendTypeObj() {
        return exprendTypeObj;
    }
    public void setExprendTypeObj(ExpendType exprendTypeObj) {
        this.exprendTypeObj = exprendTypeObj;
    }

    /*支出用途*/
    @NotEmpty(message="支出用途不能为空")
    private String expendPurpose;
    public String getExpendPurpose() {
        return expendPurpose;
    }
    public void setExpendPurpose(String expendPurpose) {
        this.expendPurpose = expendPurpose;
    }

    /*支付方式*/
    private PayWay payWayObj;
    public PayWay getPayWayObj() {
        return payWayObj;
    }
    public void setPayWayObj(PayWay payWayObj) {
        this.payWayObj = payWayObj;
    }

    /*支付账号*/
    @NotEmpty(message="支付账号不能为空")
    private String payAccount;
    public String getPayAccount() {
        return payAccount;
    }
    public void setPayAccount(String payAccount) {
        this.payAccount = payAccount;
    }

    /*支付金额*/
    @NotNull(message="必须输入支付金额")
    private Float expendMoney;
    public Float getExpendMoney() {
        return expendMoney;
    }
    public void setExpendMoney(Float expendMoney) {
        this.expendMoney = expendMoney;
    }

    /*支付日期*/
    @NotEmpty(message="支付日期不能为空")
    private String expendDate;
    public String getExpendDate() {
        return expendDate;
    }
    public void setExpendDate(String expendDate) {
        this.expendDate = expendDate;
    }

    /*支出用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*支出备注*/
    private String expendMemo;
    public String getExpendMemo() {
        return expendMemo;
    }
    public void setExpendMemo(String expendMemo) {
        this.expendMemo = expendMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonExpend=new JSONObject(); 
		jsonExpend.accumulate("expendId", this.getExpendId());
		jsonExpend.accumulate("exprendTypeObj", this.getExprendTypeObj().getExpendTypeName());
		jsonExpend.accumulate("exprendTypeObjPri", this.getExprendTypeObj().getExpendTypeId());
		jsonExpend.accumulate("expendPurpose", this.getExpendPurpose());
		jsonExpend.accumulate("payWayObj", this.getPayWayObj().getPayWayName());
		jsonExpend.accumulate("payWayObjPri", this.getPayWayObj().getPayWayId());
		jsonExpend.accumulate("payAccount", this.getPayAccount());
		jsonExpend.accumulate("expendMoney", this.getExpendMoney());
		jsonExpend.accumulate("expendDate", this.getExpendDate().length()>19?this.getExpendDate().substring(0,19):this.getExpendDate());
		jsonExpend.accumulate("userObj", this.getUserObj().getName());
		jsonExpend.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonExpend.accumulate("expendMemo", this.getExpendMemo());
		return jsonExpend;
    }}