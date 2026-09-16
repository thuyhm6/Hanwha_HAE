package com.ait.sys.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.ait.sys.dao.NoticeManageDAO;
import com.ait.web.util.SqlMapClientSupport;
import com.ait.web.util.StringUtil;

@Repository
public class NoticeManageDAOImpl extends SqlMapClientSupport implements NoticeManageDAO{

	@Override
	public int delNoticeInfo(List list){
		int returnInt = 1;
		try {
			this.deleteForList("sys.notice.delNoticeInfo", list);
			Map object = new LinkedHashMap();
			if(list!=null && list.size()>0){
				object = (Map) list.get(0);
				object.put("APPLY_NO", object.get("ID"));
				object.put("APPLY_TYPE", "0303");
				this.delete("hrm.empinfo.deleteBadArchivesFilesInfo", object);
			}
		} catch (Exception e) {
			returnInt = 0;
			e.printStackTrace();
		}
		return returnInt;
	}

	@Override
	public List getNoticeInfo(Object parameterObject,int pageNum,int pageSize) throws Exception{
		return this.queryForList("sys.notice.getNoticeInfo", parameterObject,pageNum,pageSize);
	}
	@Override
	public List getNoticeInfo1(Object parameterObject,int pageNum,int pageSize) throws Exception{
		return this.queryForList("sys.notice.getNoticeInfo1", parameterObject,pageNum,pageSize);
	}

	@Override
	public Map getNoticeInfoById(Object parameterObject) throws Exception{
		return (LinkedHashMap)this.queryForObject("sys.notice.getNoticeInfoById", parameterObject);
	}
	
