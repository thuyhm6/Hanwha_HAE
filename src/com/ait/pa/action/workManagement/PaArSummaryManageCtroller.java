package com.ait.pa.action.workManagement;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.ModelAndView;

import com.ait.pa.service.workManagement.PaArSummaryManageSer;
import com.ait.pa.service.workManagement.PaPayScheduleSer;
import com.ait.sys.bean.AdminBean;
import com.ait.web.i18n.TipMessage;
import com.ait.web.util.SessionUtil;
import com.ait.web.util.StringUtil;

@Controller
@RequestMapping(value = "/pa/workManagement")
public class PaArSummaryManageCtroller {
	Logger logger = Logger.getLogger(PaArSummaryManageCtroller.class);

	@Autowired
	private PaArSummaryManageSer paArSummaryManageSer;
	
	@Autowired
	private PaPayScheduleSer paPayScheduleSer;

	/**
	 * 考勤总计管理
	 * 
	 */
	@RequestMapping(value = "/viewPaArSummaryForManageList")
	public ModelAndView viewPaArSummaryForManageList(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		
		List paPayScheduleList = this.paPayScheduleSer
				.getPayScheduleAllWithPaConfirmList(request);
		modelMap.put("paPayScheduleList", paPayScheduleList);

		List PaArSummaryForManageList = this.paArSummaryManageSer.getPaArSummaryForManageList(request);

		modelMap.put("PaArSummaryForManageList", PaArSummaryForManageList);
//		modelMap.put("PAY_SCHEDULE_NO", request.getParameter("PAY_SCHEDULE_NO"));
//		modelMap.put("empInfoShow", request.getParameter("empInfoShow"));
		
		return new ModelAndView("/pa/workManagement/viewPaArSummaryForManageList", modelMap);

	}
	/**
	 * 修改考勤总计管理信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePaArSummaryForManageInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map updatePaArSummaryForManageInfo(HttpServletRequest request)throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = this.paArSummaryManageSer.updatePaArSummaryForManageInfo(request);
		
		if(result == 1){
			map.put("statusCode", "200");
			map.put("message", TipMessage.getTipMessage("alert.message.update_success",request));//修改成功
			map.put("formId", "searchViewPaArSummaryForManageForm");
		}else{
			map.put("statusCode", "300");
			map.put("message", TipMessage.getTipMessage("alert.message.update_fail",request));//修改失败
			map.put("formId", "searchViewPaArSummaryForManageForm");
		}
		return map;
	}
	

	/**
	 * 考勤总计管理
	 * 
	 */
	@RequestMapping(value = "/viewPaArSummaryForManageExcel")
	public void viewPaArSummaryForManageExcel(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		
		List paPayScheduleList = this.paPayScheduleSer
				.getPayScheduleAllWithPaConfirmList(request);
		modelMap.put("paPayScheduleList", paPayScheduleList);

		modelMap = this.paArSummaryManageSer.getPaArSummaryForManageExcel(request,response,modelMap);

		// 报表模板路径
		String webPath = request.getRealPath("/").replace("\\", "/");
		String templateFileName = webPath;
		String destFileName = webPath;
		templateFileName += "/resources/template/report/exl_autoExcel.xls";
		destFileName += "/resources/template/report/exl_autoExcel_out.xls";
		// execl导出处理
		XLSTransformer transformer = new XLSTransformer();
		try {
			transformer.transformXLS(templateFileName, modelMap,
					destFileName);
		} catch (ParsePropertyException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;fileName=ArSummary.xls");
		try {
			File file = new File(destFileName);
			InputStream inputStream = new FileInputStream(file);
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[102400];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			inputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/viewPaArOtOver40h")
	public ModelAndView viewPaArOtOver40h(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		List applyOtInfoList = (List) paArSummaryManageSer.viewPaArOtOver40h(request);
		String firstFlag = request.getParameter("firstFlag");
		modelMap.put("KEY",StringUtil.checkNull(request.getParameter("seach_KEY")));
		modelMap.put("OT_LENGTH",StringUtil.checkNull(request.getParameter("seach_OT_LENGTH")));
		modelMap.put("START_DATE",StringUtil.checkNull(request.getParameter("seach_START_DATE")));
		modelMap.put("END_DATE",StringUtil.checkNull(request.getParameter("seach_END_DATE")));
		modelMap.put("DEPTNO", request.getParameter("seach_DEPTNO"));
		if (firstFlag ==null || "".equals(firstFlag)) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd"); 
			Calendar c = Calendar.getInstance();    
			if((request.getParameter("seach_START_DATE")==""||request.getParameter("seach_START_DATE")==null )&& (request.getParameter("seach_END_DATE")==""||request.getParameter("seach_END_DATE")==null)){
				//获取当前年第一天：
				c.add(Calendar.DATE, -1);
				String first = format.format(c.getTime());
				modelMap.put("START_DATE",first);
				//获取当前月最后一天：
				c = Calendar.getInstance();  
				String last = format.format(c.getTime());
				modelMap.put("END_DATE",last);
			}
		}
		modelMap.put("otCoordList", applyOtInfoList);
		modelMap.put("otCoordListCnt",applyOtInfoList==null ? 0: applyOtInfoList.size());
		return new ModelAndView("/pa/workManagement/viewPaArOtOver40h", modelMap);
	}
}
