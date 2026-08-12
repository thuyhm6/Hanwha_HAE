package com.ait.sys.dao;

import java.util.List;
/**
 * 
 * Copyright:   AIT (c)
 * Company:     AIT
 * @fileName SendEmailDao.java
 * @author lipeng(lipeng@ait.net.cn)
 * @Date 2018-6-25 上午11:26:28
 * @version 1.0
 *
 */
public interface SendEmailDao {
	
	@SuppressWarnings("unchecked")
	public List getWaitSendApplyInfoList(Object object);
	
	@SuppressWarnings("unchecked")
	public List getAffirmListByApplyNo(Object object);
	
	@SuppressWarnings("unchecked")
	public List getReceiverListByApplyNo(Object object);
	
	@SuppressWarnings("unchecked")
	public List getNeedCancelApprovalInfo(Object object);
	
	@SuppressWarnings("unchecked")
	public List getSynchronizationApprovalList();
	
	public String updateApplySendFlag(Object object);
	
	@SuppressWarnings("unchecked")
	public List getNeedCancelApprovaledInfo(Object object,String type);
	//HMT_20231204 email to Secury
	@SuppressWarnings("unchecked")
	public List getSendDataInfoList(Object object, String target);
	public String updateAttendace(Object object);
	
}
