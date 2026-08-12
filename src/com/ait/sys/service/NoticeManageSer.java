package com.ait.sys.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface NoticeManageSer {

	public List getNoticeInfo(HttpServletRequest request)throws Exception;
	
	public List getNoticeInfo1(HttpServletRequest request)throws Exception;
	
	public int getNoticeInfoCn(HttpServletRequest request) throws Exception;
	
	public int getNoticeInfoCn1(HttpServletRequest request) throws Exception;
	
	public Map getNoticeInfoById(HttpServletRequest request)throws Exception;
	
	public int insertNoticeInfo(HttpServletRequest request)throws Exception;
	
	public int updateNoticeInfo(HttpServletRequest request)throws Exception;
	
	public int delNoticeInfo(HttpServletRequest request)throws Exception;
	
	public String printClob(Object clob) throws Exception;
	
	public int delOverNoticeInfo(HttpServletRequest request) throws Exception;
	
	//上传附件
	public int uploadAtt(HttpServletRequest request) throws Exception ;
	
	public int uploadAttPhoto(HttpServletRequest request) throws Exception ;
	
	//Send SMS
		@SuppressWarnings("unchecked")
		public List getSendSMSList(HttpServletRequest request) ;
		
		public int getSendSMSCnt(HttpServletRequest request) ;
		
		public int addSendSMSInfo(HttpServletRequest request) ;
		
	public int addRecordInfo(HttpServletRequest request, String target) ;
	
	@SuppressWarnings("unchecked")
	public List viewRecordList(Object object, String target);

	public List getFeedbackList(HttpServletRequest request) throws Exception;

	public int getFeedbackListCn(HttpServletRequest request) throws Exception;

	public Map getFeedbackById(HttpServletRequest request) throws Exception;
}
