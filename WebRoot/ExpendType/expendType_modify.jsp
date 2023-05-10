<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/expendType.css" />
<div id="expendType_editDiv">
	<form id="expendTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">支出类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expendType_expendTypeId_edit" name="expendType.expendTypeId" value="<%=request.getParameter("expendTypeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">支出类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expendType_expendTypeName_edit" name="expendType.expendTypeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="expendTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ExpendType/js/expendType_modify.js"></script> 
