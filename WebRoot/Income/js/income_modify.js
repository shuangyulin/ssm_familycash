$(function () {
	$.ajax({
		url : "Income/" + $("#income_incomeId_edit").val() + "/update",
		type : "get",
		data : {
			//incomeId : $("#income_incomeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (income, response, status) {
			$.messager.progress("close");
			if (income) { 
				$("#income_incomeId_edit").val(income.incomeId);
				$("#income_incomeId_edit").validatebox({
					required : true,
					missingMessage : "请输入收入id",
					editable: false
				});
				$("#income_incomeTypeObj_typeId_edit").combobox({
					url:"IncomeType/listAll",
					valueField:"typeId",
					textField:"typeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#income_incomeTypeObj_typeId_edit").combobox("select", income.incomeTypeObjPri);
						//var data = $("#income_incomeTypeObj_typeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#income_incomeTypeObj_typeId_edit").combobox("select", data[0].typeId);
						//}
					}
				});
				$("#income_incomeFrom_edit").val(income.incomeFrom);
				$("#income_incomeFrom_edit").validatebox({
					required : true,
					missingMessage : "请输入收入来源",
				});
				$("#income_payWayObj_payWayId_edit").combobox({
					url:"PayWay/listAll",
					valueField:"payWayId",
					textField:"payWayName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#income_payWayObj_payWayId_edit").combobox("select", income.payWayObjPri);
						//var data = $("#income_payWayObj_payWayId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#income_payWayObj_payWayId_edit").combobox("select", data[0].payWayId);
						//}
					}
				});
				$("#income_payAccount_edit").val(income.payAccount);
				$("#income_payAccount_edit").validatebox({
					required : true,
					missingMessage : "请输入支付账号",
				});
				$("#income_incomeMoney_edit").val(income.incomeMoney);
				$("#income_incomeMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入收入金额",
					invalidMessage : "收入金额输入不对",
				});
				$("#income_incomeDate_edit").datebox({
					value: income.incomeDate,
					required: true,
					showSeconds: true,
				});
				$("#income_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#income_userObj_user_name_edit").combobox("select", income.userObjPri);
						//var data = $("#income_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#income_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#income_incomeMemo_edit").val(income.incomeMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#incomeModifyButton").click(function(){ 
		if ($("#incomeEditForm").form("validate")) {
			$("#incomeEditForm").form({
			    url:"Income/" +  $("#income_incomeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#incomeEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#incomeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
