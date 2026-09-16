package com.ait.sys.action;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.portlet.ModelAndView;

import com.ait.ess.dao.InfoApplyLeaveDao;
import com.ait.ess.service.InfoApplySer;
import com.ait.hrm.service.EmpInfoSer;
import com.ait.sys.bean.AdminBean;
import com.ait.sys.service.NoticeManageSer;
import com.ait.sys.service.ToolMenuSer;
import com.ait.web.i18n.TipMessage;
import com.ait.web.util.AuthorityUtil;
import com.ait.web.util.JsonUtil;
import com.ait.web.util.ObjectBindUtil;
import com.ait.web.util.SessionUtil;
import com.ait.web.util.StringUtil;
import com.ait.web.util.UiUtil;
/**
 * Copyright: AIT Company: AIT
 * 
 * @fileName: NoticeManageCtroller.java
 * @Description: 公告管理-公告信息
 * @Create date: 2014-3-6 下午01:55:16
 * @Create by: limeng(liemng@ait.net.cn)
 * @version 5.5
 */
@Controller
@RequestMapping(value="/sys/notice")
public class NoticeManageCtroller {
	
	@Autowired
	private NoticeManageSer noticeSer;
	
	@Autowired 
	private ToolMenuSer toolMenuSer;
	
	@Autowired
	private EmpInfoSer empInfoSer;
	@Autowired
	private AuthorityUtil authorityUtil;
	@Autowired
	InfoApplySer infoApplySer;
	@Autowired
	private InfoApplyLeaveDao infoApplyLeaveDao;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/viewNoticeInfo")
	public ModelAndView viewNoticeInfoList(HttpServletRequest request,HttpServletResponse response,
				ModelMap modelMap) throws Exception{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put(UiUtil.PAGE_NUM_NAME, request.getParameter("menuNo"));
		if(request.getParameter("menuNo") != null && request.getParameter("menuNo").equals("2505")){
			List noticeList = noticeSer.getNoticeInfo(request);
			if(noticeList.size()>0){
				for (Iterator iterator = noticeList.iterator(); iterator.hasNext();) {
					Map noticeInfo = (LinkedHashMap)iterator.next();
					noticeInfo.put("CONTENT", noticeSer.printClob(noticeInfo.get("CONTENT")));
				}
			}
			modelMap.put("nList", noticeList);
			modelMap.put(UiUtil.TOTAL_COUNT_NAME,noticeSer.getNoticeInfoCn(request));
		}else{
			List noticeList = noticeSer.getNoticeInfo1(request);
			if(noticeList.size()>0){
				for (Iterator iterator = noticeList.iterator(); iterator.hasNext();) {
					Map noticeInfo = (LinkedHashMap)iterator.next();
					noticeInfo.put("CONTENT", noticeSer.printClob(noticeInfo.get("CONTENT")));
				}
			}
			modelMap.put("nList", noticeList);
			modelMap.put(UiUtil.TOTAL_COUNT_NAME,noticeSer.getNoticeInfoCn1(request));
		}
		
		//将Clob转成String
		
		modelMap.put(UiUtil.PAGE_NUM_NAME, request.getParameter("pageNum")!=null?request.
				getParameter("pageNum"):"1");
		modelMap.put(UiUtil.NUM_PER_PAGE_NAME, request.getParameter("numPerPage")!=null?request.
			getParameter("numPerPage"):"10");
		modelMap.put("authority", authorityUtil.isSuperUser(admin.getPersonId()));
		modelMap.put("defaultCpnyId", admin.getCpnyId());
		modelMap.put("toolbarInfo",
				request.getParameter("menuNo") != null ? toolMenuSer.getToolMenu(request) : toolMenuSer.getToolMenuForNo(request, "124977"));
		return new ModelAndView("/sys/notice/viewNoticeInfo",modelMap);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/addNoticeInfoView")
	public ModelAndView addNoticeInfoView(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		//判断是否有超级管理员权限
		modelMap.put("authority", authorityUtil.isSuperUser(admin.getPersonId()));
		modelMap.put("defaultCpnyId", admin.getCpnyId());
		modelMap.put("companyList", empInfoSer.getCompanyList(request));
		return new ModelAndView("/sys/notice/addNoticeInfoView",modelMap);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addNoticeInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map addNoticeInfo(HttpServletRequest request) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		int result = this.noticeSer.insertNoticeInfo(request);
		if(result==1){
			map.put("statusCode", "200");
			map.put("message", TipMessage.getTipMessage(
					"alert.message.add_success", request));// 添加成功
			map.put("navTabId", "gg0101");
		}else{
			map.put("statusCode", "300");
			map.put("message", TipMessage.getTipMessage(
					"alert.message.add_fail", request));// 保存失败
		}
		return map;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateNoticeInfoView")
	public ModelAndView updateNoticeInfoView(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map item = noticeSer.getNoticeInfoById(request);
		String id = StringUtil.checkNull(request.getParameter("ID"));
		if (!"0".equals(id) && !"".equals(id)) {
			// 附件下载功能
			LinkedHashMap fileParam = new LinkedHashMap();
			fileParam.put("APPLY_TYPE", "notice");
			fileParam.put("APPLY_NO", id);
			List fileList = infoApplyLeaveDao.getEssFileList(fileParam);
			item.put("fileList", fileList);
		}
		modelMap.put("item", item);
		modelMap.put("UPDATED_BY", item.get("CREATED_BY"));
		//判断是否有超级管理员权限
		int authority = authorityUtil.isSuperUser(admin.getPersonId());
		if(authority == 1){
			String[] cpnyIds = item.get("CPNY_ID").toString().split(",");
			List companyList = empInfoSer.getCompanyList(request);
			if(cpnyIds != null && cpnyIds.length > 0){
				for(int i=0;i<cpnyIds.length;i++){
					for(int j=0;j<companyList.size();j++){
						LinkedHashMap companyMap = (LinkedHashMap)companyList.get(j);
						if(cpnyIds[i].equals(companyMap.get("CPNY_ID").toString())){
							companyMap.put("SELECTED", 1);
							break;
						}
					}
				}
			}
			modelMap.put("companyList", companyList);
		}
		modelMap.put("defaultCpnyId", admin.getCpnyId());
		//判断是否有超级管理员权限
		modelMap.put("authority", authority);
		return new ModelAndView("/sys/notice/updateNoticeInfoView", modelMap);
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateNoticeInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map updateNoticeInfo(HttpServletRequest request)throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		int result =this.noticeSer.updateNoticeInfo(request);
		if(result==1){
			map.put("statusCode", "200");
			map.put("message", TipMessage.getTipMessage("alert.message.update_success", request));// 修改成功
			map.put("navTabId", "gg0101");
			
		}else{
			map.put("statusCode", "300");
			map.put("message", TipMessage.getTipMessage("alert.message.update_fail", request));// 修改失败
		}
		return map;
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/delNoticeInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delNoticeInfo(HttpServletRequest request) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		int result = this.noticeSer.delNoticeInfo(request);
		if(result==1){
			map.put("statusCode", "200");
			map.put("message", TipMessage.getTipMessage("alert.message.delete_success", request));// 删除成功
			map.put("navTabId", "gg0101");
		}else{
			map.put("statusCode", "300");
			map.put("message", TipMessage.getTipMessage("alert.message.delete_fail", request));// 删除失败
		}
		return map;
	}
	
	/**
	 * 获取公告
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/viewNotice")
	public ModelAndView viewNotice(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		Map item = noticeSer.getNoticeInfoById(request);
		String id = StringUtil.checkNull(request.getParameter("ID"));
		if (!"0".equals(id) && !"".equals(id)) {
			// 附件下载功能
			LinkedHashMap fileParam = new LinkedHashMap();
			fileParam.put("APPLY_TYPE", "notice");
			fileParam.put("APPLY_NO", id);
			List fileList = infoApplyLeaveDao.getEssFileList(fileParam);
			item.put("fileList", fileList);
		}
		modelMap.put("notice", item);
		return new ModelAndView("/sys/notice/viewNotice", modelMap);
	}
	

	/**
	 * 跳转到附件上传页
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/uploadWindow")
	public ModelAndView uploadWindow(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		String val =  StringUtil.checkNull(request.getParameter("val"));
		val = val.replace("$", "&");
		modelMap.put("id", request.getParameter("id"));
		modelMap.put("val", val);
		modelMap.put("seq", request.getParameter("seq"));
		modelMap.put("applyType", request.getParameter("applyType"));
		return new ModelAndView("/sys/notice/uploadWindow", modelMap);
	}

	/**
	 * 跳转到附件上传页(新增)
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/uploadWindowInsert")
	public ModelAndView uploadWindowInsert(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		String val =  StringUtil.checkNull(request.getParameter("val"));
		val = val.replace("$", "&");
		modelMap.put("id", request.getParameter("id"));
		modelMap.put("val", val);
		modelMap.put("seq", request.getParameter("seq"));
		modelMap.put("applyType", request.getParameter("applyType"));
		return new ModelAndView("/sys/notice/uploadWindowInsert", modelMap);
	}
	
	/**
	 * 照片上传
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/uploadWindowPhoto")
	public ModelAndView uploadWindowPhoto(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		String val =  StringUtil.checkNull(request.getParameter("val"));
		val = val.replace("$", "&");
		modelMap.put("id", request.getParameter("id"));
		modelMap.put("val", val);
		modelMap.put("seq", request.getParameter("seq"));
		modelMap.put("applyType", request.getParameter("applyType"));
		return new ModelAndView("/sys/notice/uploadWindowPhoto", modelMap);
	}
	
	
	@RequestMapping(value = "/uploadAtt", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadAtt(HttpServletRequest request) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		int result = this.noticeSer.uploadAtt(request);
		if(result==1){
			map.put("statusCode", "200");
			map.put("message", TipMessage.getTipMessage("alert.message.save_success", request));// "保存成功"
		}else{
			map.put("statusCode", "300");
			map.put("message", TipMessage.getTipMessage("alert.message.add_success", request));// "保存失败"
		}
		return map;
	}
	
	@RequestMapping(value = "/uploadAttPhoto", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadAttPhoto(HttpServletRequest request) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		int result = this.noticeSer.uploadAttPhoto(request);
		if(result==1){
			map.put("statusCode", "200");
			map.put("message", TipMessage.getTipMessage("alert.message.save_success", request));// "保存成功"
		}else{
			map.put("statusCode", "300");
			map.put("message", TipMessage.getTipMessage("alert.message.add_success", request));// "保存失败"
		}
		return map;
	}
	
	/**
	 * 跳转到附件上传页
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addAffirmWindow")
	public ModelAndView addAffirmWindow(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("PERSON_ID", request.getParameter("PERSON_ID"));
		modelMap.put("APPLY_TYPE", request.getParameter("APPLY_TYPE"));
		modelMap.put("divId", request.getParameter("divId"));
		modelMap.put("affirmIdStr", request.getParameter("affirmIdStr"));
		modelMap.put("affirmorList", this.infoApplySer.getAffirmorListByString(StringUtil.checkNull(request.getParameter("APPLY_TYPE")),StringUtil.checkNull(request.getParameter("PERSON_ID")), null, null, StringUtil.checkNull(request.getParameter("LANGUAGE"))));
		return new ModelAndView("/sys/notice/addAffirmWindow", modelMap);
	}
	
	//Send SMS
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/viewSendSMS")
		public ModelAndView viewSendSMS(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			List sendSMSList = this.noticeSer.getSendSMSList(request);
			int sendSMSCnt = this.noticeSer.getSendSMSCnt(request);
			modelMap.put("sendSMSList", sendSMSList);
			modelMap.put(UiUtil.TOTAL_COUNT_NAME, sendSMSCnt);
			modelMap.put("START_DATE",request.getParameter("START_DATE"));
			modelMap.put("END_DATE",request.getParameter("END_DATE"));
			return new ModelAndView("/sys/notice/viewSendSMS", modelMap);
		}
		
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/addSendSMS")
		public ModelAndView addSendSMS(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			return new ModelAndView("/sys/notice/addSendSMS",
					modelMap);
		}
		
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/addSendSMSInfo")
		@ResponseBody
		public Map addSendSMSInfo(HttpServletRequest request) throws Exception {
			Map<String, Object> map = new HashMap<String, Object>();
			int result = noticeSer.addSendSMSInfo(request);
			if (result == 1) {
				map.put("statusCode", "200");
				map.put("message", TipMessage.getTipMessage("alert.message.add_success", request));
				map.put("navTabId", "gg0102");
				map.put("callbackType", "closeCurrent");
			} else {
				map.put("statusCode", "300");
				map.put("message", TipMessage.getTipMessage("alert.message.add_fail", request));
			}
			return map;
		}
		
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/viewPDFFile")
		public ModelAndView viewPDFFile(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			String fileURl = StringUtil.checkNull(request.getParameter("fileName"));
			String fileName = StringUtil.checkNull(request.getParameter("file"));
			modelMap.put("fileURl", fileURl);
			modelMap.put("fileName", fileName);
			return new ModelAndView("/sys/notice/viewPDFFile", modelMap);
		}
		
		@RequestMapping(value = "/addFaqFile")
		public ModelAndView addFaqFile(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap)
						throws Exception {
			modelMap.put("SEQ", request.getParameter("SEQ"));
			modelMap.put("LANGUAGE", request.getParameter("LANGUAGE"));
			return new ModelAndView("/sys/notice/addFaqFile");
		}
		
		@RequestMapping(value = "/uploadNoticeInfo")
		public void uploadNoticeInfo(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			
			AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			MultipartHttpServletRequest multipartRequest = null;
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
			if (!(request instanceof MultipartHttpServletRequest) && multipartResolver.isMultipart(request)) {
				try {
					multipartResolver.setMaxUploadSize(20971520);
					multipartRequest = multipartResolver.resolveMultipart(request);
				} catch(MaxUploadSizeExceededException e) {
				}
			} else if (request instanceof MultipartHttpServletRequest){
				multipartRequest = (MultipartHttpServletRequest)request;
			} else {
			}
			String uuid = String.valueOf(UUID.randomUUID());
			/**构建图片保存的目录**/    
			String logoPathDir = "/resources/temp/apply/applyleave/"+admin.getPersonId();// dateformat.format(new Date());
			/**得到图片保存目录的真实路径**/    
			String logoRealPathDir = request.getSession().getServletContext().getRealPath(logoPathDir); 
			/**根据真实路径创建目录**/    
			File logoSaveFile = new File(logoRealPathDir);     
			if(!logoSaveFile.exists()){
				logoSaveFile.mkdirs();
			}
			/**页面控件的文件流**/
			MultipartFile multipartFile = multipartRequest.getFile("file");
			/**获取文件的后缀**/
			String suffix = multipartFile.getOriginalFilename().substring
					(multipartFile.getOriginalFilename().lastIndexOf("."));
			// 构建文件名称
			/**拼成完整的文件保存路径加文件**/
			String fileName = logoRealPathDir + File.separator   + uuid + suffix;
			File file = new File(fileName);
			try {
				multipartFile.transferTo(file);
				//上传成功，保存记录
				map.put("FILE_NAME", multipartFile.getOriginalFilename());
				map.put("FILE_URL",  uuid + suffix);
				map.put("name", "FILE_URL");
				map.put("pk", request.getParameter("SEQ"));
				//int result = this.evsManageSer.addEvsInfo(map,"updateNoticeInfo");
				//this.empInfoSer.changePhoto(request, logoPathDir + "/"   + PERSON_ID + suffix);
				map.put("statusCode", "200");
				map.put("message", TipMessage.getTipMessage("alert.message.save_success", request));// "保存成功"
				map.put("photoPath", logoPathDir + "/"   + uuid + suffix);
				map.put("photoName", multipartFile.getOriginalFilename());
				System.out.println("附件上传成功:" + multipartFile.getOriginalFilename());
			} catch (IllegalStateException e) {
				e.printStackTrace();
				map.put("statusCode", "300");
				map.put("message", TipMessage.getTipMessage("alert.message.add_success", request));// "保存失败"
			} catch (IOException e) {
				e.printStackTrace();
				map.put("statusCode", "300");
				map.put("message", TipMessage.getTipMessage("alert.message.add_success", request));// "保存失败"
			}
			response.getWriter().write( JsonUtil.writeInternal(map));
		}
		
		//Mỗi lần xem video thì +1
		@RequestMapping(value = "/addViewVideoCount")
		public void addViewVideoCount(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
			AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
			int result = noticeSer.addRecordInfo(request,"addViewVideoCount");
			
		}
		
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/viewVideoList")
		public ModelAndView viewVideoList(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

			Map paramMap = ObjectBindUtil.getRequestParamData(request);
			AdminBean admin = SessionUtil.getLoginUserFromSession(request);
			paramMap.put("DEPTNO", admin.getDeptNo());
			paramMap.put("language", paramMap.get("interLanguage"));
			List getVideoList = noticeSer.viewRecordList(paramMap,"viewVideoList");
			int getVideoListCnt = getVideoList.size();
			modelMap.put("getVideoList", getVideoList);
			modelMap.put("getVideoListCnt",getVideoListCnt);
			return new ModelAndView("/sys/notice/viewVideoList", modelMap);
		}

		/**
		 * Trung tâm Góp ý/ Khiếu nại
		 * @param request
		 * @param response
		 * @param modelMap
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/viewFeedbackComplaints")
		public ModelAndView viewFeedbackComplaints(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			return new ModelAndView("/sys/notice/viewFeedbackComplaints", modelMap);
		}

		@RequestMapping(value = "/addFeedback", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> addFeedback(HttpServletRequest request) throws Exception {
			Map<String, Object> map = new HashMap<String, Object>();
			int result = noticeSer.addRecordInfo(request, "insertFeedback");
			if (result == 1) {
				map.put("statusCode", "200");
				map.put("message", TipMessage.getTipMessage("alert.message.sys.notice.feedback.send_success", request));
			} else {
				map.put("statusCode", "300");
				map.put("message", TipMessage.getTipMessage("alert.message.sys.notice.feedback.send_fail", request));
			}
			return map;
		}

		/**
		 * Danh sách Góp ý/ Khiếu nại
		 * @param request
		 * @param response
		 * @param modelMap
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/viewFeedbackComplaintsList")
		public ModelAndView viewFeedbackComplaintsList(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			List feedbackList = noticeSer.getFeedbackList(request);
			modelMap.put("fList", feedbackList);
			modelMap.put(UiUtil.TOTAL_COUNT_NAME, noticeSer.getFeedbackListCn(request));
			modelMap.put(UiUtil.PAGE_NUM_NAME, request.getParameter("pageNum") != null ? request.getParameter("pageNum") : "1");
			modelMap.put(UiUtil.NUM_PER_PAGE_NAME, request.getParameter("numPerPage") != null ? request.getParameter("numPerPage") : "10");
			modelMap.put("TITLE", request.getParameter("seach_TITLE"));
			modelMap.put("FEEDBACK_TYPE", request.getParameter("seach_FEEDBACK_TYPE"));
			modelMap.put("FROM_DATE", request.getParameter("seach_FROM_DATE"));
			modelMap.put("TO_DATE", request.getParameter("seach_TO_DATE"));
			return new ModelAndView("/sys/notice/viewFeedbackComplaintsList", modelMap);
		}

		/**
		 * Chi tiết Góp ý/ Khiếu nại
		 * @param request
		 * @param response
		 * @param modelMap
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/viewFeedbackDetail")
		public ModelAndView viewFeedbackDetail(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			Map item = noticeSer.getFeedbackById(request);
			modelMap.put("item", item);
			return new ModelAndView("/sys/notice/viewFeedbackDetail", modelMap);
		}

		/**
		 * Danh sách xác nhận đồng ý xử lý dữ liệu cá nhân
		 * @param request
		 * @param response
		 * @param modelMap
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/viewPersonalDataConfirmList")
		public ModelAndView viewPersonalDataConfirmList(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			List confirmList = noticeSer.getPersonalDataConfirmList(request);
			modelMap.put("pList", confirmList);
			modelMap.put(UiUtil.TOTAL_COUNT_NAME, noticeSer.getPersonalDataConfirmListCn(request));
			modelMap.put(UiUtil.PAGE_NUM_NAME, request.getParameter("pageNum") != null ? request.getParameter("pageNum") : "1");
			modelMap.put(UiUtil.NUM_PER_PAGE_NAME, request.getParameter("numPerPage") != null ? request.getParameter("numPerPage") : "10");
			modelMap.put("KEY", request.getParameter("seach_KEY"));
			modelMap.put("FROM_DATE", request.getParameter("seach_FROM_DATE"));
			modelMap.put("TO_DATE", request.getParameter("seach_TO_DATE"));
			return new ModelAndView("/sys/notice/viewPersonalDataConfirmList", modelMap);
		}

		/**
		 * Chi tiết xác nhận đồng ý xử lý dữ liệu cá nhân
		 * @param request
		 * @param response
		 * @param modelMap
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/viewPersonalDataConfirmDetail")
		public ModelAndView viewPersonalDataConfirmDetail(HttpServletRequest request,
				HttpServletResponse response, ModelMap modelMap) throws Exception {
			Map item = noticeSer.getPersonalDataConfirmDetail(request);
			modelMap.put("item", item);
			return new ModelAndView("/sys/notice/viewPersonalDataConfirmDetail", modelMap);
		}
}
