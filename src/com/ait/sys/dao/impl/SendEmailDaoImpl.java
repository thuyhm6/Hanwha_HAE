package com.ait.sys.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.ait.sys.dao.SendEmailDao;
import com.ait.web.util.SqlMapClientSupport;
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
@Repository
public class SendEmailDaoImpl extends SqlMapClientSupport implements SendEmailDao {
	
	/**
	 * 取得所有待发送邮件的申请信息
	 * @param Object
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	public List getWaitSendApplyInfoList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			
			returnList = this.queryForList("sys.endEmail.getWaitSendApplyInfoList", obj);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	
	/**
	 * 通过applyNo获取所有审批者
	 * @param Object
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getAffirmListByApplyNo(Object object) {
		// TODO Auto-generated method stub
		List returnList = new ArrayList() ;
		try {
			
			returnList = this.queryForList("sys.endEmail.getAffirmListByApplyNo", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	
	/**
	 * 通过applyNo获取所有通知人
	 * @param Object
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getReceiverListByApplyNo(Object object) {
		// TODO Auto-generated method stub
		List returnList = new ArrayList() ;
		try {
			
			returnList = this.queryForList("sys.endEmail.getReceiverListByApplyNo", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	
	/**
	 * 获取需要在eagleoffice里面取消申请的信息
	 * @param request
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getNeedCancelApprovalInfo(Object object) {
		// TODO Auto-generated method stub
		List returnList = new ArrayList() ;
		try {
			
			returnList = this.queryForList("sys.endEmail.getNeedCancelApprovalList", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	
	/**
	 * 获取需要同步ealeoffice审批信息的申请
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getSynchronizationApprovalList() {
		// TODO Auto-generated method stub
		List returnList = new ArrayList() ;
		try {
			
			returnList = this.queryForList("sys.endEmail.getSynchronizationApprovalList");
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}

	@Override
	public String updateApplySendFlag(Object object) {
		String result = "0";
		// TODO Auto-generated method stub
		try {
			
			this.update("sys.endEmail.updateAttApplySendFlag",object);
			this.update("sys.endEmail.updateOtApplySendFlag",object);
			this.update("sys.endEmail.updateOtOverApplySendFlag",object);
			this.update("sys.endEmail.updateCardApplySendFlag",object);
			this.update("sys.endEmail.updateTrainApplySendFlag",object);
			result = "1";
			
		} catch (SQLException e) {	
			
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 获取需要在eagleoffice里面取消已审批结束的信息
	 * @param request
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getNeedCancelApprovaledInfo(Object object,String type) {
		// TODO Auto-generated method stub
		List returnList = new ArrayList() ;
		try {
			if("single".equals(type) || "only".equals(type)){
				returnList = this.queryForList("sys.endEmail.getNeedCancelApprovaledList", object);
			}else{
				returnList = this.queryForList("sys.endEmail.getNeedCancelApprovaledBatchList", object);
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	
	//HMT_20231204 email to Secury
		@SuppressWarnings("unchecked")
		public List getSendDataInfoList(Object obj, String target) {
			List returnList = new ArrayList() ;
			try {
				
				returnList = this.queryForList("sys.endEmail."+target, obj);
				
			} catch (SQLException e) {			
				e.printStackTrace();
			}
			
			return returnList ;
		}
		
		@Override
		public String updateAttendace(Object object) {
			String result = "0";
			// TODO Auto-generated method stub
			try {
				
				this.update("sys.endEmail.updateAttendace",object);
				result = "1";
				
			} catch (SQLException e) {	
				
				e.printStackTrace();
			}
			return result;
		}
	
}
