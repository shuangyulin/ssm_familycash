var expend_manage_tool = null; 
$(function () { 
	initExpendManageTool(); //建立Expend管理对象
	expend_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#expend_manage").datagrid({
		url : 'Expend/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "expendId",
		sortOrder : "desc",
		toolbar : "#expend_manage_tool",
		columns : [[
			{
				field : "expendId",
				title : "支出id",
				width : 70,
			},
			{
				field : "exprendTypeObj",
				title : "支出类型",
				width : 140,
			},
			{
				field : "expendPurpose",
				title : "支出用途",
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
				field : "expendMoney",
				title : "支付金额",
				width : 70,
			},
			{
				field : "expendDate",
				title : "支付日期",
				width : 140,
			},
			{
				field : "userObj",
				title : "支出用户",
				width : 140,
			},
		]],
	});

	$("#expendEditDiv").dialog({
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
				if ($("#expendEditForm").form("validate")) {
					//验证表单 
					if(!$("#expendEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#expendEditForm").form({
						    url:"Expend/" + $("#expend_expendId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#expendEditDiv").dialog("close");
			                        expend_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#expendEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#expendEditDiv").dialog("close");
				$("#expendEditForm").form("reset"); 
			},
		}],
	});
});

function initExpendManageTool() {
	expend_manage_tool = {
		init: function() {
			$.ajax({
				url : "ExpendType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#exprendTypeObj_expendTypeId_query").combobox({ 
					    valueField:"expendTypeId",
					    textField:"expendTypeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{expendTypeId:0,expendTypeName:"不限制"});
					$("#exprendTypeObj_expendTypeId_query").combobox("loadData",data); 
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
			$("#expend_manage").datagrid("reload");
		},
		redo : function () {
			$("#expend_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#expend_manage").datagrid("options").queryParams;
			queryParams["exprendTypeObj.expendTypeId"] = $("#exprendTypeObj_expendTypeId_query").combobox("getValue");
			queryParams["expendPurpose"] = $("#expendPurpose").val();
			queryParams["payWayObj.payWayId"] = $("#payWayObj_payWayId_query").combobox("getValue");
			queryParams["payAccount"] = $("#payAccount").val();
			queryParams["expendDate"] = $("#expendDate").datebox("getValue"); 
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#expend_manage").datagrid("options").queryParams=queryParams; 
			$("#expend_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#expendQueryForm").form({
			    url:"Expend/OutToExcel",
			});
			//提交表单
			$("#expendQueryForm").submit();
		},
		remove : function () {
			var rows = $("#expend_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var expendIds = [];
						for (var i = 0; i < rows.length; i ++) {
							expendIds.push(rows[i].expendId);
						}
						$.ajax({
							type : "POST",
							url : "Expend/deletes",
							data : {
								expendIds : expendIds.join(","),
							},
							beforeSend : function () {
								$("#expend_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#expend_manage").datagrid("loaded");
									$("#expend_manage").datagrid("load");
									$("#expend_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#expend_manage").datagrid("loaded");
									$("#expend_manage").datagrid("load");
									$("#expend_manage").datagrid("unselectAll");
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
			var rows = $("#expend_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Expend/" + rows[0].expendId +  "/update",
					type : "get",
					data : {
						//expendId : rows[0].expendId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (expend, response, status) {
						$.messager.progress("close");
						if (expend) { 
							$("#expendEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
