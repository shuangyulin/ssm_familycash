<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/incomeType.css" />
<div id="incomeTypeAddDiv">
	<form id="incomeTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="incomeType_typeName" name="incomeType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="incomeTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="incomeTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/IncomeType/js/incomeType_add.js"></script> 
