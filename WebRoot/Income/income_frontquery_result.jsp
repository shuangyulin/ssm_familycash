<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Income" %>
<%@ page import="com.chengxusheji.po.IncomeType" %>
<%@ page import="com.chengxusheji.po.PayWay" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Income> incomeList = (List<Income>)request.getAttribute("incomeList");
    //获取所有的incomeTypeObj信息
    List<IncomeType> incomeTypeList = (List<IncomeType>)request.getAttribute("incomeTypeList");
    //获取所有的payWayObj信息
    List<PayWay> payWayList = (List<PayWay>)request.getAttribute("payWayList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    IncomeType incomeTypeObj = (IncomeType)request.getAttribute("incomeTypeObj");
    String incomeFrom = (String)request.getAttribute("incomeFrom"); //收入来源查询关键字
    PayWay payWayObj = (PayWay)request.getAttribute("payWayObj");
    String payAccount = (String)request.getAttribute("payAccount"); //支付账号查询关键字
    String incomeDate = (String)request.getAttribute("incomeDate"); //收入日期查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>收入查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#incomeListPanel" aria-controls="incomeListPanel" role="tab" data-toggle="tab">收入列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Income/income_frontAdd.jsp" style="display:none;">添加收入</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="incomeListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>收入id</td><td>收入类型</td><td>收入来源</td><td>支付方式</td><td>支付账号</td><td>收入金额</td><td>收入日期</td><td>收入用户</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<incomeList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Income income = incomeList.get(i); //获取到收入对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=income.getIncomeId() %></td>
 											<td><%=income.getIncomeTypeObj().getTypeName() %></td>
 											<td><%=income.getIncomeFrom() %></td>
 											<td><%=income.getPayWayObj().getPayWayName() %></td>
 											<td><%=income.getPayAccount() %></td>
 											<td><%=income.getIncomeMoney() %></td>
 											<td><%=income.getIncomeDate() %></td>
 											<td><%=income.getUserObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Income/<%=income.getIncomeId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="incomeEdit('<%=income.getIncomeId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="incomeDelete('<%=income.getIncomeId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>收入查询</h1>
		</div>
		<form name="incomeQueryForm" id="incomeQueryForm" action="<%=basePath %>Income/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="incomeTypeObj_typeId">收入类型：</label>
                <select id="incomeTypeObj_typeId" name="incomeTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(IncomeType incomeTypeTemp:incomeTypeList) {
	 					String selected = "";
 					if(incomeTypeObj!=null && incomeTypeObj.getTypeId()!=null && incomeTypeObj.getTypeId().intValue()==incomeTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=incomeTypeTemp.getTypeId() %>" <%=selected %>><%=incomeTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="incomeFrom">收入来源:</label>
				<input type="text" id="incomeFrom" name="incomeFrom" value="<%=incomeFrom %>" class="form-control" placeholder="请输入收入来源">
			</div>






            <div class="form-group">
            	<label for="payWayObj_payWayId">支付方式：</label>
                <select id="payWayObj_payWayId" name="payWayObj.payWayId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(PayWay payWayTemp:payWayList) {
	 					String selected = "";
 					if(payWayObj!=null && payWayObj.getPayWayId()!=null && payWayObj.getPayWayId().intValue()==payWayTemp.getPayWayId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=payWayTemp.getPayWayId() %>" <%=selected %>><%=payWayTemp.getPayWayName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="payAccount">支付账号:</label>
				<input type="text" id="payAccount" name="payAccount" value="<%=payAccount %>" class="form-control" placeholder="请输入支付账号">
			</div>






			<div class="form-group">
				<label for="incomeDate">收入日期:</label>
				<input type="text" id="incomeDate" name="incomeDate" class="form-control"  placeholder="请选择收入日期" value="<%=incomeDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">收入用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="incomeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;收入信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date income_incomeDate_edit col-md-12" data-link-field="income_incomeDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#incomeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxIncomeModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.incomeQueryForm.currentPage.value = currentPage;
    document.incomeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.incomeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.incomeQueryForm.currentPage.value = pageValue;
    documentincomeQueryForm.submit();
}

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
				$('#incomeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除收入信息*/
function incomeDelete(incomeId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Income/deletes",
			data : {
				incomeIds : incomeId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#incomeQueryForm").submit();
					//location.href= basePath + "Income/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

