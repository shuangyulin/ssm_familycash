<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/incomeType.css" />
<div id="incomeType_editDiv">
	<form id="incomeTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">分类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="incomeType_typeId_edit" name="incomeType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="incomeType_typeName_edit" name="incomeType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="incomeTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/IncomeType/js/incomeType_modify.js"></script> 
