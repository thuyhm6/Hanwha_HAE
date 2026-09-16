package com.ait.sys.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface NoticeManageDAO {

	public List getNoticeInfo(Object parameterObject)throws Exception;
	
	public List getNoticeInfo1(Object parameterObject)throws Exception;
	
	public List getNoticeInfo(Object parameterObject,int pageNum,int pageSize) throws Exception;
	
	public List getNoticeInfo1(Object parameterObject,int pageNum,int pageSize) throws Exception;
	
	public int getNoticeInfoCn(Object parameterObject) throws Exception;
	
	public int getNoticeInfoCn1(Object parameterObject) throws Exception;
	
	public Map getNoticeInfoById(Object parameterObject)throws Exception;
	
	public int insertNoticeInfo(Object parameterObject);
	
	public int updateNoticeInfo(Object parameterObject);
	
	public int delNoticeInfo(List list);
	
	public int delOverNoticeInfo(Object parameterObject);
	
	public int uploadAtt(Object parameterObject);
	
	public int uploadAttPhoto(Object parameterObject);
	
	//Send SMS
	@SuppressWarnings("unchecked")
	public List getSendSMSList(Object object);
	
	public int getSendSMSCnt(Object object);
	
	public int addSendSMSInfo(Object object) throws Exception;
	
	public int addRecordInfo(Object object, String target) throws Exception;
	
	@SuppressWarnings("unchecked")
	public List viewRecordList(Object object, String target);

	public List getFeedbackList(Object parameterObject) throws Exception;

	public List getFeedbackList(Object parameterObject, int pageNum, int pageSize) throws Exception;

	public int getFeedbackListCn(Object parameterObject) throws Exception;

	public Map getFeedbackById(Object parameterObject) throws Exception;

	public List getPersonalDataConfirmList(Object parameterObject) throws Exception;

	public List getPersonalDataConfirmList(Object parameterObject, int pageNum, int pageSize) throws Exception;

	public int getPersonalDataConfirmListCn(Object parameterObject) throws Exception;

	public Map getPersonalDataConfirmDetail(Object parameterObject) throws Exception;

}
