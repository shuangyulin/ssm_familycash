<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/expend.css" /> 

<div id="expend_manage"></div>
<div id="expend_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="expend_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="expend_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="expend_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="expend_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="expend_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="expendQueryForm" method="post">
			支出类型：<input class="textbox" type="text" id="exprendTypeObj_expendTypeId_query" name="exprendTypeObj.expendTypeId" style="width: auto"/>
			支出用途：<input type="text" class="textbox" id="expendPurpose" name="expendPurpose" style="width:110px" />
			支付方式：<input class="textbox" type="text" id="payWayObj_payWayId_query" name="payWayObj.payWayId" style="width: auto"/>
			支付账号：<input type="text" class="textbox" id="payAccount" name="payAccount" style="width:110px" />
			支付日期：<input type="text" id="expendDate" name="expendDate" class="easyui-datebox" editable="false" style="width:100px">
			支出用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="expend_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="expendEditDiv">
	<form id="expendEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">支出id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendId_edit" name="expend.expendId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">支出类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="expend_exprendTypeObj_expendTypeId_edit" name="expend.exprendTypeObj.expendTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支出用途:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendPurpose_edit" name="expend.expendPurpose" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">支付方式:</span>
			<span class="inputControl">
				<input class="textbox"  id="expend_payWayObj_payWayId_edit" name="expend.payWayObj.payWayId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支付账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_payAccount_edit" name="expend.payAccount" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">支付金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendMoney_edit" name="expend.expendMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">支付日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendDate_edit" name="expend.expendDate" />

			</span>

		</div>
		<div>
			<span class="label">支出用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="expend_userObj_user_name_edit" name="expend.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支出备注:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendMemo_edit" name="expend.expendMemo" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Expend/js/expend_manage.js"></script> 
