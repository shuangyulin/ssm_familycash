package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Income {
    /*收入id*/
    private Integer incomeId;
    public Integer getIncomeId(){
        return incomeId;
    }
    public void setIncomeId(Integer incomeId){
        this.incomeId = incomeId;
    }

    /*收入类型*/
    private IncomeType incomeTypeObj;
    public IncomeType getIncomeTypeObj() {
        return incomeTypeObj;
    }
    public void setIncomeTypeObj(IncomeType incomeTypeObj) {
        this.incomeTypeObj = incomeTypeObj;
    }

    /*收入来源*/
    @NotEmpty(message="收入来源不能为空")
    private String incomeFrom;
    public String getIncomeFrom() {
        return incomeFrom;
    }
    public void setIncomeFrom(String incomeFrom) {
        this.incomeFrom = incomeFrom;
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

    /*收入金额*/
    @NotNull(message="必须输入收入金额")
    private Float incomeMoney;
    public Float getIncomeMoney() {
        return incomeMoney;
    }
    public void setIncomeMoney(Float incomeMoney) {
        this.incomeMoney = incomeMoney;
    }

    /*收入日期*/
    @NotEmpty(message="收入日期不能为空")
    private String incomeDate;
    public String getIncomeDate() {
        return incomeDate;
    }
    public void setIncomeDate(String incomeDate) {
        this.incomeDate = incomeDate;
    }

    /*收入用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*收入备注*/
    private String incomeMemo;
    public String getIncomeMemo() {
        return incomeMemo;
    }
    public void setIncomeMemo(String incomeMemo) {
        this.incomeMemo = incomeMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonIncome=new JSONObject(); 
		jsonIncome.accumulate("incomeId", this.getIncomeId());
		jsonIncome.accumulate("incomeTypeObj", this.getIncomeTypeObj().getTypeName());
		jsonIncome.accumulate("incomeTypeObjPri", this.getIncomeTypeObj().getTypeId());
		jsonIncome.accumulate("incomeFrom", this.getIncomeFrom());
		jsonIncome.accumulate("payWayObj", this.getPayWayObj().getPayWayName());
		jsonIncome.accumulate("payWayObjPri", this.getPayWayObj().getPayWayId());
		jsonIncome.accumulate("payAccount", this.getPayAccount());
		jsonIncome.accumulate("incomeMoney", this.getIncomeMoney());
		jsonIncome.accumulate("incomeDate", this.getIncomeDate().length()>19?this.getIncomeDate().substring(0,19):this.getIncomeDate());
		jsonIncome.accumulate("userObj", this.getUserObj().getName());
		jsonIncome.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonIncome.accumulate("incomeMemo", this.getIncomeMemo());
		return jsonIncome;
    }}