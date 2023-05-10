<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Income" %>
<%@ page import="com.chengxusheji.po.IncomeType" %>
<%@ page import="com.chengxusheji.po.PayWay" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的incomeTypeObj信息
    List<IncomeType> incomeTypeList = (List<IncomeType>)request.getAttribute("incomeTypeList");
    //获取所有的payWayObj信息
    List<PayWay> payWayList = (List<PayWay>)request.getAttribute("payWayList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Income income = (Income)request.getAttribute("income");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改收入信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">收入信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="incomeEditForm" id="incomeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="income_incomeId_edit" class="col-md-3 text-right">收入id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="income_incomeId_edit" name="income.incomeId" class="form-control" placeholder="请输入收入id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="income_incomeTypeObj_typeId_edit" class="col-md-3 text-right">收入类型:</label>
		  	 <div class="col-md-9">
			    <select id="income_incomeTypeObj_typeId_edit" name="income.incomeTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="income_incomeFrom_edit" class="col-md-3 text-right">收入来源:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="income_incomeFrom_edit" name="income.incomeFrom" class="form-control" placeholder="请输入收入来源">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="income_payWayObj_payWayId_edit" class="col-md-3 text-right">支付方式:</label>
		  	 <div class="col-md-9">
			    <select id="income_payWayObj_payWayId_edit" name="income.payWayObj.payWayId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="income_payAccount_edit" class="col-md-3 text-right">支付账号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="income_payAccount_edit" name="income.payAccount" class="form-control" placeholder="请输入支付账号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="income_incomeMoney_edit" class="col-md-3 text-right">收入金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="income_incomeMoney_edit" name="income.incomeMoney" class="form-control" placeholder="请输入收入金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="income_incomeDate_edit" class="col-md-3 text-right">收入日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date income_incomeDate_edit col-md-12" data-link-field="income_incomeDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="income_incomeDate_edit" name="income.incomeDate" size="16" type="text" value="" placeholder="请选择收入日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="income_userObj_user_name_edit" class="col-md-3 text-right">收入用户:</label>
		  	 <div class="col-md-9">
			    <select id="income_userObj_user_name_edit" name="income.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="income_incomeMemo_edit" class="col-md-3 text-right">收入备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="income_incomeMemo_edit" name="income.incomeMemo" rows="8" class="form-control" placeholder="请输入收入备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxIncomeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#incomeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改收入界面并初始化数据*/
function incomeEdit(incomeId) {
	$.ajax({
		url :  basePath + "Income/" + incomeId + "/update",
		type : "get",
		dataType: "json",
		success : function (income, response, status) {
			if (income) {
				$("#income_incomeId_edit").val(income.incomeId);
				$.ajax({
					url: basePath + "IncomeType/listAll",
					type: "get",
					success: function(incomeTypes,response,status) { 
						$("#income_incomeTypeObj_typeId_edit").empty();
						var html="";
		        		$(incomeTypes).each(function(i,incomeType){
		        			html += "<option value='" + incomeType.typeId + "'>" + incomeType.typeName + "</option>";
		        		});
		        		$("#income_incomeTypeObj_typeId_edit").html(html);
		        		$("#income_incomeTypeObj_typeId_edit").val(income.incomeTypeObjPri);
					}
				});
				$("#income_incomeFrom_edit").val(income.incomeFrom);
				$.ajax({
					url: basePath + "PayWay/listAll",
					type: "get",
					success: function(payWays,response,status) { 
						$("#income_payWayObj_payWayId_edit").empty();
						var html="";
		        		$(payWays).each(function(i,payWay){
		        			html += "<option value='" + payWay.payWayId + "'>" + payWay.payWayName + "</option>";
		        		});
		        		$("#income_payWayObj_payWayId_edit").html(html);
		        		$("#income_payWayObj_payWayId_edit").val(income.payWayObjPri);
					}
				});
				$("#income_payAccount_edit").val(income.payAccount);
				$("#income_incomeMoney_edit").val(income.incomeMoney);
				$("#income_incomeDate_edit").val(income.incomeDate);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#income_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#income_userObj_user_name_edit").html(html);
		        		$("#income_userObj_user_name_edit").val(income.userObjPri);
					}
				});
				$("#income_incomeMemo_edit").val(income.incomeMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交收入信息表单给服务器端修改*/
function ajaxIncomeModify() {
	$.ajax({
		url :  basePath + "Income/" + $("#income_incomeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#incomeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#incomeQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*收入日期组件*/
    $('.income_incomeDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    incomeEdit("<%=request.getParameter("incomeId")%>");
 })
 </script> 
</body>
</html>

