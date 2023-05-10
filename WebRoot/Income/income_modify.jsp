<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/income.css" />
<div id="income_editDiv">
	<form id="incomeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">收入id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeId_edit" name="income.incomeId" value="<%=request.getParameter("incomeId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="incomeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Income/js/income_modify.js"></script> 
