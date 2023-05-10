<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Expend" %>
<%@ page import="com.chengxusheji.po.ExpendType" %>
<%@ page import="com.chengxusheji.po.PayWay" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的exprendTypeObj信息
    List<ExpendType> expendTypeList = (List<ExpendType>)request.getAttribute("expendTypeList");
    //获取所有的payWayObj信息
    List<PayWay> payWayList = (List<PayWay>)request.getAttribute("payWayList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Expend expend = (Expend)request.getAttribute("expend");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改支出信息</TITLE>
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
  		<li class="active">支出信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="expendEditForm" id="expendEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="expend_expendId_edit" class="col-md-3 text-right">支出id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="expend_expendId_edit" name="expend.expendId" class="form-control" placeholder="请输入支出id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="expend_exprendTypeObj_expendTypeId_edit" class="col-md-3 text-right">支出类型:</label>
		  	 <div class="col-md-9">
			    <select id="expend_exprendTypeObj_expendTypeId_edit" name="expend.exprendTypeObj.expendTypeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="expend_expendPurpose_edit" class="col-md-3 text-right">支出用途:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="expend_expendPurpose_edit" name="expend.expendPurpose" class="form-control" placeholder="请输入支出用途">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="expend_payWayObj_payWayId_edit" class="col-md-3 text-right">支付方式:</label>
		  	 <div class="col-md-9">
			    <select id="expend_payWayObj_payWayId_edit" name="expend.payWayObj.payWayId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="expend_payAccount_edit" class="col-md-3 text-right">支付账号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="expend_payAccount_edit" name="expend.payAccount" class="form-control" placeholder="请输入支付账号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="expend_expendMoney_edit" class="col-md-3 text-right">支付金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="expend_expendMoney_edit" name="expend.expendMoney" class="form-control" placeholder="请输入支付金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="expend_expendDate_edit" class="col-md-3 text-right">支付日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date expend_expendDate_edit col-md-12" data-link-field="expend_expendDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="expend_expendDate_edit" name="expend.expendDate" size="16" type="text" value="" placeholder="请选择支付日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="expend_userObj_user_name_edit" class="col-md-3 text-right">支出用户:</label>
		  	 <div class="col-md-9">
			    <select id="expend_userObj_user_name_edit" name="expend.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="expend_expendMemo_edit" class="col-md-3 text-right">支出备注:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="expend_expendMemo_edit" name="expend.expendMemo" class="form-control" placeholder="请输入支出备注">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxExpendModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#expendEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改支出界面并初始化数据*/
function expendEdit(expendId) {
	$.ajax({
		url :  basePath + "Expend/" + expendId + "/update",
		type : "get",
		dataType: "json",
		success : function (expend, response, status) {
			if (expend) {
				$("#expend_expendId_edit").val(expend.expendId);
				$.ajax({
					url: basePath + "ExpendType/listAll",
					type: "get",
					success: function(expendTypes,response,status) { 
						$("#expend_exprendTypeObj_expendTypeId_edit").empty();
						var html="";
		        		$(expendTypes).each(function(i,expendType){
		        			html += "<option value='" + expendType.expendTypeId + "'>" + expendType.expendTypeName + "</option>";
		        		});
		        		$("#expend_exprendTypeObj_expendTypeId_edit").html(html);
		        		$("#expend_exprendTypeObj_expendTypeId_edit").val(expend.exprendTypeObjPri);
					}
				});
				$("#expend_expendPurpose_edit").val(expend.expendPurpose);
				$.ajax({
					url: basePath + "PayWay/listAll",
					type: "get",
					success: function(payWays,response,status) { 
						$("#expend_payWayObj_payWayId_edit").empty();
						var html="";
		        		$(payWays).each(function(i,payWay){
		        			html += "<option value='" + payWay.payWayId + "'>" + payWay.payWayName + "</option>";
		        		});
		        		$("#expend_payWayObj_payWayId_edit").html(html);
		        		$("#expend_payWayObj_payWayId_edit").val(expend.payWayObjPri);
					}
				});
				$("#expend_payAccount_edit").val(expend.payAccount);
				$("#expend_expendMoney_edit").val(expend.expendMoney);
				$("#expend_expendDate_edit").val(expend.expendDate);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#expend_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#expend_userObj_user_name_edit").html(html);
		        		$("#expend_userObj_user_name_edit").val(expend.userObjPri);
					}
				});
				$("#expend_expendMemo_edit").val(expend.expendMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交支出信息表单给服务器端修改*/
function ajaxExpendModify() {
	$.ajax({
		url :  basePath + "Expend/" + $("#expend_expendId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#expendEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#expendQueryForm").submit();
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
    /*支付日期组件*/
    $('.expend_expendDate_edit').datetimepicker({
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
    expendEdit("<%=request.getParameter("expendId")%>");
 })
 </script> 
</body>
</html>

