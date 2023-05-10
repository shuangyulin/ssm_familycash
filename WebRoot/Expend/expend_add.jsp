<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/expend.css" />
<div id="expendAddDiv">
	<form id="expendAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">支出类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_exprendTypeObj_expendTypeId" name="expend.exprendTypeObj.expendTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支出用途:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendPurpose" name="expend.expendPurpose" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">支付方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_payWayObj_payWayId" name="expend.payWayObj.payWayId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支付账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_payAccount" name="expend.payAccount" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">支付金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendMoney" name="expend.expendMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">支付日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendDate" name="expend.expendDate" />

			</span>

		</div>
		<div>
			<span class="label">支出用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_userObj_user_name" name="expend.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">支出备注:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expend_expendMemo" name="expend.expendMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="expendAddButton" class="easyui-linkbutton">添加</a>
			<a id="expendClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Expend/js/expend_add.js"></script> 
