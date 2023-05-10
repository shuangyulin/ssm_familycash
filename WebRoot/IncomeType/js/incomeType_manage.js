var incomeType_manage_tool = null; 
$(function () { 
	initIncomeTypeManageTool(); //建立IncomeType管理对象
	incomeType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#incomeType_manage").datagrid({
		url : 'IncomeType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "typeId",
		sortOrder : "desc",
		toolbar : "#incomeType_manage_tool",
		columns : [[
			{
				field : "typeId",
				title : "分类id",
				width : 70,
			},
			{
				field : "typeName",
				title : "分类名称",
				width : 140,
			},
		]],
	});

	$("#incomeTypeEditDiv").dialog({
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
				if ($("#incomeTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#incomeTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#incomeTypeEditForm").form({
						    url:"IncomeType/" + $("#incomeType_typeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#incomeTypeEditForm").form("validate"))  {
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
			                        $("#incomeTypeEditDiv").dialog("close");
			                        incomeType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#incomeTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#incomeTypeEditDiv").dialog("close");
				$("#incomeTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initIncomeTypeManageTool() {
	incomeType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#incomeType_manage").datagrid("reload");
		},
		redo : function () {
			$("#incomeType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#incomeType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#incomeTypeQueryForm").form({
			    url:"IncomeType/OutToExcel",
			});
			//提交表单
			$("#incomeTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#incomeType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var typeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							typeIds.push(rows[i].typeId);
						}
						$.ajax({
							type : "POST",
							url : "IncomeType/deletes",
							data : {
								typeIds : typeIds.join(","),
							},
							beforeSend : function () {
								$("#incomeType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#incomeType_manage").datagrid("loaded");
									$("#incomeType_manage").datagrid("load");
									$("#incomeType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#incomeType_manage").datagrid("loaded");
									$("#incomeType_manage").datagrid("load");
									$("#incomeType_manage").datagrid("unselectAll");
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
			var rows = $("#incomeType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "IncomeType/" + rows[0].typeId +  "/update",
					type : "get",
					data : {
						//typeId : rows[0].typeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (incomeType, response, status) {
						$.messager.progress("close");
						if (incomeType) { 
							$("#incomeTypeEditDiv").dialog("open");
							$("#incomeType_typeId_edit").val(incomeType.typeId);
							$("#incomeType_typeId_edit").validatebox({
								required : true,
								missingMessage : "请输入分类id",
								editable: false
							});
							$("#incomeType_typeName_edit").val(incomeType.typeName);
							$("#incomeType_typeName_edit").validatebox({
								required : true,
								missingMessage : "请输入分类名称",
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
