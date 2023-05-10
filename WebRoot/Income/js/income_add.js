$(function () {
	$("#income_incomeTypeObj_typeId").combobox({
	    url:'IncomeType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#income_incomeTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#income_incomeTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#income_incomeFrom").validatebox({
		required : true, 
		missingMessage : '请输入收入来源',
	});

	$("#income_payWayObj_payWayId").combobox({
	    url:'PayWay/listAll',
	    valueField: "payWayId",
	    textField: "payWayName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#income_payWayObj_payWayId").combobox("getData"); 
            if (data.length > 0) {
                $("#income_payWayObj_payWayId").combobox("select", data[0].payWayId);
            }
        }
	});
	$("#income_payAccount").validatebox({
		required : true, 
		missingMessage : '请输入支付账号',
	});

	$("#income_incomeMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入收入金额',
		invalidMessage : '收入金额输入不对',
	});

	$("#income_incomeDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#income_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#income_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#income_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#incomeAddButton").click(function () {
		//验证表单 
		if(!$("#incomeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#incomeAddForm").form({
			    url:"Income/add",
			    onSubmit: function(){
					if($("#incomeAddForm").form("validate"))  { 
	                	$.messager.progress({
							text : "正在提交数据中...",
						}); 
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#incomeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#incomeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#incomeClearButton").click(function () { 
		$("#incomeAddForm").form("clear"); 
	});
});
