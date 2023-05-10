<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Expend" %>
<%@ page import="com.chengxusheji.po.ExpendType" %>
<%@ page import="com.chengxusheji.po.PayWay" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Expend> expendList = (List<Expend>)request.getAttribute("expendList");
    //获取所有的exprendTypeObj信息
    List<ExpendType> expendTypeList = (List<ExpendType>)request.getAttribute("expendTypeList");
    //获取所有的payWayObj信息
    List<PayWay> payWayList = (List<PayWay>)request.getAttribute("payWayList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    ExpendType exprendTypeObj = (ExpendType)request.getAttribute("exprendTypeObj");
    String expendPurpose = (String)request.getAttribute("expendPurpose"); //支出用途查询关键字
    PayWay payWayObj = (PayWay)request.getAttribute("payWayObj");
    String payAccount = (String)request.getAttribute("payAccount"); //支付账号查询关键字
    String expendDate = (String)request.getAttribute("expendDate"); //支付日期查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>支出查询</title>
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
			    	<li role="presentation" class="active"><a href="#expendListPanel" aria-controls="expendListPanel" role="tab" data-toggle="tab">支出列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Expend/expend_frontAdd.jsp" style="display:none;">添加支出</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="expendListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>支出id</td><td>支出类型</td><td>支出用途</td><td>支付方式</td><td>支付账号</td><td>支付金额</td><td>支付日期</td><td>支出用户</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<expendList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Expend expend = expendList.get(i); //获取到支出对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=expend.getExpendId() %></td>
 											<td><%=expend.getExprendTypeObj().getExpendTypeName() %></td>
 											<td><%=expend.getExpendPurpose() %></td>
 											<td><%=expend.getPayWayObj().getPayWayName() %></td>
 											<td><%=expend.getPayAccount() %></td>
 											<td><%=expend.getExpendMoney() %></td>
 											<td><%=expend.getExpendDate() %></td>
 											<td><%=expend.getUserObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Expend/<%=expend.getExpendId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="expendEdit('<%=expend.getExpendId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="expendDelete('<%=expend.getExpendId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>支出查询</h1>
		</div>
		<form name="expendQueryForm" id="expendQueryForm" action="<%=basePath %>Expend/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="exprendTypeObj_expendTypeId">支出类型：</label>
                <select id="exprendTypeObj_expendTypeId" name="exprendTypeObj.expendTypeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ExpendType expendTypeTemp:expendTypeList) {
	 					String selected = "";
 					if(exprendTypeObj!=null && exprendTypeObj.getExpendTypeId()!=null && exprendTypeObj.getExpendTypeId().intValue()==expendTypeTemp.getExpendTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=expendTypeTemp.getExpendTypeId() %>" <%=selected %>><%=expendTypeTemp.getExpendTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="expendPurpose">支出用途:</label>
				<input type="text" id="expendPurpose" name="expendPurpose" value="<%=expendPurpose %>" class="form-control" placeholder="请输入支出用途">
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
				<label for="expendDate">支付日期:</label>
				<input type="text" id="expendDate" name="expendDate" class="form-control"  placeholder="请选择支付日期" value="<%=expendDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">支出用户：</label>
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
<div id="expendEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;支出信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date expend_expendDate_edit col-md-12" data-link-field="expend_expendDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#expendEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxExpendModify();">提交</button>
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
    document.expendQueryForm.currentPage.value = currentPage;
    document.expendQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.expendQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.expendQueryForm.currentPage.value = pageValue;
    documentexpendQueryForm.submit();
}

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
				$('#expendEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除支出信息*/
function expendDelete(expendId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Expend/deletes",
			data : {
				expendIds : expendId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#expendQueryForm").submit();
					//location.href= basePath + "Expend/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

