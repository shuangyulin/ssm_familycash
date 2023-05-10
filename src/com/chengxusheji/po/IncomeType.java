package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class IncomeType {
    /*分类id*/
    private Integer typeId;
    public Integer getTypeId(){
        return typeId;
    }
    public void setTypeId(Integer typeId){
        this.typeId = typeId;
    }

    /*分类名称*/
    @NotEmpty(message="分类名称不能为空")
    private String typeName;
    public String getTypeName() {
        return typeName;
    }
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonIncomeType=new JSONObject(); 
		jsonIncomeType.accumulate("typeId", this.getTypeId());
		jsonIncomeType.accumulate("typeName", this.getTypeName());
		return jsonIncomeType;
    }}