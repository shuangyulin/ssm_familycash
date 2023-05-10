var expendType_manage_tool = null; 
$(function () { 
	initExpendTypeManageTool(); //建立ExpendType管理对象
	expendType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#expendType_manage").datagrid({
		url : 'ExpendType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "expendTypeId",
		sortOrder : "desc",
		toolbar : "#expendType_manage_tool",
		columns : [[
			{
				field : "expendTypeId",
				title : "支出类型id",
				width : 70,
			},
			{
				field : "expendTypeName",
				title : "支出类型名称",
				width : 140,
			},
		]],
	});

	$("#expendTypeEditDiv").dialog({
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
				if ($("#expendTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#expendTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#expendTypeEditForm").form({
						    url:"ExpendType/" + $("#expendType_expendTypeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#expendTypeEditForm").form("validate"))  {
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
			                        $("#expendTypeEditDiv").dialog("close");
			                        expendType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#expendTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#expendTypeEditDiv").dialog("close");
				$("#expendTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initExpendTypeManageTool() {
	expendType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#expendType_manage").datagrid("reload");
		},
		redo : function () {
			$("#expendType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#expendType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#expendTypeQueryForm").form({
			    url:"ExpendType/OutToExcel",
			});
			//提交表单
			$("#expendTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#expendType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var expendTypeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							expendTypeIds.push(rows[i].expendTypeId);
						}
						$.ajax({
							type : "POST",
							url : "ExpendType/deletes",
							data : {
								expendTypeIds : expendTypeIds.join(","),
							},
							beforeSend : function () {
								$("#expendType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#expendType_manage").datagrid("loaded");
									$("#expendType_manage").datagrid("load");
									$("#expendType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#expendType_manage").datagrid("loaded");
									$("#expendType_manage").datagrid("load");
									$("#expendType_manage").datagrid("unselectAll");
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
			var rows = $("#expendType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ExpendType/" + rows[0].expendTypeId +  "/update",
					type : "get",
					data : {
						//expendTypeId : rows[0].expendTypeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (expendType, response, status) {
						$.messager.progress("close");
						if (expendType) { 
							$("#expendTypeEditDiv").dialog("open");
							$("#expendType_expendTypeId_edit").val(expendType.expendTypeId);
							$("#expendType_expendTypeId_edit").validatebox({
								required : true,
								missingMessage : "请输入支出类型id",
								editable: false
							});
							$("#expendType_expendTypeName_edit").val(expendType.expendTypeName);
							$("#expendType_expendTypeName_edit").validatebox({
								required : true,
								missingMessage : "请输入支出类型名称",
							});
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
