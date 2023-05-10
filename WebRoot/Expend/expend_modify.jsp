<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/expend.css" />
<div id="expend_editDiv">
	<form id="expendEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">支出id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendId_edit" name="expend.expendId" value="<%=request.getParameter("expendId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="expendModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Expend/js/expend_modify.js"></script> 
