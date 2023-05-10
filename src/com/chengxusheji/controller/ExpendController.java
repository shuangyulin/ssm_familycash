package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ExpendService;
import com.chengxusheji.po.Expend;
import com.chengxusheji.service.ExpendTypeService;
import com.chengxusheji.po.ExpendType;
import com.chengxusheji.service.PayWayService;
import com.chengxusheji.po.PayWay;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Expend管理控制层
@Controller
@RequestMapping("/Expend")
public class ExpendController extends BaseController {

    /*业务层对象*/
    @Resource ExpendService expendService;

    @Resource ExpendTypeService expendTypeService;
    @Resource PayWayService payWayService;
    @Resource UserInfoService userInfoService;
	@InitBinder("exprendTypeObj")
	public void initBinderexprendTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("exprendTypeObj.");
	}
	@InitBinder("payWayObj")
	public void initBinderpayWayObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("payWayObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("expend")
	public void initBinderExpend(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("expend.");
	}
	/*跳转到添加Expend视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Expend());
		/*查询所有的ExpendType信息*/
		List<ExpendType> expendTypeList = expendTypeService.queryAllExpendType();
		request.setAttribute("expendTypeList", expendTypeList);
		/*查询所有的PayWay信息*/
		List<PayWay> payWayList = payWayService.queryAllPayWay();
		request.setAttribute("payWayList", payWayList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Expend_add";
	}

	/*客户端ajax方式提交添加支出信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Expend expend, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        expendService.addExpend(expend);
        message = "支出添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询支出信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("exprendTypeObj") ExpendType exprendTypeObj,String expendPurpose,@ModelAttribute("payWayObj") PayWay payWayObj,String payAccount,String expendDate,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (expendPurpose == null) expendPurpose = "";
		if (payAccount == null) payAccount = "";
		if (expendDate == null) expendDate = "";
		if(rows != 0)expendService.setRows(rows);
		List<Expend> expendList = expendService.queryExpend(exprendTypeObj, expendPurpose, payWayObj, payAccount, expendDate, userObj, page);
	    /*计算总的页数和总的记录数*/
	    expendService.queryTotalPageAndRecordNumber(exprendTypeObj, expendPurpose, payWayObj, payAccount, expendDate, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = expendService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = expendService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Expend expend:expendList) {
			JSONObject jsonExpend = expend.getJsonObject();
			jsonArray.put(jsonExpend);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询支出信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Expend> expendList = expendService.queryAllExpend();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Expend expend:expendList) {
			JSONObject jsonExpend = new JSONObject();
			jsonExpend.accumulate("expendId", expend.getExpendId());
			jsonExpend.accumulate("expendPurpose", expend.getExpendPurpose());
			jsonArray.put(jsonExpend);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询支出信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("exprendTypeObj") ExpendType exprendTypeObj,String expendPurpose,@ModelAttribute("payWayObj") PayWay payWayObj,String payAccount,String expendDate,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (expendPurpose == null) expendPurpose = "";
		if (payAccount == null) payAccount = "";
		if (expendDate == null) expendDate = "";
		List<Expend> expendList = expendService.queryExpend(exprendTypeObj, expendPurpose, payWayObj, payAccount, expendDate, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    expendService.queryTotalPageAndRecordNumber(exprendTypeObj, expendPurpose, payWayObj, payAccount, expendDate, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = expendService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = expendService.getRecordNumber();
	    request.setAttribute("expendList",  expendList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("exprendTypeObj", exprendTypeObj);
	    request.setAttribute("expendPurpose", expendPurpose);
	    request.setAttribute("payWayObj", payWayObj);
	    request.setAttribute("payAccount", payAccount);
	    request.setAttribute("expendDate", expendDate);
	    request.setAttribute("userObj", userObj);
	    List<ExpendType> expendTypeList = expendTypeService.queryAllExpendType();
	    request.setAttribute("expendTypeList", expendTypeList);
	    List<PayWay> payWayList = payWayService.queryAllPayWay();
	    request.setAttribute("payWayList", payWayList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Expend/expend_frontquery_result"; 
	}

     /*前台查询Expend信息*/
	@RequestMapping(value="/{expendId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer expendId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键expendId获取Expend对象*/
        Expend expend = expendService.getExpend(expendId);

        List<ExpendType> expendTypeList = expendTypeService.queryAllExpendType();
        request.setAttribute("expendTypeList", expendTypeList);
        List<PayWay> payWayList = payWayService.queryAllPayWay();
        request.setAttribute("payWayList", payWayList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("expend",  expend);
        return "Expend/expend_frontshow";
	}

	/*ajax方式显示支出修改jsp视图页*/
	@RequestMapping(value="/{expendId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer expendId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键expendId获取Expend对象*/
        Expend expend = expendService.getExpend(expendId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonExpend = expend.getJsonObject();
		out.println(jsonExpend.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新支出信息*/
	@RequestMapping(value = "/{expendId}/update", method = RequestMethod.POST)
	public void update(@Validated Expend expend, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			expendService.updateExpend(expend);
			message = "支出更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "支出更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除支出信息*/
	@RequestMapping(value="/{expendId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer expendId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  expendService.deleteExpend(expendId);
	            request.setAttribute("message", "支出删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "支出删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条支出记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String expendIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = expendService.deleteExpends(expendIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出支出信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("exprendTypeObj") ExpendType exprendTypeObj,String expendPurpose,@ModelAttribute("payWayObj") PayWay payWayObj,String payAccount,String expendDate,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(expendPurpose == null) expendPurpose = "";
        if(payAccount == null) payAccount = "";
        if(expendDate == null) expendDate = "";
        List<Expend> expendList = expendService.queryExpend(exprendTypeObj,expendPurpose,payWayObj,payAccount,expendDate,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Expend信息记录"; 
        String[] headers = { "支出id","支出类型","支出用途","支付方式","支付账号","支付金额","支付日期","支出用户"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<expendList.size();i++) {
        	Expend expend = expendList.get(i); 
        	dataset.add(new String[]{expend.getExpendId() + "",expend.getExprendTypeObj().getExpendTypeName(),expend.getExpendPurpose(),expend.getPayWayObj().getPayWayName(),expend.getPayAccount(),expend.getExpendMoney() + "",expend.getExpendDate(),expend.getUserObj().getName()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Expend.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
