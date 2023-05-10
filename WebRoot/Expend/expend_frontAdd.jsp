<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ExpendType" %>
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
<title>支出添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Expend/frontlist">支出列表</a></li>
			    	<li role="presentation" class="active"><a href="#expendAdd" aria-controls="expendAdd" role="tab" data-toggle="tab">添加支出</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="expendList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="expendAdd"> 
				      	<form class="form-horizontal" name="expendAddForm" id="expendAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="expend_exprendTypeObj_expendTypeId" class="col-md-2 text-right">支出类型:</label>
						  	 <div class="col-md-8">
							    <select id="expend_exprendTypeObj_expendTypeId" name="expend.exprendTypeObj.expendTypeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="expend_expendPurpose" class="col-md-2 text-right">支出用途:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="expend_expendPurpose" name="expend.expendPurpose" class="form-control" placeholder="请输入支出用途">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="expend_payWayObj_payWayId" class="col-md-2 text-right">支付方式:</label>
						  	 <div class="col-md-8">
							    <select id="expend_payWayObj_payWayId" name="expend.payWayObj.payWayId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="expend_payAccount" class="col-md-2 text-right">支付账号:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="expend_payAccount" name="expend.payAccount" class="form-control" placeholder="请输入支付账号">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="expend_expendMoney" class="col-md-2 text-right">支付金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="expend_expendMoney" name="expend.expendMoney" class="form-control" placeholder="请输入支付金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="expend_expendDateDiv" class="col-md-2 text-right">支付日期:</label>
						  	 <div class="col-md-8">
				                <div id="expend_expendDateDiv" class="input-group date expend_expendDate col-md-12" data-link-field="expend_expendDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="expend_expendDate" name="expend.expendDate" size="16" type="text" value="" placeholder="请选择支付日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="expend_userObj_user_name" class="col-md-2 text-right">支出用户:</label>
						  	 <div class="col-md-8">
							    <select id="expend_userObj_user_name" name="expend.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="expend_expendMemo" class="col-md-2 text-right">支出备注:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="expend_expendMemo" name="expend.expendMemo" class="form-control" placeholder="请输入支出备注">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxExpendAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#expendAddForm .form-group {margin:10px;}  </style>
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
	//提交添加支出信息
	function ajaxExpendAdd() { 
		//提交之前先验证表单
		$("#expendAddForm").data('bootstrapValidator').validate();
		if(!$("#expendAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Expend/add",
			dataType : "json" , 
			data: new FormData($("#expendAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#expendAddForm").find("input").val("");
					$("#expendAddForm").find("textarea").val("");
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
	//验证支出添加表单字段
	$('#expendAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"expend.expendPurpose": {
				validators: {
					notEmpty: {
						message: "支出用途不能为空",
					}
				}
			},
			"expend.payAccount": {
				validators: {
					notEmpty: {
						message: "支付账号不能为空",
					}
				}
			},
			"expend.expendMoney": {
				validators: {
					notEmpty: {
						message: "支付金额不能为空",
					},
					numeric: {
						message: "支付金额不正确"
					}
				}
			},
			"expend.expendDate": {
				validators: {
					notEmpty: {
						message: "支付日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化支出类型下拉框值 
	$.ajax({
		url: basePath + "ExpendType/listAll",
		type: "get",
		success: function(expendTypes,response,status) { 
			$("#expend_exprendTypeObj_expendTypeId").empty();
			var html="";
    		$(expendTypes).each(function(i,expendType){
    			html += "<option value='" + expendType.expendTypeId + "'>" + expendType.expendTypeName + "</option>";
    		});
    		$("#expend_exprendTypeObj_expendTypeId").html(html);
    	}
	});
	//初始化支付方式下拉框值 
	$.ajax({
		url: basePath + "PayWay/listAll",
		type: "get",
		success: function(payWays,response,status) { 
			$("#expend_payWayObj_payWayId").empty();
			var html="";
    		$(payWays).each(function(i,payWay){
    			html += "<option value='" + payWay.payWayId + "'>" + payWay.payWayName + "</option>";
    		});
    		$("#expend_payWayObj_payWayId").html(html);
    	}
	});
	//初始化支出用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#expend_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#expend_userObj_user_name").html(html);
    	}
	});
	//支付日期组件
	$('#expend_expendDateDiv').datetimepicker({
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
		$('#expendAddForm').data('bootstrapValidator').updateStatus('expend.expendDate', 'NOT_VALIDATED',null).validateField('expend.expendDate');
	});
})
</script>
</body>
</html>
