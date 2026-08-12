package com.ait.ar.action.attendanceMintenance;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.ModelAndView;

import com.ait.ar.service.CycleSer;
import com.ait.ar.service.EmpCalendarSer;
import com.ait.ess.dao.InfoApplyLeaveDao;
import com.ait.sys.bean.AdminBean;
import com.ait.sys.service.ToolMenuSer;
import com.ait.web.util.SessionUtil;

/**
 * Copyright:   LDCC
 * Company:     LDCC
 * @fileName: EmpCalendarCtroller.java
 * @Description:
 * @Create date: 2012-2-6 上午10:49:39
 * @Create by: jiahc(jiahongchang@ait.net.cn)
 * @version 5.1
 */
@Controller
@RequestMapping(value = "/ar/attendanceMintenance")
public class EmpCalendarCtroller {
	Logger logger = Logger.getLogger(EmpCalendarCtroller.class);
	@Autowired
	private EmpCalendarSer empCalendarSer;
	@Autowired
	private ToolMenuSer toolMenuSer;
	@Autowired
	private InfoApplyLeaveDao infoApplyLeaveDao;
    
 
	/**
	 * 个人日历查看页面(add EmpShift View)
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEmpCalendar")
	public ModelAndView addEmpShiftView(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
	   String calendarHtml = this.empCalendarSer.getEmpCalendarViewHtml(request) ;
	   
	   HttpSession session = request.getSession() ;
	   AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
	   String noEmpFlag = request.getParameter("NO_EMP");
	   modelMap.put("NO_EMP", noEmpFlag);
	   if (ObjectUtils.toString(request.getParameter("person_id")).equals("")) {
		   if("Y".equals(noEmpFlag)){
			    modelMap.put("empid", "");
			    modelMap.put("name", "") ;
				modelMap.put("deptname", "") ;
				modelMap.put("person_id", "") ;
			}else{
				modelMap.put("empid", admin.getEmpID());
				modelMap.put("name", admin.getLocalName()) ;
				modelMap.put("deptname", admin.getDepartment()) ;
				modelMap.put("person_id", admin.getPersonId()) ;
			}
			modelMap.put("cpny_id", admin.getCpnyId()) ;
			modelMap.put("STAT_NO", admin.getStatNo() != null ? admin.getStatNo() : "") ;
		}else{
			LinkedHashMap empMap = (LinkedHashMap)this.empCalendarSer.getEmpInfo(request);
			if("Y".equals(noEmpFlag)){
			    modelMap.put("empid", "");
			    modelMap.put("name", "") ;
				modelMap.put("deptname", "") ;
				modelMap.put("person_id", "") ;
			}else{
				modelMap.put("empid", empMap.get("EMPID").toString());
				modelMap.put("name", empMap.get("LOCAL_NAME").toString()) ;
				modelMap.put("deptname", empMap.get("DEPTNAME").toString()) ;
				modelMap.put("person_id", empMap.get("PERSON_ID").toString()) ;
			}
			modelMap.put("cpny_id", empMap.get("CPNY_ID").toString()) ;
			modelMap.put("STAT_NO", empMap.get("STAT_NO") != null ? empMap.get("STAT_NO").toString() : "") ;
        }
	   LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap fileParam = new LinkedHashMap();
		fileParam.put("APPLY_TYPE", "COMPANY_CALENDAR");
		fileParam.put("APPLY_NO", "11111112");
		List fileList = infoApplyLeaveDao.getEssFileList(fileParam);
		param.put("fileList",fileList);
		modelMap.put("fileRoomInfo", param);
		modelMap.put("calendarHtml", calendarHtml) ;
		modelMap.put("toolbarInfo", request.getParameter("menuNo") != null ? 
				toolMenuSer.getToolMenu(request) : toolMenuSer.getToolMenuForNo(request, "14015886")) ;
		return new ModelAndView("/ar/attendanceMintenance/viewEmpCalendar",modelMap);
	}

	/**
	 * 个人日历修改页面(update EmpCalendar View)
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateEmpCalendarView",method = RequestMethod.GET)
	public ModelAndView updateEmpCalendarView(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		String calendarHtml = this.empCalendarSer.getEmpCalendarViewHtml(request) ;
		
		modelMap.put("calendarHtml", calendarHtml) ;
		
		return new ModelAndView("/ar/attendanceMintenance/viewEmpCalendar",modelMap);
	}
	
	/**
	 * 个人日历页面修改(update EmpCalendar Info)
	 * @param request
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateEmpCalendarInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateEmpCalendarInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "" ;
		
		int result = this.empCalendarSer.updateEmpCalendarInfo(request) ;
		
		if(result == 1){
			returnString = "Y" ;
		}else{
			returnString = "N" ;
		}
	    
		return returnString;
	}
	
}
