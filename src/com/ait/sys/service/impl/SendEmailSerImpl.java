package com.ait.sys.service.impl;

import hanwha.neo.branch.ss.approval.vo.ApprovalDocumentStatus;
import hanwha.neo.branch.ss.approval.vo.MisKey;
import hanwha.neo.branch.ss.approval.vo.SignerInfo;
import hanwha.neo.branch.ss.common.vo.WsException;
import hanwha.neo.branch.ss.org.service.NeoOrgWsProxy;
import hanwha.neo.branch.ss.org.vo.OrgUserVO;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.rmi.RemoteException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.ait.edu.dao.TrainEducationDao;
import com.ait.ess.dao.InfoApplyDao;
import com.ait.ess.dao.InfoApplyLeaveDao;
import com.ait.evs.dao.EvsManageDao;
import com.ait.sys.dao.SendEmailDao;
import com.ait.sys.service.SendEmailSer;
import com.ait.web.util.DateUtil;
import com.ait.web.util.MailManager;
import com.ait.web.util.MailSendApprovalManager;
import com.ait.web.util.ObjectBindUtil;
import com.ait.web.util.StringUtil;
import com.lowagie.text.pdf.BaseFont;

/**
 * 发送审批邮件
 *
 */
@Service
public class SendEmailSerImpl implements SendEmailSer{

	//Logger logger = Logger.getLogger(SendEmailSer.class);

	@Autowired
	private InfoApplyDao infoApplyDao;
	@Autowired
	MailManager mailManger;
	@Autowired
	MailSendApprovalManager mailSendApprovalManager;
	@Autowired
	private EvsManageDao evsManageDao;
	@Autowired
	private TrainEducationDao eduTrainDao;
	@Autowired
	private SendEmailDao sendEmailDao;
	@Autowired
	private InfoApplyLeaveDao infoApplyLeaveDao;
	
	public void sendAffirmEmail(){
		boolean flag = true;
		List sendAffirmEmailList = infoApplyDao.viewApprovalInfo(null, "sendAffirmEmail");
		if(sendAffirmEmailList != null && sendAffirmEmailList.size() > 0){
			for (int i = 0;i < sendAffirmEmailList.size(); i++){
				Map map = (Map)sendAffirmEmailList.get(i);
				//0：如果是待发送状态 直接发送    3：需要先封装模板的，先读取模板再发送
				if("3".equals(StringUtil.checkNull(map.get("SEND_FLAG")))){
					if("31".equals(StringUtil.checkNull(map.get("APPLY_TYPE_CODE")))){//加班
						this.composeOtMailTemplate(map);
					}else if("21".equals(StringUtil.checkNull(map.get("APPLY_TYPE_CODE")))){//考勤
						this.composeLeaveMailTemplate(map);
					}
				}
				flag = mailManger.sendmail(map);
				//更新邮件发送状态
				try {
					if(flag){
						map.put("SEND_FINISH_FLAG", 1);
					}else{
						map.put("SEND_FINISH_FLAG", 4);
					}
					infoApplyDao.viewModifyApprovalInfo(map, "updateMailSendStatus");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 封装加班信息
	 * @param map
	 * @return
	 */
	private void composeOtMailTemplate(Map map){
		Map resultMap = null;
		StringBuffer affirmContent = new StringBuffer();
		List otApplyInfo = infoApplyDao.viewApprovalInfo(map, "getSSTOtInfoList");
		if(otApplyInfo != null && otApplyInfo.size() > 0){
			resultMap = (Map)otApplyInfo.get(0);
		}
		if(resultMap != null){
			//获取当前审批者
			List viewAffirmList = infoApplyDao.viewApprovalInfo(map, "viewAffirmList");
			if(viewAffirmList != null && viewAffirmList.size() > 0){
				for(int i=0;i<viewAffirmList.size();i++){
					Map affirmMap = (Map)viewAffirmList.get(i);
					if(i == 0){
						resultMap.put("TITLE", StringUtil.checkNull(affirmMap.get("TITLE")));
						resultMap.put("APPLY_PERSON_INFO", StringUtil.checkNull(affirmMap.get("APPLY_PERSON_INFO")));
					}
					affirmContent.append("<tr>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_LEVEL")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_TYPE_NAME")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_FLAG_NAME")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_NAME")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_CONTENT")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("UPDATE_DATE")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("DEPTNAME")) + "</td>");
					affirmContent.append("</tr>");
				}
			}
			resultMap.put("AFFIRM_CONTENT", affirmContent.toString());
			resultMap.put("MAIL_LOGIN_EMPID", map.get("MAIL_LOGIN_EMPID"));
			map.put("EMAIL_CONTENT", MailManager.composeTemplate("OT", resultMap));
		}
	}
	
