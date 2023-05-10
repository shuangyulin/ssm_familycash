<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/income.css" />
<div id="incomeAddDiv">
	<form id="incomeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">收入类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeTypeObj_typeId" name="income.incomeTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收入来源:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeFrom" name="income.incomeFrom" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">支付方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_payWayObj_payWayId" name="income.payWayObj.payWayId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支付账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_payAccount" name="income.payAccount" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收入金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeMoney" name="income.incomeMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">收入日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_incomeDate" name="income.incomeDate" />

			</span>

		</div>
		<div>
			<span class="label">收入用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="income_userObj_user_name" name="income.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收入备注:</span>
			<span class="inputControl">
				<textarea id="income_incomeMemo" name="income.incomeMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="incomeAddButton" class="easyui-linkbutton">添加</a>
			<a id="incomeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Income/js/income_add.js"></script> 