	/**
	 * 在insert前查找当前序列，方便同时将序列的值插入到公告表和文件保存的表，方便查找自己对应的附件
	 * @return
	 */
	public String getNoticeInfoSeq(){
		String str = null;
		try {
			str = ObjectUtils.toString(this
					.queryForObject("sys.notice.getNoticeInfoSeq"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return str;
	}

	@Override
	public int insertNoticeInfo(Object parameterObject){
		int returnInt = 1;
		try {
			Map obj = (Map) parameterObject;
			String NOTICE_NO = getNoticeInfoSeq();
			obj.put("NOTICE_NO", NOTICE_NO);
			this.insert("sys.notice.insertNoticeInfo", parameterObject);
			//保存附件
			if (obj.get("FILE_NAME") != null && !"".equals(StringUtil.checkNull(obj.get("FILE_NAME")))) {
				String[] fileName = StringUtil.checkNull(obj.get("FILE_NAME")).split(";");
				String[] fileUrl = StringUtil.checkNull(obj.get("FILE_URL")).split(";");
				if (fileUrl != null && fileUrl.length > 0) {
					for (int j=0;j<fileUrl.length ;j++) {
						LinkedHashMap fileMap = new LinkedHashMap();
						fileMap.put("fileName", fileName[j]);
						fileMap.put("fileUrl", "/resources/temp/apply/applyleave/" + obj.get("CREATE_BY") + "/" + fileUrl[j]);
						fileMap.put("APPLY_NO", obj.get("NOTICE_NO"));
						fileMap.put("APPLY_TYPE", "0303");//0303是虚拟数据  在ESS_FILE里面代表是公告
						fileMap.put("CREATED_BY", obj.get("CREATE_BY"));
						this.insert("ess.infoApplyLeave.insertEssFile",fileMap);
					}
				}
			}
		} catch (Exception e) {
			returnInt = 0;
			e.printStackTrace();
		}
		return returnInt;
	}

	@Override
	public int updateNoticeInfo(Object parameterObject) {
		int returnInt = 1;
		try {
			Map obj = (Map) parameterObject;
			this.update("sys.notice.updateNoticeInfo", obj);
			//保存附件
			if (obj.get("FILE_NAME") != null && !"".equals(StringUtil.checkNull(obj.get("FILE_NAME")))) {
				String[] fileName = StringUtil.checkNull(obj.get("FILE_NAME")).split(";");
				String[] fileUrl = StringUtil.checkNull(obj.get("FILE_URL")).split(";");
				LinkedHashMap fileMap1 = new LinkedHashMap();
				fileMap1.put("APPLY_NO", obj.get("ID"));
				fileMap1.put("APPLY_TYPE","notice");
				this.insert("ess.infoApplyLeave.deleteEssFile",fileMap1);
				if (fileUrl != null && fileUrl.length > 0) {
					for (int j=0;j<fileUrl.length ;j++) {
						LinkedHashMap fileMap = new LinkedHashMap();
						fileMap.put("fileName", fileName[j]);
						fileMap.put("fileUrl", "/resources/temp/apply/applyleave/" + obj.get("UPDATED_BY") + "/" + fileUrl[j]);
						fileMap.put("APPLY_NO", obj.get("ID"));
						fileMap.put("APPLY_TYPE", "notice");//0303是虚拟数据  在ESS_FILE里面代表是公告
						fileMap.put("CREATED_BY", obj.get("UPDATED_BY"));
						this.insert("ess.infoApplyLeave.insertEssFile",fileMap);
					}
				}
			}
		} catch (Exception e) {
			returnInt = 0;
			e.printStackTrace();
		}
		return returnInt;
	}

	@Override
	public List getNoticeInfo(Object parameterObject) throws Exception {
		return this.queryForList("sys.notice.getNoticeInfo", parameterObject);
	}
	
	@Override
	public List getNoticeInfo1(Object parameterObject) throws Exception {
		return this.queryForList("sys.notice.getNoticeInfo1", parameterObject);
	}

	@Override
	public int getNoticeInfoCn(Object parameterObject) throws Exception {
		int count = 0;
		count = Integer.parseInt(ObjectUtils.toString(this.queryForObject("sys.notice.getNoticeInfoCn",
				parameterObject), "0"));
		return count;
	}
	
	@Override
	public int getNoticeInfoCn1(Object parameterObject) throws Exception {
		int count = 0;
		count = Integer.parseInt(ObjectUtils.toString(this.queryForObject("sys.notice.getNoticeInfoCn1",
				parameterObject), "0"));
		return count;
	}

	@Override
	public int delOverNoticeInfo(Object parameterObject) {
		int returnInt = 1;
		try {
			this.delete("sys.notice.delOverNoticeInfo",
					parameterObject);
		} catch (Exception e) {
			returnInt = 0;
			e.printStackTrace();
		}
		return returnInt;
	}


	public int uploadAtt(Object parameterObject){
		int returnInt = 1;
		try {
			Map obj = (Map) parameterObject;
			//保存附件
			if (obj.get("FILE_NAME") != null && !"".equals(StringUtil.checkNull(obj.get("FILE_NAME")))) {
				String[] fileName = StringUtil.checkNull(obj.get("FILE_NAME")).split(";");
				String[] fileUrl = StringUtil.checkNull(obj.get("FILE_URL")).split(";");
				if (fileUrl != null && fileUrl.length > 0) {
					for (int j=0;j<fileUrl.length ;j++) {
						LinkedHashMap fileMap = new LinkedHashMap();
						fileMap.put("fileName", fileName[j]);
						fileMap.put("fileUrl", "/resources/temp/apply/applyleave/" + obj.get("CREATE_BY") + "/" + fileUrl[j]);
						fileMap.put("APPLY_NO", obj.get("APPLY_NO"));
						fileMap.put("APPLY_TYPE", obj.get("APPLY_TYPE"));
						fileMap.put("CREATED_BY", obj.get("CREATE_BY"));
						this.insert("ess.infoApplyLeave.insertEssFile",fileMap);
					}
				}
			}
		} catch (Exception e) {
			returnInt = 0;
			e.printStackTrace();
		}
		return returnInt;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int uploadAttPhoto(Object parameterObject){
		int returnInt = 1;
		try {
			Map obj = (Map) parameterObject;
			//保存附件
			if (obj.get("FILE_NAME") != null && !"".equals(StringUtil.checkNull(obj.get("FILE_NAME")))) {
				String[] fileName = StringUtil.checkNull(obj.get("FILE_NAME")).split(";");
				String[] fileUrl = StringUtil.checkNull(obj.get("FILE_URL")).split(";");
				if (fileName != null && fileName.length > 0) {
					for (int j=0;j<fileName.length ;j++) {
						LinkedHashMap fileMap = new LinkedHashMap();
						String filename=fileName[j].trim();
						if (obj.get("APPLY_NO") == "upload_CV" || "upload_CV".equals(obj.get("APPLY_NO"))) {
							fileMap.put("fileName", filename);
							fileMap.put("fileUrl", "/resources/temp/recFiles/" + fileMap.get("adminID") + "/" + fileUrl[j]);
							int num = filename.indexOf(".");
							String cert_number = filename.substring(0, num);
							cert_number = cert_number.trim();
							fileMap.put("CERT_NUMBER", cert_number);
							this.update("hrm.recPage.addCVRecPage", fileMap);
						} else {
						fileMap.put("fileName", filename);
						fileMap.put("fileUrl", "/resources/photo/" + obj.get("CPNY_ID") + "/" + fileUrl[j]);
						fileMap.put("APPLY_NO", obj.get("APPLY_NO"));
						fileMap.put("APPLY_TYPE", obj.get("APPLY_TYPE"));
						fileMap.put("CREATED_BY", obj.get("CREATE_BY"));
						fileMap.put("CPNY_ID", obj.get("CPNY_ID"));
						this.insert("ess.infoApplyLeave.insertEssFile",fileMap);
						}
					}
				}
			}
		} catch (Exception e) {
			returnInt = 0;
			e.printStackTrace();
		}
		return returnInt;
	}
	
	/**
	 * Send SMS
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getSendSMSList(Object obj) {
		List returnList = new ArrayList();
		returnList = this.getSendSMSList(obj, -1, -1);
		return returnList;
	}

	@Override
	public int getSendSMSCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("sys.notice.getSendSMSCnt", obj)),Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 取得所有登陆用户列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getSendSMSList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			if (currentPage > -1 && pageSize > -1) {
				returnList = this.queryForList("sys.notice.getSendSMSList", obj, currentPage,pageSize);
			} else {
				returnList = this.queryForList("sys.notice.getSendSMSList", obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	
	/**
	 * 插入登陆者信息
	 * 
	 * @param Object
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int addSendSMSInfo(Object obj) throws Exception {
		int returnInt = 1;
		this.insert("sys.notice.insertSendSMSInfo", obj);
		return returnInt;
	}
	
	@SuppressWarnings("unchecked")
	public int addRecordInfo(Object obj, String target) throws Exception {
		int returnInt = 1;
		this.insert("sys.notice."+target, obj);
		return returnInt;
	}
	
	@SuppressWarnings("unchecked")
	public List viewRecordList(Object object, String target) {
		List list = new ArrayList();
		try {
			list = this.queryForList("sys.notice."+target, object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List getFeedbackList(Object parameterObject) throws Exception {
		return this.queryForList("sys.notice.getFeedbackList", parameterObject);
	}

	@Override
	public List getFeedbackList(Object parameterObject, int pageNum, int pageSize) throws Exception {
		return this.queryForList("sys.notice.getFeedbackList", parameterObject, pageNum, pageSize);
	}

	@Override
	public int getFeedbackListCn(Object parameterObject) throws Exception {
		int count = 0;
		count = Integer.parseInt(ObjectUtils.toString(this.queryForObject("sys.notice.getFeedbackListCn",
				parameterObject), "0"));
		return count;
	}

	@Override
	public Map getFeedbackById(Object parameterObject) throws Exception {
		return (LinkedHashMap) this.queryForObject("sys.notice.getFeedbackById", parameterObject);
	}

	@Override
	public List getPersonalDataConfirmList(Object parameterObject) throws Exception {
		return this.queryForList("sys.notice.getPersonalDataConfirmList", parameterObject);
	}

	@Override
	public List getPersonalDataConfirmList(Object parameterObject, int pageNum, int pageSize) throws Exception {
		return this.queryForList("sys.notice.getPersonalDataConfirmList", parameterObject, pageNum, pageSize);
	}

	@Override
	public int getPersonalDataConfirmListCn(Object parameterObject) throws Exception {
		int count = 0;
		count = Integer.parseInt(ObjectUtils.toString(this.queryForObject("sys.notice.getPersonalDataConfirmListCn",
				parameterObject), "0"));
		return count;
	}

	@Override
	public Map getPersonalDataConfirmDetail(Object parameterObject) throws Exception {
		return (LinkedHashMap) this.queryForObject("sys.notice.getPersonalDataConfirmDetail", parameterObject);
	}
}