	/**
	 * 封装休假信息
	 * @param map
	 * @return
	 */
	private void composeLeaveMailTemplate(Map map){
		Map resultMap = null;
		StringBuffer affirmContent = new StringBuffer();
		List LeaveApplyInfo = infoApplyDao.viewApprovalInfo(map, "getSSTLeaveAffirmInfoList");
		if(LeaveApplyInfo != null && LeaveApplyInfo.size() > 0){
			resultMap = (Map)LeaveApplyInfo.get(0);
		}
		if(resultMap != null){
			//获取当前审批者
			List viewAffirmList = infoApplyDao.viewApprovalInfo(map, "viewAffirmList");
			if(viewAffirmList != null && viewAffirmList.size() > 0){
				for(int i=0;i<viewAffirmList.size();i++){
					Map affirmMap = (Map)viewAffirmList.get(i);
					if(i == 0){
						resultMap.put("TITLE", StringUtil.checkNull(affirmMap.get("TITLE")));
						resultMap.put("APPLY_PERSON_INFO", StringUtil.checkNull(affirmMap.get("APPLY_PERSON_INFO")));
					}
					affirmContent.append("<tr>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_LEVEL")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_TYPE_NAME")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_FLAG_NAME")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_NAME")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("AFFIRM_CONTENT")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("UPDATE_DATE")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("DEPTNAME")) + "</td>");
					affirmContent.append("</tr>");
				}
			}
			resultMap.put("AFFIRM_CONTENT", affirmContent.toString());
			resultMap.put("MAIL_LOGIN_EMPID", map.get("MAIL_LOGIN_EMPID"));
			//年假 封装年假使用情况
			if("26".equals(StringUtil.checkNull(map.get("APPLY_TYPE")))){
				Map vacTempMap = new LinkedHashMap();
				vacTempMap.put("APPLY_PERSON_ID", map.get("APPLY_PERSON_ID"));
				vacTempMap.put("YEAR", StringUtil.checkNull(map.get("YEAR")));
				List empVacInfoList = infoApplyDao.viewApprovalInfo(vacTempMap, "getEmpVacInfoSSTForDisplay");
				if(empVacInfoList != null && empVacInfoList.size() > 0){
					Map vacMap = (Map)empVacInfoList.get(0);
					resultMap.put("TOTAL_VAC", vacMap.get("TOTAL_VAC"));
					resultMap.put("USE_VAC", vacMap.get("USE_VAC"));
					resultMap.put("LEAVE_VAC", vacMap.get("LEAVE_VAC"));
				}else{
					resultMap.put("TOTAL_VAC", "0");
					resultMap.put("USE_VAC", "0");
					resultMap.put("LEAVE_VAC", "0");
				}
				map.put("EMAIL_CONTENT", MailManager.composeTemplate("VAC", resultMap));
			}else{
				map.put("EMAIL_CONTENT", MailManager.composeTemplate("LEAVE", resultMap));
			}
		}
	}
	
	/**
	 * HAE审批邮件发送
	 */
	public void sendAffirmEmailHAE(int affirmLevel){

		//读取模板信息
		String template = MailManager.readTemplate("approvalHAE");

		List isWeekendList = infoApplyDao.viewApprovalInfo(null, "isWeekend");
		Map isWeekendmap = (Map)isWeekendList.get(0);
		//获取需要接受邮件的审批人
		List sendAffirmEmailList = new ArrayList();
		if(affirmLevel == 1){
			sendAffirmEmailList = infoApplyDao.viewApprovalInfo(null, "getAffirmDeptManger1");
		}else if(affirmLevel == 2){
			sendAffirmEmailList = infoApplyDao.viewApprovalInfo(null, "getAffirmDeptManger2");
		}else if(affirmLevel == 3){
			sendAffirmEmailList = infoApplyDao.viewApprovalInfo(null, "getAffirmSuper");
		}
		
		//封装邮件信息并发送
		if(sendAffirmEmailList != null && sendAffirmEmailList.size() > 0){
			for (int i = 0;i < sendAffirmEmailList.size(); i++){
				Map map = (Map)sendAffirmEmailList.get(i);
				/*已根据国籍匹配语言，再此注释*/
				/*if(affirmLevel == 2){
					map.put("MAIL_LANGUAGE", "ko");
				}else{
					map.put("MAIL_LANGUAGE", "vi");
				}*/
				if(StringUtil.checkNull(isWeekendmap.get("CURRENT_DATE")).equals(StringUtil.checkNull(isWeekendmap.get("WORKDAY")))){
					if(!StringUtil.checkNull(isWeekendmap.get("CURRENT_DATE")).equals(StringUtil.checkNull(isWeekendmap.get("END_DATE")))){
						map.put("EMAIL_TITLE", "Approve Info Weekend【YHR】Date：" + isWeekendmap.get("START_DATE") + "~" + isWeekendmap.get("END_DATE"));
						map.put("WEEKEND_FLAG", "WEEKEND");
						map.put("START_DATE", isWeekendmap.get("START_DATE"));
						map.put("END_DATE", isWeekendmap.get("END_DATE"));
						//封装模板信息
						this.composeMailTemplate(template,map);
						//发送
						mailManger.sendmail(map);
					}
					map.put("EMAIL_TITLE", "Approve Info【YHR】Date：" + isWeekendmap.get("CURRENT_DATE"));
					map.put("WEEKEND_FLAG", "WORKDAY");
					//封装模板信息
					this.composeMailTemplate(template,map);
					//发送
					mailManger.sendmail(map);
				}
			}
		}
	}

	/**
	 * 封装审批信息TSTO
	 * @param map
	 * @return
	 */
	private void composeMailTemplate(String template,Map map){
		Map resultMap = new LinkedHashMap();
		//只有工作日才有必要查询申请的休假信息
		if(StringUtil.checkNull(map.get("WEEKEND_FLAG")).equals("WORKDAY")){
			composeMailTemplateAtt(map,resultMap);
		}
		composeMailTemplateOt(map,resultMap);
		composeMailTemplateOtTotal(map,resultMap);
		resultMap.put("MAIL_LOGIN_EMPID", map.get("MAIL_LOGIN_EMPID"));
//		resultMap.put("MAIL_LANGUAGE", map.get("MAIL_LANGUAGE"));
		map.put("EMAIL_CONTENT", MailManager.composeTemplateByParam(template, resultMap));
		map.put("EMAIL_CONTENT", map.get("EMAIL_CONTENT").toString().replace("{MAIL_LANGUAGE}",map.get("MAIL_LANGUAGE").toString()));
	}

	/**
	 * 封装考勤信息HTSV
	 * @param map
	 * @return
	 */
	private void composeMailTemplateAtt(Map map,Map resultMap){
		StringBuffer affirmContent = new StringBuffer();
		//工作日 周末 区分标示
		//String weekFlag = StringUtil.checkNull(map.get("WEEKEND_FLAG"));
		if(resultMap != null){
			//封装考勤信息HTSV
			List viewAffirmList = null;
			//if("WEEKEND".equals(weekFlag)){
			//	viewAffirmList = infoApplyDao.viewApprovalInfo(map, "composeMailTemplateChuchaiWEEKEND");
			//}else{
			//获取考勤申请信息
				viewAffirmList = infoApplyDao.viewApprovalInfo(map, "composeMailTemplateAtt");
			//}
			if(viewAffirmList != null && viewAffirmList.size() > 0){
				for(int i=0;i<viewAffirmList.size();i++){
					Map affirmMap = (Map)viewAffirmList.get(i);
					affirmContent.append("<tr>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + (i + 1) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: left\">" + StringUtil.checkNull(affirmMap.get("ORG_NAME_LOCAL")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("EMP_CNT")) + "</td>");
					affirmContent.append("</tr>");
				}
			}
			resultMap.put("AFFIRM_CONTENT_CHUCHAI", affirmContent.toString());
		}
	}
	
	/**
	 * 封装加班信息HTSV
	 * @param map
	 * @return
	 */
	private void composeMailTemplateOt(Map map,Map resultMap){
		StringBuffer affirmContent = new StringBuffer();
		//工作日 周末 区分标示
		String weekFlag = StringUtil.checkNull(map.get("WEEKEND_FLAG"));
		if(resultMap != null){
			//获取封装加班信息TSTO
			List viewAffirmList = null;
			if("WEEKEND".equals(weekFlag)){
				viewAffirmList = infoApplyDao.viewApprovalInfo(map, "composeMailTemplateOtWEEKEND");
			}else{
				viewAffirmList = infoApplyDao.viewApprovalInfo(map, "composeMailTemplateOt");
			}
			if(viewAffirmList != null && viewAffirmList.size() > 0){
				for(int i=0;i<viewAffirmList.size();i++){
					Map affirmMap = (Map)viewAffirmList.get(i);
					affirmContent.append("<tr>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + (i + 1) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: left\">" + StringUtil.checkNull(affirmMap.get("ORG_NAME_LOCAL")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("EMP_CNT")) + "</td>");
					affirmContent.append("</tr>");
				}
			}
			resultMap.put("AFFIRM_CONTENT_OT", affirmContent.toString());
		}
	}
	
	/**
	 * 封装加班月统计信息TSTO
	 * @param map
	 * @return
	 */
	private void composeMailTemplateOtTotal(Map map,Map resultMap){
		StringBuffer affirmContent = new StringBuffer();
		//工作日 周末 区分标示
//		String weekFlag = StringUtil.checkNull(map.get("WEEKEND_FLAG"));
		if(resultMap != null){
			//要封装的信息
			List viewAffirmList = null;
//			if("WEEKEND".equals(weekFlag)){
//				viewAffirmList = infoApplyDao.viewApprovalInfo(map, "composeMailTemplateOtTotalWEEKEND");
//			}else{
				viewAffirmList = infoApplyDao.viewApprovalInfo(map, "composeMailTemplateOtTotal");
//			}
			if(viewAffirmList != null && viewAffirmList.size() > 0){
				for(int i=0;i<viewAffirmList.size();i++){
					Map affirmMap = (Map)viewAffirmList.get(i);
					affirmContent.append("<tr>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + (i + 1) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: left\">" + StringUtil.checkNull(affirmMap.get("ORG_NAME_LOCAL")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("EMP_CNT")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("OT_LENGTH")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("LENGTH_FLAG20")) + "</td>");
					affirmContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(affirmMap.get("LENGTH_FLAG30")) + "</td>");
					affirmContent.append("</tr>");
				}
			}
			resultMap.put("AFFIRM_CONTENT_OT_TOTAL", affirmContent.toString());
		}
	}
	
	/**
	 * 发送社会活动邮件
	 */
	public void sendActivityEmail(Map mapParameter){
		boolean flag = true;
		List sendAffirmEmailList = evsManageDao.viewEvsList(mapParameter, "viewAfirmEmailList"); 
		List sendPersonEmailList = evsManageDao.viewEvsList(mapParameter, "viewObjectList");
		if(sendAffirmEmailList != null && sendAffirmEmailList.size() > 0){
			for (int i = 0;i < sendAffirmEmailList.size(); i++){
				Map map = (Map)sendAffirmEmailList.get(i);
				map.put("EMAIL_TITLE", "Please evaluate "+ map.get("RESUME_NAME"));
				map.put("EMAIL_CONTENT", "There was a evaluation " + map.get("RESUME_NAME") + " Please evaluate the 1st or 2nd");
				flag = mailManger.sendmail(map);
			}
		}
		
		if(sendPersonEmailList != null && sendPersonEmailList.size() > 0){
			for (int i = 0;i < sendPersonEmailList.size(); i++){
				Map map = (Map)sendPersonEmailList.get(i);
				map.put("EMAIL_TITLE", "Please self-evaluate "+ map.get("RESUME_NAME"));
				map.put("EMAIL_CONTENT", "There was a evaluation " + map.get("RESUME_NAME") + " Please self-evaluate");
				flag = mailManger.sendmail(map);
			}
		}
	}
	
	public void sendEvsEmail(Map mapParameter){
		boolean flag = true;
		List sendAffirmEmailList = infoApplyDao.viewApprovalInfo(null, "sendEvsEmail");
		List arfirmPerson = infoApplyDao.viewApprovalInfo(mapParameter, "sendEvsEmail");
		if(sendAffirmEmailList != null && sendAffirmEmailList.size() > 0){
			for (int i = 0;i < sendAffirmEmailList.size(); i++){
				Map map = (Map)sendAffirmEmailList.get(i);
				flag = mailManger.sendmail(map);
				//更新邮件发送状态
				try {
					if(flag){
						map.put("SEND_FINISH_FLAG", 1);
					}else{
						map.put("SEND_FINISH_FLAG", 4);
					}
					infoApplyDao.viewModifyApprovalInfo(map, "updateEvsMailSendStatus");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 发送社会活动邮件
	 */
	public void sendTrainPlanEmail(Map mapParameter){
		boolean flag = true;
		String studentList = eduTrainDao.queryDesEmployee(mapParameter);
		String []students = studentList.split(",");
		for (int i = 0; i < students.length; i++) {
			mapParameter.put("studentImp", students[i]);
			String studentEmail = eduTrainDao.queryStudents(mapParameter, "queryStudents");
			Map map = (Map) eduTrainDao.planManagerInfo(mapParameter);
			map.put("EMAIL", studentEmail);
			map.put("EMAIL_TITLE", "Vv There was a training plan: "+ map.get("COURSE_NAME_CODE"));
			map.put("EMAIL_CONTENT", "There was a training plan: " + map.get("COURSE_NAME_CODE") + " Start date: "+map.get("PLAN_STARTDATE")+" End date: "+map.get("PLAN_ENDDATE")
					+ "Please register for the course ");
			flag = mailManger.sendmail(map);
		}
	}
	
	/**
	 * 工资条发送
	 */
	public void sendPayStubEmail(HttpServletRequest request, List resultList){

		//读取模板信息
		String template = MailManager.readTemplate("payStub");
		String path = request.getSession().getServletContext().getRealPath("/");
		//封装邮件信息并发送
		if(resultList != null && resultList.size() > 0){
			for (int i = 0;i < resultList.size(); i++){
				Map map = (Map)resultList.get(i);
				Map personInfo = (Map) map.get("personInfo");
				if(personInfo != null){
					String pdfPath = path+"/resources/template/payPdf/" + personInfo.get("EMPID")+"_"+personInfo.get("PAY_DATE")+".pdf";
					File file = new File(pdfPath);
					map.put("EMAIL_TITLE", "PHIẾU LƯƠNG " + personInfo.get("PAY_DATE"));
					map.put("EMAIL", personInfo.get("EMAIL"));
					map.put("ATTACH_PATH", pdfPath);
					map.put("EMAIL_CONTENT", "Tra cứu phiếu lương ở tệp đính kèm;<br/>Please check payroll in the attachment;");
					//封装模板信息
					//this.composeMailPayStubTemplate(request,template,map);
					//发送
					//mailManger.sendmail(map);
					if(file.exists()){
						mailManger.sendmailattachment(map);
					}
				}
			}
		}
	}
	
	/**
	 * 封装工资条信息
	 * @param map
	 * @return
	 */
	private void composeMailPayStubTemplate(HttpServletRequest request,String template,Map map){
		Map resultMap = new LinkedHashMap();
		
		String basePath = request.getSession().getServletContext().getRealPath("");
		String inputFile = basePath+"//resources//template//mail//payStub.htm";
		
		InputStream is = null;
		InputStreamReader isr = null;
		String result = "";
		/*读取模板*/
		int data=0;
		char[] ch =new char[1024];
		try {
			is = new FileInputStream(inputFile);
			isr = new InputStreamReader(is,"utf-8");
			result = "";
			while((data = isr.read(ch))!=-1){
	             result+=new String(ch,0,data);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//String result = MailManager.composeTemplateByParam(template, resultMap);
		
		String replaceStr = "";
		double replaceDou = 0;
		DecimalFormat decimalFormat = new DecimalFormat("#,##0");

		/*取三种项目最多的数量*/
		int maxDataCount = 0;
		int dataCount_1 = 0;
		int dataCount_2 = 0;
		int dataCount_3 = 0;

		Map personInfo = (Map) map.get("personInfo");
		result = result.replace("[PAY_DATE]", personInfo.get("PAY_DATE")==null?"":personInfo.get("PAY_DATE")+"");
		result = result.replace("[Name]", personInfo.get("LOCAL_NAME")==null?"":personInfo.get("LOCAL_NAME")+"");
		result = result.replace("[Employee No]", personInfo.get("EMPID")==null?"":personInfo.get("EMPID")+"");
		result = result.replace("[Department]", personInfo.get("DEPT_NAME")==null?"":personInfo.get("DEPT_NAME")+"");
		result = result.replace("[Employee type]", personInfo.get("EMP_TYPE_NAME")==null?"":personInfo.get("EMP_TYPE_NAME")+"");
		result = result.replace("[Post family]", personInfo.get("POST_FAMILY_NAME")==null?"":personInfo.get("POST_FAMILY_NAME")+"");
		result = result.replace("[Rank]", personInfo.get("POST_GRADE_NAME")==null?"":personInfo.get("POST_GRADE_NAME")+"");
		result = result.replace("[Position]", personInfo.get("POSITION_NAME")==null?"":personInfo.get("POSITION_NAME")+"");
		result = result.replace("[Employee office]", personInfo.get("EMP_OFFICE_NAME")==null?"":personInfo.get("EMP_OFFICE_NAME")+"");
		result = result.replace("[Actual payment]", personInfo.get("REAL_WAGES")==null?"":decimalFormat.format(personInfo.get("REAL_WAGES")));
		
		List paEmpVacInfo = (List) map.get("paEmpVacInfo");
		replaceStr = "";
		for(int j=0;j<paEmpVacInfo.size();j++){
			Map vacMap = (Map) paEmpVacInfo.get(j);
			replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+vacMap.get("TOTAL_VAC_CNT")+"</td>"
		                  + "<td style='text-align: center;' class='td_type'>"+vacMap.get("USED_VAC_CNT")+"</td>"
		                  + "<td style='text-align: center;' class='td_type'>"+vacMap.get("SHENGYU_VAC_CNT")+"</td></tr>";
		}
		result = result.replace("[Annual leave]", replaceStr);
		
		List paEmpAccount = (List) map.get("paEmpAccount");
		replaceStr = "";
		for(int j=0;j<paEmpAccount.size();j++){
			Map accMap = (Map) paEmpAccount.get(j);
			replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+accMap.get("ACCOUNT_TYPE")+"</td>"
		                  + "<td style='text-align: center;' class='td_type'>"+accMap.get("ACCOUNT_NO")+"</td></tr>";
		}
		result = result.replace("[Bank Account]", replaceStr);
		/*标准项目*/
		List payStubList = (List) map.get("payStubList");
		replaceStr = "";
		for(int j=0;j<payStubList.size();j++){
			Map paMap = (Map) payStubList.get(j);
			if("4".equals(paMap.get("ITEM_TYPE").toString())){
				replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+"</td>"
			                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
			}
		}
		result = result.replace("[Basic project]", replaceStr);
		/*基本工资+所有津贴*/
		replaceDou = 0;
		for(int j=0;j<payStubList.size();j++){
			Map paMap = (Map) payStubList.get(j);
			if("4".equals(paMap.get("ITEM_TYPE").toString())){
				replaceDou += Integer.parseInt(paMap.get("ITEM_VALUE").toString());
			}
		}
		result = result.replace("[Basic allowance]", decimalFormat.format(replaceDou));
		/*出勤明细*/
		replaceStr = "";
		for(int j=0;j<payStubList.size();j++){
			Map paMap = (Map) payStubList.get(j);
			if("1".equals(paMap.get("ITEM_TYPE").toString())){
				replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+"</td>"
			                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
				++dataCount_1;
			}
		}
		if(dataCount_1 > maxDataCount){
			maxDataCount = dataCount_1;
		}
		result = result.replace("[Attendance detail]", replaceStr);
		
		/*工资明细*/
		replaceStr = "";
		for(int j=0;j<payStubList.size();j++){
			Map paMap = (Map) payStubList.get(j);
			if("2".equals(paMap.get("ITEM_TYPE").toString())){
				replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+"</td>"
			                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
				++dataCount_2;
			}
		}
		if(dataCount_2 > maxDataCount){
			maxDataCount = dataCount_2;
		}
		result = result.replace("[Salary detail]", replaceStr);
		
		/*总工资*/
		replaceDou = 0;
		for(int j=0;j<payStubList.size();j++){
			Map paMap = (Map) payStubList.get(j);
			if("2".equals(paMap.get("ITEM_TYPE").toString())){
				replaceDou += Integer.parseInt(paMap.get("ITEM_VALUE").toString());
			}
		}
		result = result.replace("[Total Pay]", decimalFormat.format(replaceDou));
		
		/*扣除明细*/
		replaceStr = "";
		List insuranceRateList = (List) map.get("insuranceRateList");
		for(int j=0;j<payStubList.size();j++){
			Map paMap = (Map) payStubList.get(j);
			if("3".equals(paMap.get("ITEM_TYPE").toString())){
				for(int k=0;k<insuranceRateList.size();k++){
					Map inRateMap = (Map) insuranceRateList.get(k);
					if("570057".equals(paMap.get("ITEM_NO").toString())
							&& "540065".equals(inRateMap.get("PARAM_ITEM_NO").toString())){
								replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+" "+inRateMap.get("ITEM_VALUE")+"</td>"
				                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
					}
					if("570058".equals(paMap.get("ITEM_NO").toString())
							   && "540066".equals(inRateMap.get("PARAM_ITEM_NO").toString())){
								replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+" "+inRateMap.get("ITEM_VALUE")+"</td>"
				                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
					}
					if("570059".equals(paMap.get("ITEM_NO").toString())
							   && "540067".equals(inRateMap.get("PARAM_ITEM_NO").toString())){
								replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+" "+inRateMap.get("ITEM_VALUE")+"</td>"
				                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
					}
					if("570061".equals(paMap.get("ITEM_NO").toString())
							   && "540068".equals(inRateMap.get("PARAM_ITEM_NO").toString())){
								replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+" "+inRateMap.get("ITEM_VALUE")+"</td>"
				                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
					}
					if("570062".equals(paMap.get("ITEM_NO").toString())
							   && "540069".equals(inRateMap.get("PARAM_ITEM_NO").toString())){
								replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+" "+inRateMap.get("ITEM_VALUE")+"</td>"
				                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
					}
					if("570063".equals(paMap.get("ITEM_NO").toString())
							   && "540070".equals(inRateMap.get("PARAM_ITEM_NO").toString())){
								replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+" "+inRateMap.get("ITEM_VALUE")+"</td>"
				                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
					}
					if(k == insuranceRateList.size()-1
							&& !"570057".equals(paMap.get("ITEM_NO").toString())
							&& !"570058".equals(paMap.get("ITEM_NO").toString())
							&& !"570059".equals(paMap.get("ITEM_NO").toString())
							&& !"570061".equals(paMap.get("ITEM_NO").toString())
							&& !"570062".equals(paMap.get("ITEM_NO").toString())
							&& !"570063".equals(paMap.get("ITEM_NO").toString())){
						replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+paMap.get("ITEM_NAME")+"</td>"
		                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(paMap.get("ITEM_VALUE"))+"</td></tr>";
					}
					
				}
				++dataCount_3;
			}
		}
		if(dataCount_3 > maxDataCount){
			maxDataCount = dataCount_3;
		}
		result = result.replace("[Deduction detail]", replaceStr);
		
		/*总扣除*/
		replaceDou = 0;
		for(int j=0;j<payStubList.size();j++){
			Map paMap = (Map) payStubList.get(j);
			if("3".equals(paMap.get("ITEM_TYPE").toString())){
				replaceDou += Integer.parseInt(paMap.get("ITEM_VALUE").toString());
			}
		}
		result = result.replace("[Total deduct]", decimalFormat.format(replaceDou));
		
		/*其他福利*/
		List paInputItemList = (List) map.get("paInputItemList");
		replaceStr = "";
		for(int j=0;j<paInputItemList.size();j++){
			Map inputMap = (Map) paInputItemList.get(j);
			replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+inputMap.get("REMARK")+"</td>"
		                  + "<td style='text-align: right;' class='td_type'>"+decimalFormat.format(inputMap.get("RETURN_VALUE"))+"</td></tr>";
		}
		result = result.replace("[Other benefits]", replaceStr);
		
		/*设置div最大高度*/
		result = result.replace("[maxHeightData]", (maxDataCount*25+50)+"");
	    /*特殊字符设置*/
		result = result.replace("&", "&amp;");
		result = result.replace("&amp;nbsp;", "&nbsp;");
		
		map.put("EMAIL_CONTENT", result);
	}
	
	/**
	 * HAE待审批发送到eagleoffice审批箱
	 */
	public List getAffirmInfoEmailApproval(HttpServletRequest request){
		return this.getAffirmInfoEmailApproval(request, null);
	}

	/**
	 * HAE待审批发送到eagleoffice审批箱
	 * @param applyNos 只同步这些申请编号(逗号分隔)的数据；为空时同步所有待发送数据（保留原有全量同步行为）
	 */
	@SuppressWarnings("unchecked")
	public List getAffirmInfoEmailApproval(HttpServletRequest request, String applyNos){
		/*获得web service服务*/
		NeoOrgWsProxy neoOrgWsProxy = mailSendApprovalManager.getNeoOrgWsProxy();
		List applyList = new ArrayList();
		try {
			OrgUserVO[] orgUser = neoOrgWsProxy.searchUserByEmpolyeeNo("20100196");
			if (orgUser.length <= 0) {
				return applyList;
			}
			LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
			//APPLY_NO均为内部序列号(数字)，此处校验后直接拼接进IN条件，避免SQL注入
			if(StringUtil.checkNull(applyNos).matches("[0-9]+(,[0-9]+)*")){
				paramMap.put("APPLY_NOS_FILTER", applyNos);
			}

			//读取模板信息
			String basePath = request.getSession().getServletContext().getRealPath("/");
			String template = MailManager.readTemplate("approvalInfo");
			Map replaceMap = new LinkedHashMap();
			applyList= this.sendEmailDao.getWaitSendApplyInfoList(paramMap);
			
			if(applyList != null){
				for(int i=0;i<applyList.size();i++){
					StringBuffer tempContent = new StringBuffer();
					StringBuffer infoContent = new StringBuffer();
					Map applyMap = (Map) applyList.get(i);
					paramMap.put("APPLY_NO", applyMap.get("APPLY_NO"));
					List affirmList = this.sendEmailDao.getAffirmListByApplyNo(paramMap);
					if(affirmList != null){
						for(int j = 0; j<affirmList.size();j++){
							Map affirmMap = (Map) affirmList.get(j);
							try {
								OrgUserVO[] orgUsers = neoOrgWsProxy.searchUserByEmpolyeeNo((String)affirmMap.get("AFFIRM_EMPID"));
								if (orgUsers.length <= 0) {
									continue;
								}
								affirmMap.put("Userkey", orgUsers[0].getUserKey());
							} catch (WsException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} catch (RemoteException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					}
					List receiverList = this.sendEmailDao.getReceiverListByApplyNo(paramMap);
					if(receiverList != null){
						for(int j = 0; j<receiverList.size();j++){
							Map receiverMap = (Map) receiverList.get(j);
							try {
								OrgUserVO[] orgUsers = neoOrgWsProxy.searchUserByEmpolyeeNo((String)receiverMap.get("AFFIRM_EMPID"));
								if (orgUsers.length <= 0) {
									continue;
								}
								receiverMap.put("Userkey", orgUsers[0].getUserKey());
							} catch (WsException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} catch (RemoteException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					}
					if("21".equals(StringUtil.checkNull(applyMap.get("APPLY_TYPE_NO")))){
						paramMap.put("APPLY_TYPE", "LEAVE_APPLY");
					}else{
						paramMap.put("APPLY_TYPE", "");
					}
					
					List fileList = this.infoApplyLeaveDao.getEssFileList(paramMap);
					if(fileList!=null){
						for(int j=0;j<fileList.size();j++){
							Map fileMap = (Map) fileList.get(j);
							fileMap.put("FILE_URL", basePath + fileMap.get("FILE_URL"));
						}
					}
					
					infoContent.append("<tr>");
					infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("LOCAL_NAME")) + "</td>");
					infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("EMPID")) + "</td>");
					infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("DEPT_NAME")) + "</td>");
					infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("POSITION_NAME")) + "</td>");
					infoContent.append("</tr>");
					tempContent.append("<tr>");
					if ("310".equals(StringUtil.checkNull(applyMap.get("APPLY_TYPE_NO")))) {
						tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" +" (OT Over) " + StringUtil.checkNull(applyMap.get("APPLY_TYPE_NAME_KO"))
						 +" / "+ StringUtil.checkNull(applyMap.get("APPLY_TYPE_NAME_VI")) +"</td>");
					}else {
						tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("APPLY_TYPE_NAME_KO"))
						 +" / "+ StringUtil.checkNull(applyMap.get("APPLY_TYPE_NAME_VI")) +"</td>");
					}
					tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("FROM_TIME")) + "</td>");
					tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("TO_TIME")) + "</td>");
					if("21".equals(StringUtil.checkNull(applyMap.get("APPLY_TYPE_NO")))){
						tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("ATT_LENGTH")) + "</td>");
					}else {
						tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("OT_LENGTH")) + "(Total overtime in month: "+StringUtil.checkNull(applyMap.get("OT_TOTAIL_MONTH"))+")"+ "</td>");
					}
					tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("REMARK")) + "</td>");
					tempContent.append("</tr>");
					replaceMap.put("APPLY_PERSON_INFO", infoContent);
					replaceMap.put("APPAL_ATT_INFO", tempContent);
					applyMap.put("content", MailManager.composeTemplateByParam(template, replaceMap));
					applyMap.put("TITLE", applyMap.get("APPLY_TYPE_NAME").toString()
										  +" Application("+applyMap.get("LOCAL_NAME").toString()+")[Date: "
										  +applyMap.get("APPLY_TIME").toString()+"]");
					applyMap.put("fileList", fileList);
					applyMap.put("affirmList", affirmList);
					applyMap.put("receiverList", receiverList);
				}
			}
		} catch (WsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return applyList;
		
	}
	
	/**
	 * 获取需要在eagleoffice里面取消申请的信息
	 * @param request
	 * @return List
	 */
	public List getNeedCancelApprovalInfo(HttpServletRequest request,String type){
		
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		String[] paramData = request.getParameterValues(type);
		String applyNos = "";
		for (int i = 0; i < paramData.length; i++) {
			if(applyNos.length() == 0){
				applyNos += paramData[i];
			}else{
				applyNos += "," + paramData[i];
			}
		}
		if(paramData.length > 1){
			applyNos = applyNos.substring(0, applyNos.length() - 1);
		}
		paramMap.put("APPLY_NOS", applyNos);
		
		List resultList = this.sendEmailDao.getNeedCancelApprovalInfo(paramMap);
		
		return resultList;
	}
	
	/**
	 * 同步eagleoffice中审批信息的状态（HAE）
	 * @param request
	 * @return List
	 */
	public void synchronizationApprovalStatus(){
		/*获得web service服务*/
		NeoOrgWsProxy neoOrgWsProxy = mailSendApprovalManager.getNeoOrgWsProxy();
		
		List approvalList = this.sendEmailDao.getSynchronizationApprovalList();
		
		Map paramMap = new LinkedHashMap();
		MisKey misKey;
		MisKey[] misKeys = new MisKey[approvalList==null?0:approvalList.size()];
		
		if(approvalList!=null){
			for(int i = 0;i<approvalList.size();i++){
				Map approvalMap = (Map) approvalList.get(i);
				misKey = new MisKey();
				misKey.setMisDocId("HAEVHR_001_"+StringUtil.checkNull(approvalMap.get("MISDOCID")));
				misKeys[i] = misKey;
			}
		
			ApprovalDocumentStatus[] appDocStus = this.mailSendApprovalManager.getMailApprovalInfo(misKeys);
			
			for(int i=0;i<appDocStus.length;i++){
				for(int j = 0;j<approvalList.size();j++){
					Map approvalMap = (Map) approvalList.get(i);
					if(("HAEVHR_001_"+StringUtil.checkNull(approvalMap.get("MISDOCID"))).equals(appDocStus[i].getMisDocId())){
						if(!"4".equals(StringUtil.checkNull(appDocStus[i].getStatus()))){
							SignerInfo[] signerInfos = appDocStus[i].getSignerInfos();
							
							paramMap.put("APPLY_NO", StringUtil.checkNull(approvalMap.get("APPLY_NO")));
							List affirmList = this.sendEmailDao.getAffirmListByApplyNo(paramMap);
							if(affirmList != null){
								for(int k=0;k<affirmList.size();k++){
									Map affirmMap = (Map) affirmList.get(k);
									for(int a=0;a<signerInfos.length;a++){
										if ("0".equals(StringUtil.checkNull(affirmMap.get("AFFIRM_FLAG"))) && "2".equals(StringUtil.checkNull(affirmMap.get("AFFIRM_LEVEL")))
												&& "1".equals(StringUtil.checkNull(approvalMap.get("TIME_FLAG")))) {
											this.sendAttendanceEmail(approvalMap);
											String updateAttendace = this.sendEmailDao.updateAttendace(approvalMap);
										}
										if(signerInfos[a].getStatus() != 0 
												&& "0".equals(StringUtil.checkNull(affirmMap.get("AFFIRM_FLAG")))
												&& (StringUtil.checkNull(affirmMap.get("EMAIL")).equals(StringUtil.checkNull(signerInfos[a].getEmailAddr()))
													|| StringUtil.checkNull(affirmMap.get("AFFIRM_LEVEL")).equals(StringUtil.checkNull(signerInfos[a].getSequence()))) //hms 2019/10ROW_LEVEL
												&& "1".equals(StringUtil.checkNull(affirmMap.get("AFFIRM_TYPE")))){
											
											paramMap.put("APPLY_TYPE", StringUtil.checkNull(affirmMap.get("APPLY_TYPE")));
											paramMap.put("APPLY_FLAG", StringUtil.checkNull(affirmMap.get("APPLY_FLAG")));
											paramMap.put("AFFIRM_FLAG", StringUtil.checkNull(signerInfos[a].getStatus()));
											paramMap.put("AFFIRM_CONTENT", StringUtil.checkNull(signerInfos[a].getComment()));
											paramMap.put("adminID", "");
											paramMap.put("adminIP", StringUtil.checkNull("hanwha.eagleoffice"));
											paramMap.put("AFFIRM_LEVEL", StringUtil.checkNull(affirmMap.get("AFFIRM_LEVEL")));
											try {
												this.infoApplyDao.executePro(paramMap,"PR_AFFIRM_EXECUTE");
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
										}
									}
								}
							}
							
							
						}
					}
				}
			}
		
		}
	}
	
	/**
	 * 获取需要在eagleoffice里面取消申请的信息(hr system审批结束的信息)
	 * @param request 
	 * @param String
	 * @return List
	 */
	public List getNeedCancelApprovaledInfo(HttpServletRequest request,String type){
		
		List resultList;
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request, "seach_");
		String jsonString;
		List<LinkedHashMap<String, Object>> dataList = new ArrayList();
		if(!"only".equals(type)){
			jsonString = request.getParameter("jsonData") ;
			dataList = ObjectBindUtil.getRequestJsonData(jsonString) ;
		}
		if("only".equals(type)){
			paramMap.put("APPLY_NOS", paramMap.get("APPLY_NO"));
		}else if("single".equals(type)){
			String applyNos = "";
			for(int i = 0;i<dataList.size();i++){
				Map tempMap = (Map)dataList.get(i);
				if(applyNos.length() == 0){
					applyNos += tempMap.get("APPLY_NO");
				}else{
					applyNos += "," + tempMap.get("APPLY_NO");
				}
			}
			if(applyNos.indexOf(",") != -1){
				applyNos = applyNos.substring(0, applyNos.length() - 1);
			}
			paramMap.put("APPLY_NOS", applyNos);
		}else{
			String batchNos = "";
			for(int i = 0;i<dataList.size();i++){
				Map tempMap = (Map)dataList.get(i);
				if(batchNos.length() == 0){
					batchNos += tempMap.get("BATCH_NO");
				}else{
					batchNos += "," + tempMap.get("BATCH_NO");
				}
			}
			if(batchNos.indexOf(",") != -1){
				batchNos = batchNos.substring(0, batchNos.length() - 1);
			}
			paramMap.put("BATCH_NOS", batchNos);
		}
		resultList = this.sendEmailDao.getNeedCancelApprovaledInfo(paramMap,type);
		
		return resultList;
	}
	
	public void sendAttendanceEmail(Map mapParameter){
		boolean flag = true;

			//String studentEmail = eduTrainDao.queryStudents(mapParameter, "queryStudents");
			Map map = new LinkedHashMap();//(Map) eduTrainDao.planManagerInfo(mapParameter);
			//map.put("EMAIL", "ait.vn@hanwha.com");
			map.put("EMAIL", "hae.security@hanwha.com");
			
			//map.put("EMAIL_TITLE", "Approve Info【YHR】Date：");
			map.put("EMAIL_TITLE", "Thông báo xin nghỉ phép");
			//封装模板信息
			String template = MailManager.readTemplate("approvalInfo");
			Map replaceMap = new LinkedHashMap();
			mapParameter.put("APPLY_NO", mapParameter.get("APPLY_NO"));
			List applyList= this.sendEmailDao.getSendDataInfoList(mapParameter, "getApplyLeaveData");
			for(int i=0;i<applyList.size();i++){
				StringBuffer tempContent = new StringBuffer();
				StringBuffer infoContent = new StringBuffer();
				Map applyMap = (Map) applyList.get(i);
			infoContent.append("<tr>");
			infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("LOCAL_NAME")) + "</td>");
			infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("EMPID")) + "</td>");
			infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("DEPT_NAME")) + "</td>");
			infoContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("POSITION_NAME")) + "</td>");
			infoContent.append("</tr>");
			tempContent.append("<tr>");
			tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("APPLY_TYPE_NAME_KO"))
																					 +" / "+ StringUtil.checkNull(applyMap.get("APPLY_TYPE_NAME_VI")) +"</td>");
			tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("FROM_TIME")) + "</td>");
			tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("TO_TIME")) + "</td>");
			tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("APPLY_LENGTH")) + "</td>");
			tempContent.append("<td class=\"td_type\" style=\"text-align: center\">" + StringUtil.checkNull(applyMap.get("REMARK")) + "</td>");
			tempContent.append("</tr>");
			replaceMap.put("APPLY_PERSON_INFO", infoContent);
			replaceMap.put("APPAL_ATT_INFO", tempContent);
			map.put("EMAIL_CONTENT", MailManager.composeTemplateByParam(template, replaceMap));

			flag = mailManger.sendmail(map);
			}

	}
}
