var income_manage_tool = null; 
$(function () { 
	initIncomeManageTool(); //建立Income管理对象
	income_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#income_manage").datagrid({
		url : 'Income/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "incomeId",
		sortOrder : "desc",
		toolbar : "#income_manage_tool",
		columns : [[
			{
				field : "incomeId",
				title : "收入id",
				width : 70,
			},
			{
				field : "incomeTypeObj",
				title : "收入类型",
				width : 140,
			},
			{
				field : "incomeFrom",
				title : "收入来源",
				width : 140,
			},
			{
				field : "payWayObj",
				title : "支付方式",
				width : 140,
			},
			{
				field : "payAccount",
				title : "支付账号",
				width : 140,
			},
			{
				field : "incomeMoney",
				title : "收入金额",
				width : 70,
			},
			{
				field : "incomeDate",
				title : "收入日期",
				width : 140,
			},
			{
				field : "userObj",
				title : "收入用户",
				width : 140,
			},
		]],
	});

	$("#incomeEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#incomeEditForm").form("validate")) {
					//验证表单 
					if(!$("#incomeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#incomeEditForm").form({
						    url:"Income/" + $("#income_incomeId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#incomeEditDiv").dialog("close");
			                        income_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#incomeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#incomeEditDiv").dialog("close");
				$("#incomeEditForm").form("reset"); 
			},
		}],
	});
});

function initIncomeManageTool() {
	income_manage_tool = {
		init: function() {
			$.ajax({
				url : "IncomeType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#incomeTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#incomeTypeObj_typeId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "PayWay/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#payWayObj_payWayId_query").combobox({ 
					    valueField:"payWayId",
					    textField:"payWayName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{payWayId:0,payWayName:"不限制"});
					$("#payWayObj_payWayId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#income_manage").datagrid("reload");
		},
		redo : function () {
			$("#income_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#income_manage").datagrid("options").queryParams;
			queryParams["incomeTypeObj.typeId"] = $("#incomeTypeObj_typeId_query").combobox("getValue");
			queryParams["incomeFrom"] = $("#incomeFrom").val();
			queryParams["payWayObj.payWayId"] = $("#payWayObj_payWayId_query").combobox("getValue");
			queryParams["payAccount"] = $("#payAccount").val();
			queryParams["incomeDate"] = $("#incomeDate").datebox("getValue"); 
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#income_manage").datagrid("options").queryParams=queryParams; 
			$("#income_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#incomeQueryForm").form({
			    url:"Income/OutToExcel",
			});
			//提交表单
			$("#incomeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#income_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var incomeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							incomeIds.push(rows[i].incomeId);
						}
						$.ajax({
							type : "POST",
							url : "Income/deletes",
							data : {
								incomeIds : incomeIds.join(","),
							},
							beforeSend : function () {
								$("#income_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#income_manage").datagrid("loaded");
									$("#income_manage").datagrid("load");
									$("#income_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#income_manage").datagrid("loaded");
									$("#income_manage").datagrid("load");
									$("#income_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#income_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Income/" + rows[0].incomeId +  "/update",
					type : "get",
					data : {
						//incomeId : rows[0].incomeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (income, response, status) {
						$.messager.progress("close");
						if (income) { 
							$("#incomeEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
