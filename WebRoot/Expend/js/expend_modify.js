$(function () {
	$.ajax({
		url : "Expend/" + $("#expend_expendId_edit").val() + "/update",
		type : "get",
		data : {
			//expendId : $("#expend_expendId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (expend, response, status) {
			$.messager.progress("close");
			if (expend) { 
				$("#expend_expendId_edit").val(expend.expendId);
				$("#expend_expendId_edit").validatebox({
					required : true,
					missingMessage : "请输入支出id",
					editable: false
				});
				$("#expend_exprendTypeObj_expendTypeId_edit").combobox({
					url:"ExpendType/listAll",
					valueField:"expendTypeId",
					textField:"expendTypeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#expend_exprendTypeObj_expendTypeId_edit").combobox("select", expend.exprendTypeObjPri);
						//var data = $("#expend_exprendTypeObj_expendTypeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#expend_exprendTypeObj_expendTypeId_edit").combobox("select", data[0].expendTypeId);
						//}
					}
				});
				$("#expend_expendPurpose_edit").val(expend.expendPurpose);
				$("#expend_expendPurpose_edit").validatebox({
					required : true,
					missingMessage : "请输入支出用途",
				});
				$("#expend_payWayObj_payWayId_edit").combobox({
					url:"PayWay/listAll",
					valueField:"payWayId",
					textField:"payWayName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#expend_payWayObj_payWayId_edit").combobox("select", expend.payWayObjPri);
						//var data = $("#expend_payWayObj_payWayId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#expend_payWayObj_payWayId_edit").combobox("select", data[0].payWayId);
						//}
					}
				});
				$("#expend_payAccount_edit").val(expend.payAccount);
				$("#expend_payAccount_edit").validatebox({
					required : true,
					missingMessage : "请输入支付账号",
				});
				$("#expend_expendMoney_edit").val(expend.expendMoney);
				$("#expend_expendMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入支付金额",
					invalidMessage : "支付金额输入不对",
				});
				$("#expend_expendDate_edit").datebox({
					value: expend.expendDate,
					required: true,
					showSeconds: true,
				});
				$("#expend_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#expend_userObj_user_name_edit").combobox("select", expend.userObjPri);
						//var data = $("#expend_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#expend_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#expend_expendMemo_edit").val(expend.expendMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#expendModifyButton").click(function(){ 
		if ($("#expendEditForm").form("validate")) {
			$("#expendEditForm").form({
			    url:"Expend/" +  $("#expend_expendId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#expendEditForm").form("validate"))  {
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
			$("#expendEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
