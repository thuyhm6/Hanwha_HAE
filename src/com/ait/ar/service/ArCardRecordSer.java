package com.ait.ar.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

/**
 * Copyright: LDCC Company: LDCC
 * 
 * @fileName: ArCardRecordSer.java
 * @Description: implement Class ArCardRecordSerImp.java
 * @Create date: 2012-4-18 下午06:03:06
 * @Create by: jiahc(jiahongchang@ait.net.cn)
 * @version 5.1
 */
public interface ArCardRecordSer {
	@SuppressWarnings("unchecked")
	public List getArCardRecordList(HttpServletRequest request);

	@SuppressWarnings("unchecked")
	public List getArCardRecordForSelfList(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public int getArCardRecordListCnt(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public List getArCardRecordMealList(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public List getArCardRecordCompanyList(HttpServletRequest request);

	@SuppressWarnings("unchecked")
	public int getArCardRecordMealListCnt(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public int getArCardRecordListForSelfCnt(HttpServletRequest request);

	@SuppressWarnings("unchecked")
	public int updateArCardRecordInfo(HttpServletRequest request);

	@SuppressWarnings("unchecked")
	public int deleteArCardRecordInfo(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public int deleteRecord(HttpServletRequest request, String target);

	@SuppressWarnings("unchecked")
	public int addArCardRecordInfo(HttpServletRequest request);

	@SuppressWarnings("unchecked")
	public Object getArCardRecordInfo(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public List getArCardTemporaryList(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public int addArCardTemporaryInfo(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public int updateArCardTemporaryInfo(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public Object getArCardTemporaryInfo(HttpServletRequest request);
	
	@SuppressWarnings("unchecked")
	public List getAttendanceStatus(HttpServletRequest request);

	/**
	 * 取刷卡数据列表(get ArCardRecord List)
	 * 
	 * @param request
	 * @return List
	 * @throws 
	 */
	@SuppressWarnings("unchecked")
	public List getArCardRecordDayList(HttpServletRequest request);
}
