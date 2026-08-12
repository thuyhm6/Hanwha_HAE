package com.ait.pa.service.imp.workManagement;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.ait.pa.dao.viewPaParamDao;
import com.ait.pa.service.workManagement.viewPaParamSer;
import com.ait.sys.bean.AdminBean;
import com.ait.web.util.ObjectBindUtil;
import com.ait.web.util.SessionUtil;
import com.ait.web.util.UiUtil;
import com.lowagie.text.pdf.BaseFont;

@Service
public class viewPaParamSerImp implements viewPaParamSer {

	Logger logger = Logger.getLogger(viewPaParamSerImp.class);

	@Autowired
	private viewPaParamDao viewPaParamDao;

	/**
	 * 方法说明（中文，英文）
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getPaInputItemParamList(HttpServletRequest request) {

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		paramMap.put("ACTIVITY", "1");

		if (request.getAttribute("FSE_FLAG") != null
				&& "Y".equals(request.getAttribute("FSE_FLAG"))) {
			paramMap.put("FSE_FLAG", "Y");
		} else {
			paramMap.put("FSE_FLAG", "N");
		}
		retrunList = viewPaParamDao.getPaInputItemParamList(paramMap);

		return retrunList;

	}

	/**
	 * clean
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int cleanTempListById(HttpServletRequest request) {

		int retrunStatu;

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CREATED_BY", admin.getPersonId());
		try {
			viewPaParamDao.cleanTempListById(paramMap);
			retrunStatu = 1;
		} catch (Exception e) {
			// TODO: handle exception
			retrunStatu = 0;
		}

		return retrunStatu;

	}

	/**
	 * clean
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int checkTempListById(HttpServletRequest request) {
		int ret = 1;
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CREATED_BY", admin.getPersonId());

		paramMap.put("CPNY_ID", admin.getCpnyId());
		try {
			viewPaParamDao.checkTempListById(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
			ret = 0;
		}
		return ret;

	}

	/**
	 * clean
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getImportCompareList(HttpServletRequest request) {

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		paramMap.put("CREATED_BY", admin.getPersonId());

		paramMap.put("ACTIVITY", "1");

		if (request.getAttribute("FSE_FLAG") != null
				&& "Y".equals(request.getAttribute("FSE_FLAG"))) {
			paramMap.put("FSE_FLAG", "Y");
		} else {
			paramMap.put("FSE_FLAG", "N");
		}

		if (UiUtil.getPageNum(request) > 0) {
			retrunList = viewPaParamDao.getImportCompareList(paramMap, UiUtil
					.getPageNum(request), UiUtil.getNumPerPage(request));

		} else {

			retrunList = viewPaParamDao.getImportCompareList(paramMap, 1, 20);
		}

		return retrunList;

	}

	/**
	 * clean
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int getImportCompareListCnt(HttpServletRequest request)
			throws Exception {

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		paramMap.put("CREATED_BY", admin.getPersonId());

		paramMap.put("ACTIVITY", "1");

		if (request.getAttribute("FSE_FLAG") != null
				&& "Y".equals(request.getAttribute("FSE_FLAG"))) {
			paramMap.put("FSE_FLAG", "Y");
		} else {
			paramMap.put("FSE_FLAG", "N");
		}

		return viewPaParamDao.getImportCompareListCnt(paramMap);

	}

	/**
	 * 计算错误的数目
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Object getImportCompareNum(HttpServletRequest request) {

		Object num = new Object();

		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		paramMap.put("CREATED_BY", admin.getPersonId());

		num = viewPaParamDao.getImportCompareNum(paramMap);

		return num;

	}

	/**
	 * 确认
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int setPaParam(HttpServletRequest request) {
		int retrunStatu = 1;

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		paramMap.put("CREATED_BY", admin.getPersonId());

		try {
			viewPaParamDao.setPaParam(paramMap);

		} catch (Exception e) {
			// TODO: handle exception
			retrunStatu = 0;
		}

		return retrunStatu;

	}

	/**
	 * monthPersonCountInfoList
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List monthPersonCountInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		retrunList = viewPaParamDao.monthPersonCountInfoList(paramMap);
		return retrunList;

	}

	/**
	 * increase
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List monthPersonIncreaseList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		retrunList = viewPaParamDao.monthPersonIncreaseList(paramMap);
		return retrunList;

	}

	/**
	 * decrease
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List monthPersonDecreaseList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		retrunList = viewPaParamDao.monthPersonDecreaseList(paramMap);
		return retrunList;

	}

	/**
	 * clean
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List monthPersonCountInfoSonList(HttpServletRequest request) {

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		String PERSON_ID = request.getParameter("PERSON_ID_ID");
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
			String P_ID[] = PERSON_ID.split(",");
			String PERSON_ID_ID = "";
			int t = 0;
			for (int i = 0; i < P_ID.length; i++) {
				if (P_ID[i] != null && !P_ID[i].trim().equals("")) {
					if (t == 0) {
						PERSON_ID_ID = "'" + P_ID[i] + "'";

					} else {
						PERSON_ID_ID += ",'" + P_ID[i] + "'";
					}
					t++;
				}

			}
			if (P_ID.length == 0) {

				PERSON_ID_ID = "''";
			}

			paramMap.put("PERSON_ID_THIS", PERSON_ID_ID);
			retrunList = viewPaParamDao.monthPersonCountInfoSonList(paramMap);
		}
		return retrunList;

	}

	/**
	 * 以前工资支付日
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Object getPerPaInfo(HttpServletRequest request) {

		Object num = new Object();

		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		paramMap.put("CREATED_BY", admin.getPersonId());

		num = viewPaParamDao.getPerPaInfo(paramMap);

		return num;

	}

	@SuppressWarnings("unchecked")
	public String savePaResult(HttpServletRequest request) {
		String returnString = "";
		// 页面提交数据paInputItem
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String test[] = request.getParameterValues("paInputItem");
		paramMap.put("PERSON_ID", admin.getPersonId());
		paramMap.put("CREATED_IP", admin.getAdminIP());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		viewPaParamDao.updatePaResult(paramMap); // 更新之前的状态
		String CHECK_PARAM_ITEM_NAME = request
				.getParameter("CHECK_PARAM_ITEM_NAME");

		if (CHECK_PARAM_ITEM_NAME != null && !CHECK_PARAM_ITEM_NAME.equals("")) {
			String no_name_id[] = CHECK_PARAM_ITEM_NAME.split(",");// name-no-id...
			for (int i = 0; i < no_name_id.length; i++) {

				String[] get_no = no_name_id[i].split("-");// name..no..id..
				if (get_no.length == 3) {
					paramMap.put("ITEM_NAME", get_no[0]);
					paramMap.put("ITEM_NO", get_no[1]);
					paramMap.put("ITEM_ID", get_no[2]);

					returnString = viewPaParamDao.savePaResult(paramMap);

				}
				if (get_no.length == 4) {
					paramMap.put("ITEM_NAME", get_no[0]);
					paramMap.put("ITEM_NO", get_no[1]);
					paramMap.put("ITEM_ID", get_no[2]);
					paramMap.put("ORDERNO", get_no[3]);

					returnString = viewPaParamDao.savePaResult(paramMap);

				}

			}

		}

		return returnString;
	}

	/**
	 * 发令核查
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List viewVerificationList(HttpServletRequest request) {

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.viewVerificationList(paramMap);

		return retrunList;

	}

	/**
	 * 支付合计
	 * 
	 * @param parameterObject
	 * @return
	 * @throws ParseException
	 * @throws ParseException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List viewPaResultList(HttpServletRequest request)
			throws ParseException {

		List retrunList = new ArrayList() ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunList = viewPaParamDao.viewPaResultList(paramMap) ;
		}
		return retrunList ;

	}

	/**
	 * 支付合计 合计
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List viewPaResultListSum(HttpServletRequest request) {

		List retrunList = new ArrayList() ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunList = viewPaParamDao.viewPaResultListSum(paramMap) ;
		}
		return retrunList ;

	}

	/**
	 * 查询工资详细明细 （个人 按person_id）
	 */
	@Override
	public List detailPersonCountInfoList(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String PERSON_ID = request.getParameter("PERSON_ID");
		paramMap.put("CREATED_BY", admin.getPersonId());
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
			/*int result = viewPaParamDao.callPayP(paramMap);
			if (result == 1) {*/

				retrunList = viewPaParamDao.detailPersonCountInfoList(paramMap);

			/*}*/

		}
		return retrunList;

	}

	/**
	 * 查询工资单详细明细 （个人 按person_id）
	 */
	@Override
	public List getEmpSalaryInfoList(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String PERSON_ID = request.getParameter("PERSON_ID");
		paramMap.put("CREATED_BY", admin.getPersonId());
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
			/*int result = viewPaParamDao.callPayP(paramMap);
			if (result == 1) {*/

				retrunList = viewPaParamDao.getEmpSalaryInfoList(paramMap);

			/*}*/

		}
		return retrunList;

	}

	/**
	 * 取得月工资明细的右边数据
	 */
	@Override
	public List detailMonthCountInfoRight(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String PERSON_ID = request.getParameter("PERSON_ID");
		paramMap.put("CREATED_BY", admin.getPersonId());
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
			/*int result = viewPaParamDao.callPayP(paramMap);
			if (result == 1) {*/

				retrunList = viewPaParamDao.detailMonthCountInfoRight(paramMap);

			/*}*/

		}
		return retrunList;

	}

	/**
	 * 取得年工资明细的右边数据
	 */
	@Override
	public List detailYearCountInfoRight(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String PERSON_ID = request.getParameter("PERSON_ID");
		paramMap.put("CREATED_BY", admin.getPersonId());
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
			/*int result = viewPaParamDao.callPayP(paramMap);
			if (result == 1) {*/

				retrunList = viewPaParamDao.detailYearCountInfoRight(paramMap);

			/*}*/

		}
		return retrunList;

	}
	/**
	 * 查询个人别核对
	 */
	@Override
	public List detailPersonCountInfoRight(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String PERSON_ID = request.getParameter("PERSON_ID");
		paramMap.put("CREATED_BY", admin.getPersonId());
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
			/*int result = viewPaParamDao.callPayP(paramMap);
			if (result == 1) {*/

				retrunList = viewPaParamDao.detailPersonCountInfoRight(paramMap);

			/*}*/

		}
		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List detailPersonCountInfoLeft(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.detailPersonCountInfoLeft(paramMap);

		return retrunList;

	}
	/**
	 * 取得工资详细明细人员数
	 * @param request
	 * @return Object
	 */
	@Override
	public Object getPaDetailEmpInfoByPersonId(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		if(paramMap.get("PERSON_ID")==null){
			paramMap.put("PERSON_ID",admin.getPersonId());
		}
		return viewPaParamDao.getPaDetailEmpInfoByPersonId(paramMap);
	}

	/**
	 * 取得工资详细明细下方数据
	 */
	@Override
	public List getPaDetailInfoList(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		paramMap.put("CREATED_BY", admin.getPersonId());
		retrunList = viewPaParamDao.getPaDetailInfoList(paramMap);

		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List detailYearCountInfoLeft(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.detailYearCountInfoLeft(paramMap);

		return retrunList;

	}

	/**
	 * 调用
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int callProForPayMonthDif(HttpServletRequest request) {
		int retrunStatu;

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		paramMap.put("CPNY_ID", admin.getCpnyId());

		paramMap.put("CREATED_BY", admin.getPersonId());

		try {
			viewPaParamDao.callProForPayMonthDif(paramMap);
			retrunStatu = 1;
		} catch (Exception e) {
			// TODO: handle exception
			retrunStatu = 0;
		}

		return retrunStatu;

	}

	@Override
	public List detailItemCountInfoList(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		retrunList = viewPaParamDao.detailItemCountInfoList(paramMap);

		return retrunList;

	}

	@Override
	public List itemValueInfo(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = ObjectBindUtil
				.getRequestParamData(request);
		List retrunList = new ArrayList();

		retrunList = viewPaParamDao.itemValueInfo(paramMap);

		return retrunList;

	}

	@Override
	public List checkViewPaResult(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		List retrunList = new ArrayList();
		paramMap.put("IS_USE2", request.getParameter("IS_USE2"));
		paramMap.put("ITEM_TYPE2", request.getParameter("ITEM_TYPE2"));
		retrunList = viewPaParamDao.checkViewPaResult(paramMap);

		return retrunList;

	}

	/**
	 * 支付合计(部门)
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List viewDeptPaResultList(HttpServletRequest request) {

		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		String PAY_SCHEDULE_NO = request.getParameter("PAY_SCHEDULE_NO");
		if (PAY_SCHEDULE_NO != null && !PAY_SCHEDULE_NO.equals("")) {
			retrunList = viewPaParamDao.viewDeptPaResultList(paramMap);
		}
		return retrunList;

	}
	
	/**
	 * 支付合计(部门)合计
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List viewDeptPaResultListSum(HttpServletRequest request) {

		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		String PAY_SCHEDULE_NO = request.getParameter("PAY_SCHEDULE_NO");
		if (PAY_SCHEDULE_NO != null && !PAY_SCHEDULE_NO.equals("")) {
			retrunList = viewPaParamDao.viewDeptPaResultListSum(paramMap);
		}
		return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List viewResultConfirmSonList0(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		if(paramMap.get("PAY_DATE")!=null && paramMap.get("PAY_DATE_PRO")!=null){
			retrunList = viewPaParamDao.viewResultConfirmSonList0(paramMap);
		}
		
        return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List viewResultConfirmSonList1(HttpServletRequest request) {

		List retrunList = new ArrayList();

		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		retrunList = viewPaParamDao.viewResultConfirmSonList1(paramMap);
		return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List viewResultConfirmSonList2(HttpServletRequest request) {

		List retrunList = new ArrayList();

		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		if(paramMap.get("PAY_DATE")!=null && paramMap.get("SALARY_DISTIN_NO")!=null){
		   retrunList = viewPaParamDao.viewResultConfirmSonList2(paramMap);
		}
		return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List viewResultConfirmSonList3(HttpServletRequest request) {

		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		paramMap.put("CREATED_BY", admin.getAdminID());
		String ITEM_TYPE = request.getParameter("ITEM_TYPE");
		if (ITEM_TYPE != null && !ITEM_TYPE.equals("")) {
			int result = viewPaParamDao.callProForPayMonthDifItem(paramMap);
			if (result == 1) {
				retrunList = viewPaParamDao.viewResultConfirmSonList3(paramMap);
			}
		}
		return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List viewResultConfirmSonList4(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		retrunList = viewPaParamDao.viewResultConfirmSonList4(paramMap);
		return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List viewResultConfirmSonList5(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		if(paramMap.get("PAY_DATE")!=null && paramMap.get("SALARY_DISTIN_NO")!=null){
			retrunList = viewPaParamDao.viewResultConfirmSonList5(paramMap);
		}
		return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List viewResultConfirmSonList6(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		if(paramMap.get("PAY_DATE")!=null && paramMap.get("SALARY_DISTIN_NO")!=null){
		    retrunList = viewPaParamDao.viewResultConfirmSonList6(paramMap);
		}
		return retrunList;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List paEmpAccount(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		retrunList = viewPaParamDao.paEmpAccount(paramMap);
		return retrunList;

	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List paEmpVacInfo(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		retrunList = viewPaParamDao.paEmpVacInfo(paramMap);
		return retrunList;

	}
	
	/**
	 * 工资条员工基础信息 (Staff foundation information)
	 * @param request
	 * @return Object
	 */
	@Override
	public Object getPersonalInfoForEmpSalaryInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		if(paramMap.get("PERSON_ID")==null){
			paramMap.put("PERSON_ID",admin.getPersonId());
		}
		return viewPaParamDao.getPersonalInfoForEmpSalaryInfo(paramMap);
	}

	/**
	 * 计算错误的数目
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Object paOpenFlag(HttpServletRequest request) {

		Object num = new Object();

		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		num = viewPaParamDao.paOpenFlag(paramMap);

		return num;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List paPayScheduleNoByPersonId(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("PERSON_ID", admin.getAdminID());
		retrunList = viewPaParamDao.paPayScheduleNoByPersonId(paramMap);
		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List viewResultConfirmList2Right(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.viewResultConfirmList2Right(paramMap);

		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List viewResultConfirmList2Bottom(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		paramMap.put("CREATED_BY", admin.getAdminID());
		retrunList = viewPaParamDao.viewResultConfirmList2Bottom(paramMap);

		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List viewResultConfirmList3Right(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		paramMap.put("CREATED_BY", admin.getAdminID());

		retrunList = viewPaParamDao.viewResultConfirmList3Right(paramMap);

		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List viewPaArSummaryList(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		int result = 0;
		paramMap.put("CREATED_BY", admin.getAdminID());
		result = viewPaParamDao.callPaArSummarySearch(paramMap);
		if (result == 1) {

			List retist = viewPaParamDao.viewPaArSummaryList(paramMap);
			// 取字段名称

			Map COLUMN_NAMES = (Map) retist.get(0);// 取出所有的表头
			paramMap.put("COLUMN_NAMES", COLUMN_NAMES.get("COLUMN_NAMES"));// -

			retrunList = viewPaParamDao.viewPaArSummarySearchList(paramMap);

		}

		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List viewPaArSummarySearchList(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");
		paramMap.put("CREATED_BY", admin.getAdminID());
		int result = 0;
		result = viewPaParamDao.callPaArSummarySearch(paramMap);
		if (result == 1) {

			List retist = viewPaParamDao.viewPaArSummaryList(paramMap);
			// 取字段名称

			Map COLUMN_NAMES = (Map) retist.get(0);// 取出所有的表头
			paramMap.put("COLUMN_NAMES", COLUMN_NAMES.get("COLUMN_NAMES"));// -

			retrunList = viewPaParamDao.viewPaArSummarySearchLowList(paramMap);

		}

		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List exportPayDetailTxtReport(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.exportPayDetailTxtReport(paramMap);

		return retrunList;

	}

	/**
	 * LIST
	 */
	@Override
	public List getPayScheduleList(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();
		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.getPayScheduleList(paramMap);

		return retrunList;

	}

	/**
	 * 日别项目核对
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List dayPersonCountInfoList(HttpServletRequest request) {

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.dayPersonCountInfoList(paramMap);

		return retrunList;

	}

	/**
	 * 日别项目核对
	 * 
	 * @param parameterObject
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List dayPersonCountInfo2List(HttpServletRequest request) {

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(
				request, "seach_");

		retrunList = viewPaParamDao.dayPersonCountInfoList(paramMap);

		return retrunList;

	}
	
	/**
	 * 工资报表支付合计
	 * 
	 * @param parameterObject
	 * @return
	 * @throws ParseException
	 * @throws ParseException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getPayDetailList(HttpServletRequest request) throws ParseException {

		List retrunList = new ArrayList() ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunList = viewPaParamDao.getPayDetailList(paramMap) ;
		}
		return retrunList ;

	}
	
	/**
	 * 获得工资计划的考勤月
	 * 
	 * @param parameterObject
	 * @return String
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String getPayScheduleArDate(HttpServletRequest request){

		String retrunStr = "";
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunStr = viewPaParamDao.getPayScheduleArDate(paramMap) ;
		}
		return retrunStr;

	}
	
	/**
	 * 获得工资参数
	 * 
	 * @param parameterObject
	 * @return String
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String getPayParamOther(HttpServletRequest request, String sqlname, String param){

		String retrunStr = "";
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunStr = viewPaParamDao.getPayParamOther(paramMap, sqlname, param) ;
		}
		return retrunStr;

	}
	
	/**
	 * 获得工资计划的考勤月（英文返回）
	 * 
	 * @param parameterObject
	 * @return String
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String getPayScheduleArMonthEng(Map paramMap){

		String retrunStr = "";
		// 页面提交数据
		//LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunStr = viewPaParamDao.getPayScheduleArMonthEng(paramMap) ;
		}
		return retrunStr;

	}
	
	/**
	 * 获得工资计划的考勤月应出勤天数
	 * 
	 * @param parameterObject
	 * @return String
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String getPayWorkScheduleDays(HttpServletRequest request){

		String retrunStr = "";
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunStr = viewPaParamDao.getPayWorkScheduleDays(paramMap) ;
		}
		return retrunStr;

	}
	
	@SuppressWarnings("unchecked")
	public List getPayrollPersonList(HttpServletRequest request){
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		List payrollPersonList = new ArrayList();
		List payInfolist = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getPersonId());
		payrollPersonList = viewPaParamDao.getPayrollPersonList(paramMap) ;
		if(payrollPersonList != null){
			for(int i=0;i<payrollPersonList.size();i++){
				LinkedHashMap personMap = new LinkedHashMap();
				paramMap.put("PERSON_ID", ((Map)payrollPersonList.get(i)).get("PERSON_ID"));
				personMap.put("personInfo", viewPaParamDao.getPersonalInfoForEmpSalaryInfo(paramMap)); //个人工资明细
				personMap.put("paEmpAccount", viewPaParamDao.paEmpAccount(paramMap)); //护航
				personMap.put("paEmpVacInfo", viewPaParamDao.paEmpVacInfo(paramMap)); //年假
				personMap.put("insuranceRateList", viewPaParamDao.getEmpInsuranceRate(paramMap)); //%保险
				personMap.put("paInputItemList", viewPaParamDao.getPaInputItemListByItemNo(paramMap)); //其他福利
				// 工资细节明细
				List detailPersonCountInfoList = this.viewPaParamDao.getEmpSalaryInfoList(paramMap); //工资条
				personMap.put("payStubList", detailPersonCountInfoList);

				payInfolist.add(personMap);
			}
		}
		
		return payInfolist;
	}
	
	/**
	 * 取得个人的所有保险比例（个人 按person_id）
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getEmpInsuranceRate(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String PERSON_ID = request.getParameter("PERSON_ID");
		
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
				retrunList = viewPaParamDao.getEmpInsuranceRate(paramMap);
		}
		return retrunList;

	}
	
	/**
	 * 取得个人某一个输入项目的列表（个人 按person_id）
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getPaInputItemListByItemNo(HttpServletRequest request) {
		// TODO Auto-generated method stub

		List retrunList = new ArrayList();

		// 页面提交数据
		Map<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request, "seach_");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String PERSON_ID = request.getParameter("PERSON_ID");
		
		if (PERSON_ID != null && !PERSON_ID.equals("")) {
				retrunList = viewPaParamDao.getPaInputItemListByItemNo(paramMap);
		}
		return retrunList;

	}

	/**
	 * HAE的工资支付报表
	 * 
	 * @param parameterObject
	 * @return
	 * @throws ParseException
	 * @throws ParseException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getPayDetailList(HttpServletRequest request,String sqlNmae) throws ParseException {

		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO")!=null){
			retrunList = viewPaParamDao.getPayDetailList(paramMap,sqlNmae) ;
		}
		return retrunList ;

	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List getPayDetailList(HttpServletRequest request,String sqlNmae, String param, String target) throws ParseException {

		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		paramMap.put("POST_GRADE", target);
		paramMap.put("SALARY_PARAM", param);
			retrunList = viewPaParamDao.getPayDetailList(paramMap,sqlNmae) ;
		return retrunList ;

	}
	
	/**
	 * HAE的保险对比报表
	 * 
	 * @param HttpServletRequest
	 * @return
	 * @throws ParseException
	 * @throws ParseException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getPayInsuranceComparisonList(HttpServletRequest request) throws ParseException {

		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO_CURRENT")!=null){
			retrunList = viewPaParamDao.getPayInsuranceComparisonList(paramMap);
		}
		return retrunList ;

	}
	
	/**
	 * HAE的保险对比报表总计
	 * 
	 * @param HttpServletRequest
	 * @return
	 * @throws ParseException
	 * @throws ParseException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List getPayInsuranceComparisonListSum(HttpServletRequest request) throws ParseException {

		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		if(paramMap.get("PAY_SCHEDULE_NO_CURRENT")!=null){
			retrunList = viewPaParamDao.getPayInsuranceComparisonListSum(paramMap);
		}
		return retrunList ;

	}
	/**
	 * 在服务器上生成工资表pdf文件,以提供邮件附件
	 * 
	 * @param HttpServletRequest,List
	 * @return int
	 * @author lipeng
	 * @date 2018/05/26
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int createPayStubPDF(HttpServletRequest request,List payInfolist){

		int returnInt = 0;
		
		String basePath = request.getSession().getServletContext().getRealPath("");
		String inputFile = basePath+"//resources//template//mail//payStub.htm";
		String outputFile = basePath+"//resources//template//payPdf//payStub.pdf";
		InputStream is = null;
		InputStreamReader isr = null;
		String result = "";
		String replaceStr = "";
		double replaceDou = 0;
		DecimalFormat decimalFormat = new DecimalFormat("#,##0");

		try {
			
			for(int i=0;i<payInfolist.size();i++){
				
				/*取三种项目最多的数量*/
				int maxDataCount = 0;
				int dataCount_1 = 0;
				int dataCount_2 = 0;
				int dataCount_3 = 0;
				
				/*读取模板*/
				int data=0;
				char[] ch =new char[1024];
				is = new FileInputStream(inputFile);
				isr = new InputStreamReader(is,"utf-8");
				result = "";
				while((data = isr.read(ch))!=-1){
	                 result+=new String(ch,0,data);
				}
				
				Map resultMap = (Map) payInfolist.get(i);
				Map personInfo = (Map) resultMap.get("personInfo");
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
				
				List paEmpVacInfo = (List) resultMap.get("paEmpVacInfo");
				replaceStr = "";
				for(int j=0;j<paEmpVacInfo.size();j++){
					Map vacMap = (Map) paEmpVacInfo.get(j);
					replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+vacMap.get("TOTAL_VAC_CNT")+"</td>"
				                  + "<td style='text-align: center;' class='td_type'>"+vacMap.get("USED_VAC_CNT")+"</td>"
				                  + "<td style='text-align: center;' class='td_type'>"+vacMap.get("SHENGYU_VAC_CNT")+"</td></tr>";
				}
				result = result.replace("[Annual leave]", replaceStr);
				
				List paEmpAccount = (List) resultMap.get("paEmpAccount");
				replaceStr = "";
				for(int j=0;j<paEmpAccount.size();j++){
					Map accMap = (Map) paEmpAccount.get(j);
					replaceStr += "<tr><td style='text-align: center;' class='td_type'>"+accMap.get("ACCOUNT_TYPE")+"</td>"
				                  + "<td style='text-align: center;' class='td_type'>"+accMap.get("ACCOUNT_NO")+"</td></tr>";
				}
				result = result.replace("[Bank Account]", replaceStr);
				/*标准项目*/
				List payStubList = (List) resultMap.get("payStubList");
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
				List insuranceRateList = (List) resultMap.get("insuranceRateList");
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
				List paInputItemList = (List) resultMap.get("paInputItemList");
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
				
				OutputStream os = new FileOutputStream(outputFile.replace("payStub", personInfo.get("EMPID")+"_"+personInfo.get("PAY_DATE")));     
		        String url = new File(inputFile).toURI().toURL().toString();
				
				ITextRenderer renderer = new ITextRenderer();
		        renderer.setDocumentFromString(result);
		        
		        // 解决越南语支持问题     
		        ITextFontResolver fontResolver = renderer.getFontResolver();    
		        fontResolver.addFont(basePath.replace("\\", "/")+"/"+"/resources/font/"+"times.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);     
		        //解决图片的相对路径问题 
		        renderer.getSharedContext().setBaseURL("file:/"+basePath.replace("\\", "/")+"/");
		        //System.out.print("file:/"+basePath.replace("\\", "/")+"/");
		        renderer.layout();    
		        renderer.createPDF(os);  
		
		        os.flush();
				os.close();
			
			}
			returnInt = 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return returnInt ;

	}
}
