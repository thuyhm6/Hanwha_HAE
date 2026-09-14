package com.ait.sys.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 发送审批邮件
 *
 */
public interface SendEmailSer {
	
	public void sendAffirmEmail();

	public void sendAffirmEmailHAE(int affirmLevel); //<!-- 2018/07 Start EagleOffice 连接HR System -->
	
	/**
	 * 发送社会活动邮件
	 */
	public void sendActivityEmail(Map mapParameter);
	public void sendEvsEmail(Map mapParameter); 
	public void sendTrainPlanEmail(Map mapParameter); 
	public void sendAttendanceEmail(Map mapParameter);
	
	//<!-- 2018/07 Start EagleOffice 连接HR System -->
	public void sendPayStubEmail(HttpServletRequest request,List resultList);
	
	@SuppressWarnings("unchecked")
	public List getAffirmInfoEmailApproval(HttpServletRequest request);

	/**
	 * 只获取指定申请编号(APPLY_NO，多个用逗号分隔)的待发送审批信息，避免把其他历史待发送数据一并同步
	 */
	@SuppressWarnings("unchecked")
	public List getAffirmInfoEmailApproval(HttpServletRequest request, String applyNos);

	/**
	 * 获取需要在eagleoffice里面取消申请的信息
	 */
	@SuppressWarnings("unchecked")
	public List getNeedCancelApprovalInfo(HttpServletRequest request,String type);
	
	public void synchronizationApprovalStatus();
	
	@SuppressWarnings("unchecked")
	public List getNeedCancelApprovaledInfo(HttpServletRequest request,String type);
	//<!-- 2018/07 End EagleOffice 连接HR System -->
}
