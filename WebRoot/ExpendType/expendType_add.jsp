<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/expendType.css" />
<div id="expendTypeAddDiv">
	<form id="expendTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">支出类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="expendType_expendTypeName" name="expendType.expendTypeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="expendTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="expendTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ExpendType/js/expendType_add.js"></script> 
