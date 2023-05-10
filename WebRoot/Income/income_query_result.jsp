<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/income.css" /> 

<div id="income_manage"></div>
<div id="income_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="income_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="income_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="income_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="income_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="income_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="incomeQueryForm" method="post">
			收入类型：<input class="textbox" type="text" id="incomeTypeObj_typeId_query" name="incomeTypeObj.typeId" style="width: auto"/>
			收入来源：<input type="text" class="textbox" id="incomeFrom" name="incomeFrom" style="width:110px" />
			支付方式：<input class="textbox" type="text" id="payWayObj_payWayId_query" name="payWayObj.payWayId" style="width: auto"/>
			支付账号：<input type="text" class="textbox" id="payAccount" name="payAccount" style="width:110px" />
			收入日期：<input type="text" id="incomeDate" name="incomeDate" class="easyui-datebox" editable="false" style="width:100px">
			收入用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="income_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="incomeEditDiv">
	<form id="incomeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">收入id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeId_edit" name="income.incomeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">收入类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="income_incomeTypeObj_typeId_edit" name="income.incomeTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收入来源:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeFrom_edit" name="income.incomeFrom" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">支付方式:</span>
			<span class="inputControl">
				<input class="textbox"  id="income_payWayObj_payWayId_edit" name="income.payWayObj.payWayId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支付账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_payAccount_edit" name="income.payAccount" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收入金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeMoney_edit" name="income.incomeMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">收入日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeDate_edit" name="income.incomeDate" />

			</span>

		</div>
		<div>
			<span class="label">收入用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="income_userObj_user_name_edit" name="income.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收入备注:</span>
			<span class="inputControl">
				<textarea id="income_incomeMemo_edit" name="income.incomeMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Income/js/income_manage.js"></script> 
