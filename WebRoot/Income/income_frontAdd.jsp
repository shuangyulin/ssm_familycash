<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.IncomeType" %>
<%@ page import="com.chengxusheji.po.PayWay" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>收入添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Income/frontlist">收入列表</a></li>
			    	<li role="presentation" class="active"><a href="#incomeAdd" aria-controls="incomeAdd" role="tab" data-toggle="tab">添加收入</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="incomeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="incomeAdd"> 
				      	<form class="form-horizontal" name="incomeAddForm" id="incomeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="income_incomeTypeObj_typeId" class="col-md-2 text-right">收入类型:</label>
						  	 <div class="col-md-8">
							    <select id="income_incomeTypeObj_typeId" name="income.incomeTypeObj.typeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="income_incomeFrom" class="col-md-2 text-right">收入来源:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="income_incomeFrom" name="income.incomeFrom" class="form-control" placeholder="请输入收入来源">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="income_payWayObj_payWayId" class="col-md-2 text-right">支付方式:</label>
						  	 <div class="col-md-8">
							    <select id="income_payWayObj_payWayId" name="income.payWayObj.payWayId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="income_payAccount" class="col-md-2 text-right">支付账号:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="income_payAccount" name="income.payAccount" class="form-control" placeholder="请输入支付账号">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="income_incomeMoney" class="col-md-2 text-right">收入金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="income_incomeMoney" name="income.incomeMoney" class="form-control" placeholder="请输入收入金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="income_incomeDateDiv" class="col-md-2 text-right">收入日期:</label>
						  	 <div class="col-md-8">
				                <div id="income_incomeDateDiv" class="input-group date income_incomeDate col-md-12" data-link-field="income_incomeDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="income_incomeDate" name="income.incomeDate" size="16" type="text" value="" placeholder="请选择收入日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="income_userObj_user_name" class="col-md-2 text-right">收入用户:</label>
						  	 <div class="col-md-8">
							    <select id="income_userObj_user_name" name="income.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="income_incomeMemo" class="col-md-2 text-right">收入备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="income_incomeMemo" name="income.incomeMemo" rows="8" class="form-control" placeholder="请输入收入备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxIncomeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#incomeAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加收入信息
	function ajaxIncomeAdd() { 
		//提交之前先验证表单
		$("#incomeAddForm").data('bootstrapValidator').validate();
		if(!$("#incomeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Income/add",
			dataType : "json" , 
			data: new FormData($("#incomeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#incomeAddForm").find("input").val("");
					$("#incomeAddForm").find("textarea").val("");
				} else {
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
	//验证收入添加表单字段
	$('#incomeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"income.incomeFrom": {
				validators: {
					notEmpty: {
						message: "收入来源不能为空",
					}
				}
			},
			"income.payAccount": {
				validators: {
					notEmpty: {
						message: "支付账号不能为空",
					}
				}
			},
			"income.incomeMoney": {
				validators: {
					notEmpty: {
						message: "收入金额不能为空",
					},
					numeric: {
						message: "收入金额不正确"
					}
				}
			},
			"income.incomeDate": {
				validators: {
					notEmpty: {
						message: "收入日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化收入类型下拉框值 
	$.ajax({
		url: basePath + "IncomeType/listAll",
		type: "get",
		success: function(incomeTypes,response,status) { 
			$("#income_incomeTypeObj_typeId").empty();
			var html="";
    		$(incomeTypes).each(function(i,incomeType){
    			html += "<option value='" + incomeType.typeId + "'>" + incomeType.typeName + "</option>";
    		});
    		$("#income_incomeTypeObj_typeId").html(html);
    	}
	});
	//初始化支付方式下拉框值 
	$.ajax({
		url: basePath + "PayWay/listAll",
		type: "get",
		success: function(payWays,response,status) { 
			$("#income_payWayObj_payWayId").empty();
			var html="";
    		$(payWays).each(function(i,payWay){
    			html += "<option value='" + payWay.payWayId + "'>" + payWay.payWayName + "</option>";
    		});
    		$("#income_payWayObj_payWayId").html(html);
    	}
	});
	//初始化收入用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#income_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#income_userObj_user_name").html(html);
    	}
	});
	//收入日期组件
	$('#income_incomeDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#incomeAddForm').data('bootstrapValidator').updateStatus('income.incomeDate', 'NOT_VALIDATED',null).validateField('income.incomeDate');
	});
})
</script>
</body>
</html>
