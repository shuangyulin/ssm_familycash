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
import com.chengxusheji.service.IncomeService;
import com.chengxusheji.po.Income;
import com.chengxusheji.service.IncomeTypeService;
import com.chengxusheji.po.IncomeType;
import com.chengxusheji.service.PayWayService;
import com.chengxusheji.po.PayWay;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Income管理控制层
@Controller
@RequestMapping("/Income")
public class IncomeController extends BaseController {

    /*业务层对象*/
    @Resource IncomeService incomeService;

    @Resource IncomeTypeService incomeTypeService;
    @Resource PayWayService payWayService;
    @Resource UserInfoService userInfoService;
	@InitBinder("incomeTypeObj")
	public void initBinderincomeTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("incomeTypeObj.");
	}
	@InitBinder("payWayObj")
	public void initBinderpayWayObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("payWayObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("income")
	public void initBinderIncome(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("income.");
	}
	/*跳转到添加Income视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Income());
		/*查询所有的IncomeType信息*/
		List<IncomeType> incomeTypeList = incomeTypeService.queryAllIncomeType();
		request.setAttribute("incomeTypeList", incomeTypeList);
		/*查询所有的PayWay信息*/
		List<PayWay> payWayList = payWayService.queryAllPayWay();
		request.setAttribute("payWayList", payWayList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Income_add";
	}

	/*客户端ajax方式提交添加收入信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Income income, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        incomeService.addIncome(income);
        message = "收入添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询收入信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("incomeTypeObj") IncomeType incomeTypeObj,String incomeFrom,@ModelAttribute("payWayObj") PayWay payWayObj,String payAccount,String incomeDate,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (incomeFrom == null) incomeFrom = "";
		if (payAccount == null) payAccount = "";
		if (incomeDate == null) incomeDate = "";
		if(rows != 0)incomeService.setRows(rows);
		List<Income> incomeList = incomeService.queryIncome(incomeTypeObj, incomeFrom, payWayObj, payAccount, incomeDate, userObj, page);
	    /*计算总的页数和总的记录数*/
	    incomeService.queryTotalPageAndRecordNumber(incomeTypeObj, incomeFrom, payWayObj, payAccount, incomeDate, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = incomeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = incomeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Income income:incomeList) {
			JSONObject jsonIncome = income.getJsonObject();
			jsonArray.put(jsonIncome);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询收入信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Income> incomeList = incomeService.queryAllIncome();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Income income:incomeList) {
			JSONObject jsonIncome = new JSONObject();
			jsonIncome.accumulate("incomeId", income.getIncomeId());
			jsonIncome.accumulate("incomeFrom", income.getIncomeFrom());
			jsonArray.put(jsonIncome);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询收入信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("incomeTypeObj") IncomeType incomeTypeObj,String incomeFrom,@ModelAttribute("payWayObj") PayWay payWayObj,String payAccount,String incomeDate,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (incomeFrom == null) incomeFrom = "";
		if (payAccount == null) payAccount = "";
		if (incomeDate == null) incomeDate = "";
		List<Income> incomeList = incomeService.queryIncome(incomeTypeObj, incomeFrom, payWayObj, payAccount, incomeDate, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    incomeService.queryTotalPageAndRecordNumber(incomeTypeObj, incomeFrom, payWayObj, payAccount, incomeDate, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = incomeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = incomeService.getRecordNumber();
	    request.setAttribute("incomeList",  incomeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("incomeTypeObj", incomeTypeObj);
	    request.setAttribute("incomeFrom", incomeFrom);
	    request.setAttribute("payWayObj", payWayObj);
	    request.setAttribute("payAccount", payAccount);
	    request.setAttribute("incomeDate", incomeDate);
	    request.setAttribute("userObj", userObj);
	    List<IncomeType> incomeTypeList = incomeTypeService.queryAllIncomeType();
	    request.setAttribute("incomeTypeList", incomeTypeList);
	    List<PayWay> payWayList = payWayService.queryAllPayWay();
	    request.setAttribute("payWayList", payWayList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Income/income_frontquery_result"; 
	}

     /*前台查询Income信息*/
	@RequestMapping(value="/{incomeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer incomeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键incomeId获取Income对象*/
        Income income = incomeService.getIncome(incomeId);

        List<IncomeType> incomeTypeList = incomeTypeService.queryAllIncomeType();
        request.setAttribute("incomeTypeList", incomeTypeList);
        List<PayWay> payWayList = payWayService.queryAllPayWay();
        request.setAttribute("payWayList", payWayList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("income",  income);
        return "Income/income_frontshow";
	}

	/*ajax方式显示收入修改jsp视图页*/
	@RequestMapping(value="/{incomeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer incomeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键incomeId获取Income对象*/
        Income income = incomeService.getIncome(incomeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonIncome = income.getJsonObject();
		out.println(jsonIncome.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新收入信息*/
	@RequestMapping(value = "/{incomeId}/update", method = RequestMethod.POST)
	public void update(@Validated Income income, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			incomeService.updateIncome(income);
			message = "收入更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "收入更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除收入信息*/
	@RequestMapping(value="/{incomeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer incomeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  incomeService.deleteIncome(incomeId);
	            request.setAttribute("message", "收入删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "收入删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条收入记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String incomeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = incomeService.deleteIncomes(incomeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出收入信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("incomeTypeObj") IncomeType incomeTypeObj,String incomeFrom,@ModelAttribute("payWayObj") PayWay payWayObj,String payAccount,String incomeDate,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(incomeFrom == null) incomeFrom = "";
        if(payAccount == null) payAccount = "";
        if(incomeDate == null) incomeDate = "";
        List<Income> incomeList = incomeService.queryIncome(incomeTypeObj,incomeFrom,payWayObj,payAccount,incomeDate,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Income信息记录"; 
        String[] headers = { "收入id","收入类型","收入来源","支付方式","支付账号","收入金额","收入日期","收入用户"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<incomeList.size();i++) {
        	Income income = incomeList.get(i); 
        	dataset.add(new String[]{income.getIncomeId() + "",income.getIncomeTypeObj().getTypeName(),income.getIncomeFrom(),income.getPayWayObj().getPayWayName(),income.getPayAccount(),income.getIncomeMoney() + "",income.getIncomeDate(),income.getUserObj().getName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Income.xls");//filename是下载的xls的名，建议最好用英文 
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
