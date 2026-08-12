package com.ait.ar.service.impl;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.ait.ar.dao.ArReadCardDao;
import com.ait.ar.service.ArReadCardSer;
import com.ait.mac.conn.ConnBean;
import com.ait.sys.bean.AdminBean;
import com.ait.web.config.ConfigurationException;
import com.ait.web.util.DateUtil;
import com.ait.web.util.ObjectBindUtil;
import com.ait.web.util.ReadFile;
import com.ait.web.util.SessionUtil;
import com.ait.web.util.StringUtil;
import com.ait.web.util.UiUtil;
import com.ait.web.util.UserConfiguration;
@Service
public class ArReadCardSerImp implements ArReadCardSer {
	Logger logger = Logger.getLogger(ArReadCardSerImp.class);

	@Autowired
	private ArReadCardDao arReadCardDao;

	/**
	 * 取刷卡数据列表(get ArCardRecord List)
	 * 
	 * @param request
	 * @return List
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public List getArCardRecordList(HttpServletRequest request) {
		// TODO Auto-generated method stub
		List retrunList = new ArrayList();

		Map paramMap = ObjectBindUtil.getRequestParamData(request, "seach_");

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("LANGUAGE", admin.getLanguage());
		paramMap.put("supervisor", admin.getPersonId());

		if (UiUtil.getPageNum(request) > 0) {
			retrunList = arReadCardDao.getArCardRecordList(paramMap, UiUtil
					.getPageNum(request), UiUtil.getNumPerPage(request));
		} else {
			retrunList = arReadCardDao.getArCardRecordList(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings("unchecked")
	public int getArCardRecordListCnt(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request, "seach_");

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("LANGUAGE", admin.getLanguage());
		paramMap.put("supervisor", admin.getPersonId());

		return arReadCardDao.getArCardRecordListCnt(paramMap);
	};

	/**
	 * 刷卡读取数据(get Card Interface data)
	 * 
	 * @param request
	 * @return int
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public int getCardInterfacedata(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		// 文件目录
		UserConfiguration config = UserConfiguration
				.getInstance("/system.properties");

		String cardFilePath = "";
		try {
			// 读取本地文件（来自FTP）
			cardFilePath = config.getString("ar.local.card.path");
		} catch (ConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// 文件绝对路径
		String fileFullPath = cardFilePath + jsonString;

		List params = new ArrayList();

		try {
			// List中存放map map中以PARAM_i 的形式存放数据
			// 重新组装 加入其它参数
			List paramList = ReadFile.readTxtFileForMap(fileFullPath);
			if (paramList != null) {
				for (int i = 0; i < paramList.size(); i++) {
					Map param = new LinkedHashMap();
					param = (LinkedHashMap) paramList.get(i);
					if (param.get("PARAM_0") != null
							&& param.get("PARAM_1") != null) {
						param.put("PERSON_ID", param.get("PARAM_0"));
						param.put("R_TIME", param.get("PARAM_1"));
						param.put("CPNY_ID", "C11");
						param.put("CREATED_BY", admin.getPersonId());
						params.add(param);
					}
				}
			}

			arReadCardDao.insertMacRecordList(params);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}

		// 如果读取成功 则删除文件
		File file = new File(fileFullPath);
		file.delete();

		return 1;
	}

	@SuppressWarnings("unchecked")
	public String readMacRecordBJList(HttpServletRequest request) {
		LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap logParam = new LinkedHashMap();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		logParam.put("CPNY_ID", admin.getCpnyId());
		logParam.put("TYPE_NAME", "读取打卡记录");
		logParam.put("REMARK", "读取成功");
		String STIME = "".equals(request.getParameter("STIME")) ? DateUtil.getSysdateStr("yyyy-MM-dd") : request
				.getParameter("STIME");
		String RTIME = "".equals(request.getParameter("RTIME")) ? DateUtil.getSysdateStr("yyyy-MM-dd") : request
				.getParameter("RTIME");
		STIME = STIME + " 00:00:00.000";
		RTIME = RTIME + " 23:59:59.999"; 
		param.put("from_date", STIME);
		param.put("to_date", RTIME);
		param.put("interCpnyID",admin.getCpnyId());
		param.put("person_id",admin.getPersonId());
		String result="Read the success"; //读取成功
		Connection conn = ConnBean.getConn("HAE");
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();
			
			String  sql =   " select P.EmployeeNo, p.FirstName, CR.ReaderName, " +
							" DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) AS LocalDateTime,  " +
							" e.OccuredDateTime as UTCDateTime " +
							" from [WACS].[dbo].[C_PSN_CardHolder] P join [WACS].[dbo].[T_EVENT_Access] E" +
							" on P.PSNID = E.PSNId right JOIN (SELECT DV.LoopID,dv.DeviceID, rd.ReaderID, RD.ReaderName" +
							" FROM T_SYS_Device_DR_RD RD join T_SYS_Device DV on dv.DeviceIDX = rd.DeviceIDX where rd.DeviceIDX in ('2083','2084','2085','2086')) CR " +
							//" FROM [WACS].[dbo].[SA_ACC_CompanyExitReader] AR join T_SYS_Device_DR_RD RD ON ar.ReaderId = rd.ReaderIDX " +
							//" join T_SYS_Device DV on dv.DeviceIDX = rd.DeviceIDX) CR" +
							" ON E.ControllerId = cr.LoopID and E.BoardNo = CR.DeviceID and E.IoIndex = CR.ReaderID" +
							" where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) >= '"+ STIME +"' " +
							" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) <= '"+ RTIME +"' " +
							" order by LocalDateTime ";
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("EMPID", rs.getString(1));
					paramCard.put("CARD_TIME", rs.getString(4));
					paramCard.put("CPNY_ID", admin.getCpnyId());
					int checkOut = rs.getString(3).indexOf("Exit");
					int checkIn = rs.getString(3).indexOf("Entry");
					if (checkIn != -1) {
						paramCard.put("DOOR_TYPE", "IN");
					} else if (checkOut != -1) {
						paramCard.put("DOOR_TYPE", "OUT");
					} else {
						paramCard.put("DOOR_TYPE", "");
					}
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordHAEList");
				arReadCardDao.readMacRecordList(list,"readMacRecordHAEListFromCarkLink");
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");//读取失败
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
		} catch (Exception e) {
			e.printStackTrace();
			result = "Read the fail";
		}
		this.arReadCardDao.updateMacArDateStr();
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public String readMacRecordMealList(HttpServletRequest request) {
		LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap logParam = new LinkedHashMap();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		logParam.put("CPNY_ID", admin.getCpnyId());
		logParam.put("TYPE_NAME", "读取打卡记录");
		logParam.put("REMARK", "读取成功");
		String STIME = "".equals(request.getParameter("STIME")) ? DateUtil.getSysdateStr("yyyy-MM-dd") : request
				.getParameter("STIME");
		String RTIME = "".equals(request.getParameter("RTIME")) ? DateUtil.getSysdateStr("yyyy-MM-dd") : request
				.getParameter("RTIME");
		param.put("START_TIME", STIME);
		param.put("END_TIME", RTIME);
		STIME = STIME + " 00:00:00.000";
		RTIME = RTIME + " 23:59:59.999"; 
		param.put("from_date", STIME);
		param.put("to_date", RTIME);
		param.put("interCpnyID",admin.getCpnyId());
		param.put("person_id",admin.getPersonId());
		String result="Read the success"; //读取成功
		Connection conn = ConnBean.getConn("HAE");
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();
			
			String  sql =   " SELECT  dbo.T_EVENT_Access.ControllerId, dbo.T_EVENT_Access.BoardNo, dbo.[C_PSN_CardHolder].EmployeeNo, dbo.[C_PSN_CardHolder].FirstName, dbo.[C_PSN_CardHolder].MiddleName, dbo.[C_PSN_CardHolder].LastName,"+
							" CONCAT(dbo.[C_PSN_CardHolder].FirstName, ' ', dbo.[C_PSN_CardHolder].MiddleName, ' ', dbo.[C_PSN_CardHolder].LastName ) as EmployeeName,"+
							" dbo.[C_PSN_CardHolder].PSNID as CardholderID, dbo.[C_PSN_Department].DEPID, dbo.[C_PSN_Department].DEPName, [dbo].[T_SYS_Device].DeviceName,"+
							" dbo.T_SYS_Device_DR.DoorName, dbo.T_EVENT_Access.OccuredDateTime,"+
							" DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), dbo.T_EVENT_Access.OccuredDateTime) AS CheckInTime"+
							" FROM dbo.T_EVENT_Access"+
							" INNER JOIN dbo.[C_PSN_CardHolder] ON dbo.T_EVENT_Access.PSNID = dbo.[C_PSN_CardHolder].PSNID"+
							" INNER JOIN dbo.C_PSN_Department ON dbo.C_PSN_CardHolder.DepartmentID = dbo.C_PSN_Department.DEPID "+
							" RIGHT JOIN [dbo].[T_SYS_Device] ON dbo.T_EVENT_Access.BoardNo =  [dbo].[T_SYS_Device].DeviceID "+
							" and dbo.T_EVENT_Access.ControllerId = [dbo].[T_SYS_Device].LoopID"+
							" JOIN [T_SYS_Device_DR]  on [T_SYS_Device].DeviceIDX = [T_SYS_Device_DR].DeviceIDX"+
							" WHERE ((dbo.T_EVENT_Access.ControllerId = 1014  and (dbo.T_EVENT_Access.BoardNo = 0 or dbo.T_EVENT_Access.BoardNo =1 or dbo.T_EVENT_Access.BoardNo =9 or dbo.T_EVENT_Access.BoardNo =10)))"+
							" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), OccuredDateTime) >= '"+ STIME +"' " +
							" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), OccuredDateTime) <= '"+ RTIME +"' " ;
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("DOOR_TYPE", rs.getString(1));
					paramCard.put("CARD_NO", rs.getString(3));
					paramCard.put("FirstName", rs.getString(4));
					paramCard.put("MiddleName", rs.getString(5));
					paramCard.put("LastName", rs.getString(6));
					paramCard.put("EMPLOYEE_NAME", rs.getString(7));
					paramCard.put("REMARK", rs.getString(11));
					paramCard.put("R_TIME", rs.getString(14));
					paramCard.put("CPNY_ID", admin.getCpnyId());
					paramCard.put("EMPID", admin.getEmpID());
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordMealHAEList");
				
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");//读取失败
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
			for (int i = -3; i <=3; i++) {
				param.put("delVal", i);
				arReadCardDao.deleteDuplicateRecord(param,"deleteDuplicateRecordMealList");
			}
			arReadCardDao.inserUpdateWithDate(param, "updateAtendanceDateInMeal");
		} catch (Exception e) {
			e.printStackTrace();
			result = "Read the fail";
		}
		//this.arReadCardDao.updateMacArDateStr();
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public String readMacRecordCompanyList(HttpServletRequest request) {
	
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
	
		String STIME = "".equals(request.getParameter("STIME")) ? DateUtil.getSysdateStr("yyyy-MM-dd") : request.getParameter("STIME");
		String RTIME = "".equals(request.getParameter("RTIME")) ? DateUtil.getSysdateStr("yyyy-MM-dd") : request.getParameter("RTIME");
		STIME = STIME + " 00:00:00.000";
		RTIME = RTIME + " 23:59:59.999"; 
		
		String result = this.readMacRecordDLList(STIME, RTIME, admin.getEmpID());
		return result;
	}

	/**
	 * TSTO打卡数据读取 old
	 */
	@SuppressWarnings("unchecked")
	public String readMacRecordOldList(HttpServletRequest request) {
		LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap logParam = new LinkedHashMap();
		logParam.put("CPNY_ID", "TSTO");
		logParam.put("TYPE_NAME", "读取打卡记录");
		logParam.put("REMARK", "读取成功");
		String STIME = "".equals(request.getParameter("STIME")) ? DateUtil.getSysdateStr("yyyy.MM.dd") : request
				.getParameter("STIME");
		String RTIME = "".equals(request.getParameter("RTIME")) ? DateUtil.getSysdateStr("yyyy.MM.dd") : request
				.getParameter("RTIME");
		param.put("from_date", STIME);
		param.put("to_date", RTIME);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		param.put("interCpnyID",admin.getCpnyId());
		param.put("person_id",admin.getPersonId());
		String result="读取成功";
		
		try {
			File file = new File("\\\\109.112.50.16\\everydata\\old");	
			BufferedReader reader = null;
		
			String tempString = null;
			File files[]=file.listFiles();
			if(files != null && files.length>0){
				for(int j=0;j<files.length;j++){
					List list=new ArrayList();
					File fileNone=files[j];
					String flieName=fileNone.getName();
					if(fileNone.isFile()){//判断是否是个文件，而不是文件夹
						if( fileNone.getAbsolutePath().endsWith(".txt")){//判断此文件是否以.txt结尾
							param.put("FILENAME", flieName.substring(0, flieName.indexOf(".")));
						if( arReadCardDao.ChenkMacRecordList(param) > 0)	{//判断此文件的名称是否是需要读取的文件
							reader = new BufferedReader(new FileReader(fileNone));//读取
							while((tempString = reader.readLine())!=null){//判断此文件是否为空
								String splitStr[]=tempString.split("	"); 
									LinkedHashMap paramCard = new LinkedHashMap();
									try {
										paramCard.put("MACHINE_NO", splitStr[0].trim());
										paramCard.put("MACHINE_TYPE", splitStr[1].trim());
										paramCard.put("ACTIVITY", splitStr[2].trim());
										paramCard.put("RGST_DTIME", splitStr[3].trim());
										paramCard.put("EMPNO", splitStr[4].trim());
										paramCard.put("IN_OUT_DTIME", splitStr[5].trim());
										paramCard.put("ORG_ID", splitStr[6].trim());
										paramCard.put("SUBSD_CD",admin.getCpnyId());
										paramCard.put("CREATED_BY",admin.getPersonId());
										paramCard.put("CREATED_IP",admin.getAdminIP());
									} catch (Exception e) {
										e.printStackTrace();
									}
									list.add(paramCard);
							}
							//插入接口表
							if(list.size()>0){
							int resultCnt=arReadCardDao.insertMacRecordRawList(list);
							/*if(resultCnt>0){
									//把此文件挪走
									FileInputStream input=new FileInputStream("//109.112.50.16/everydata/"+flieName);//可替换为任何路径何和文件名 
									FileOutputStream output=new FileOutputStream("//109.112.50.16/everydata/fromCard/"+flieName);//可替换为任何路径何和文件名 
									
									int in1=input.read();
									while(in1!=-1){
									output.write(in1);
									in1=input.read();
									}
									input.close();
									output.close();
									//读取成功后删除原目录下的此文件
									File fileNow=new File("//109.112.50.16/everydata/"+flieName);
									fileNow.delete();
								}*/
							}
							//}
						}
					  }	
					}
				}
				reader.close();
			} else {
				logParam.put("REMARK", "读取失败");
				logParam.put("ERROR_INFO", "没读取到文件");
				result = "没读取到文件";
			}
		} catch (IOException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "读取失败";
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "读取失败";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "读取失败";
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
		} catch (Exception e) {
			e.printStackTrace();
			result = "读取失败";
		}
		return result;
	}
	
	/*---------------------------------------------------------------------*/
	@Override
	public List getImportExcelTempMacRecordsList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		paramMap.put("PERSON_ID", admin.getPersonId());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		if (UiUtil.getPageNum(request) > 0){
			retrunList = arReadCardDao.getImportExcelTempMacRecordsList(paramMap ,UiUtil.getPageNum(request), UiUtil.getNumPerPage(request)) ;
		}
		else{
			retrunList = arReadCardDao.getImportExcelTempMacRecordsList(paramMap) ;
		}
		return retrunList;
	}

	@Override
	public int getImportExcelTempMacRecordsListCnt(HttpServletRequest request) {
		int retrunInt = 0 ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("PERSON_ID", admin.getPersonId());
		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		retrunInt = arReadCardDao.getImportExcelTempMacRecordsListCnt(paramMap) ;
		return retrunInt ;
	}

	@Override
	public int getImportExcelTempMacRecordsListErrCnt(
			HttpServletRequest request) {
		int retrunInt = 0 ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("PERSON_ID", admin.getPersonId());
		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		retrunInt = arReadCardDao.getImportExcelTempMacRecordsListErrCnt(paramMap) ;
		return retrunInt ;
	}
	
	public String importMacRecordsExcelExcel(HttpServletRequest request){
		String retrunInt = "0" ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request,"seach_") ;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("PERSON_ID", admin.getPersonId());
		if (paramMap != null && paramMap.get("CPNY_ID") == null) {
			paramMap.put("CPNY_ID", admin.getCpnyId());
		}
		retrunInt = arReadCardDao.importMacRecordsExcelExcel(paramMap) ;
		return retrunInt;
	}
	
	@SuppressWarnings("unchecked")
	public String readMacRecordSSTList(HttpServletRequest request) {
		LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap logParam = new LinkedHashMap();
		logParam.put("CPNY_ID", "SST");
		logParam.put("TYPE_NAME", "读取打卡记录");
		logParam.put("REMARK", "读取成功");
		String STIME = "".equals(request.getParameter("STIME")) ? DateUtil.getSysdateStr("yyyy.MM.dd") : request
				.getParameter("STIME");
		String RTIME = "".equals(request.getParameter("RTIME")) ? DateUtil.getSysdateStr("yyyy.MM.dd") : request
				.getParameter("RTIME");
		param.put("from_date", STIME);
		param.put("to_date", RTIME);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		param.put("interCpnyID",admin.getCpnyId());
		param.put("person_id",admin.getPersonId());
		String result="读取成功";

		//循环读取三个库数据
		String[] cardArea = {"SZ","SH"};
		for(int i = 0;i<cardArea.length;i++){
			logParam.put("TYPE_NAME", "读取" + cardArea[i] + "打卡记录");
			logParam.put("REMARK", "读取成功");
			try {
					List list=new ArrayList();
					Connection conn = ConnBean.getConn(cardArea[i]);
					PreparedStatement ps = conn.prepareStatement("select CONVERT(varchar(10),T.EventTime,121) AS IN_OUT_DATE,replace(CONVERT(varchar(10),T.EventTime,108),':','') AS IN_OUT_TIME,CARDNO from T_EVT_Event T WHERE T.EVENTTIME > convert(date,'" + STIME + "') ");
		            ResultSet rs = ps.executeQuery();
		            while (rs.next()) {
						LinkedHashMap paramCard = new LinkedHashMap();
						paramCard.put("MACHINE_NO", "1");
						paramCard.put("MACHINE_TYPE", "2");
						paramCard.put("ACTIVITY", "1");
						paramCard.put("RGST_DTIME", rs.getString(1));
						paramCard.put("EMPNO", rs.getString(3));
						paramCard.put("IN_OUT_DTIME", rs.getString(2));
						paramCard.put("ORG_ID", "2");
						paramCard.put("SUBSD_CD",admin.getCpnyId());
						paramCard.put("CREATED_BY",admin.getPersonId());
						paramCard.put("CREATED_IP",admin.getAdminIP());
						list.add(paramCard);
		            }
					//插入接口表
					if(list != null && list.size()>0){
						arReadCardDao.insertSSTMacRecordRawList(list);
					}
			}catch (RuntimeException e) {
				e.printStackTrace();
				logParam.put("REMARK", "读取失败");
				logParam.put("ERROR_INFO", e.getMessage());
				result = "读取失败";
			} catch (Exception e) {
				e.printStackTrace();
				logParam.put("REMARK", "读取失败");
				logParam.put("ERROR_INFO", e.getMessage());
				result = "读取失败";
			}
			try {
				this.arReadCardDao.addSyLogInfo(logParam);
			} catch (Exception e) {
				e.printStackTrace();
				result = "读取失败";
			}
		}
		this.arReadCardDao.updateMacArDateStr();
		return result;
	}
	
	/**
	 * 读取TSTO打卡数据
	 */
	@SuppressWarnings("unchecked")
	public String readTSTOMacRecordList() {
		LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap logParam = new LinkedHashMap();
		//AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		logParam.put("CPNY_ID", "HAE");
		logParam.put("TYPE_NAME", "读取打卡记录");
		logParam.put("REMARK", "读取成功");
		String STIME =  DateUtil.getSysdateStr("yyyy-MM-dd") ;
		String RTIME =  DateUtil.getSysdateStr("yyyy-MM-dd") ;
		param.put("START_TIME", STIME);
		param.put("END_TIME", RTIME);
		STIME = STIME + " 00:00:00.000";
		RTIME = RTIME + " 23:59:59.999"; 
		param.put("from_date", STIME);
		param.put("to_date", RTIME);
		param.put("interCpnyID","HAE");
		param.put("person_id","auto");
		String result="Read the success"; //读取成功
		Connection conn = ConnBean.getConn("HAE");
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();
			
			String  sql =   " SELECT  dbo.T_EVENT_Access.ControllerId, dbo.T_EVENT_Access.BoardNo, dbo.[C_PSN_CardHolder].EmployeeNo, dbo.[C_PSN_CardHolder].FirstName, dbo.[C_PSN_CardHolder].MiddleName, dbo.[C_PSN_CardHolder].LastName,"+
							" CONCAT(dbo.[C_PSN_CardHolder].FirstName, ' ', dbo.[C_PSN_CardHolder].MiddleName, ' ', dbo.[C_PSN_CardHolder].LastName ) as EmployeeName,"+
							" dbo.[C_PSN_CardHolder].PSNID as CardholderID, dbo.[C_PSN_Department].DEPID, dbo.[C_PSN_Department].DEPName, [dbo].[T_SYS_Device].DeviceName,"+
							" dbo.T_SYS_Device_DR.DoorName, dbo.T_EVENT_Access.OccuredDateTime,"+
							" DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), dbo.T_EVENT_Access.OccuredDateTime) AS CheckInTime"+
							" FROM dbo.T_EVENT_Access"+
							" INNER JOIN dbo.[C_PSN_CardHolder] ON dbo.T_EVENT_Access.PSNID = dbo.[C_PSN_CardHolder].PSNID"+
							" INNER JOIN dbo.C_PSN_Department ON dbo.C_PSN_CardHolder.DepartmentID = dbo.C_PSN_Department.DEPID "+
							" RIGHT JOIN [dbo].[T_SYS_Device] ON dbo.T_EVENT_Access.BoardNo =  [dbo].[T_SYS_Device].DeviceID "+
							" and dbo.T_EVENT_Access.ControllerId = [dbo].[T_SYS_Device].LoopID"+
							" JOIN [T_SYS_Device_DR]  on [T_SYS_Device].DeviceIDX = [T_SYS_Device_DR].DeviceIDX"+
							" WHERE ((dbo.T_EVENT_Access.ControllerId = 1014  and (dbo.T_EVENT_Access.BoardNo = 0 or dbo.T_EVENT_Access.BoardNo =1 or dbo.T_EVENT_Access.BoardNo =9 or dbo.T_EVENT_Access.BoardNo =10)))"+
							" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), OccuredDateTime) >= '"+ STIME +"' " +
							" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), OccuredDateTime) <= '"+ RTIME +"' " ;
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("DOOR_TYPE", rs.getString(1));
					paramCard.put("CARD_NO", rs.getString(3));
					paramCard.put("FirstName", rs.getString(4));
					paramCard.put("MiddleName", rs.getString(5));
					paramCard.put("LastName", rs.getString(6));
					paramCard.put("EMPLOYEE_NAME", rs.getString(7));
					paramCard.put("REMARK", rs.getString(11));
					paramCard.put("R_TIME", rs.getString(14));
					paramCard.put("CPNY_ID", "HAE");
					paramCard.put("EMPID", "auto");
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordMealHAEList");
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");//读取失败
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
			//arReadCardDao.deleteDuplicateRecord(param,"deleteDuplicateRecordMealList");
		} catch (Exception e) {
			e.printStackTrace();
			result = "Read the fail";
		}
		//this.arReadCardDao.updateMacArDateStr();
		return result;
	}
	
	/**
	 * 读取SST打卡数据
	 */
	public String readSSTMacRecordList() {
		LinkedHashMap logParam = new LinkedHashMap();
		logParam.put("CPNY_ID", "SST");
		String result="";

		//循环读取三个库数据
		String[] cardArea = {"SZ","SH"};
		for(int i = 0;i<cardArea.length;i++){
			logParam.put("TYPE_NAME", "读取" + cardArea[i] + "打卡记录");
			logParam.put("REMARK", "读取成功");
			try {
				List list=new ArrayList();
				Connection conn = ConnBean.getConn(cardArea[i]);
				PreparedStatement ps = conn.prepareStatement("select CONVERT(varchar(10),T.EventTime,121) AS IN_OUT_DATE,replace(CONVERT(varchar(10),T.EventTime,108),':','') AS IN_OUT_TIME,CARDNO from T_EVT_Event T WHERE T.EVENTTIME > GETDATE() - 1");
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("MACHINE_NO", "1");
					paramCard.put("MACHINE_TYPE", "2");
					paramCard.put("ACTIVITY", "1");
					paramCard.put("RGST_DTIME", rs.getString(1));
					paramCard.put("EMPNO", rs.getString(3));
					paramCard.put("IN_OUT_DTIME", rs.getString(2));
					paramCard.put("ORG_ID", "2");
					paramCard.put("SUBSD_CD", "SST");
					paramCard.put("CREATED_BY", "");
					paramCard.put("CREATED_IP", "" );
					list.add(paramCard);
	            }
				//插入接口表
				if(list != null && list.size()>0){
					arReadCardDao.insertSSTMacRecordRawList(list);
				}
			}catch (RuntimeException e) {
				e.printStackTrace();
				logParam.put("REMARK", "读取失败");
				logParam.put("ERROR_INFO", e.getMessage());
				result = "0";
			} catch (Exception e) {
				e.printStackTrace();
				logParam.put("REMARK", "读取失败");
				logParam.put("ERROR_INFO", e.getMessage());
				result = "0";
			}
			try {
				this.arReadCardDao.addSyLogInfo(logParam);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		this.arReadCardDao.updateMacArDateStr();
		return result;
	}
	
	/**
	 * 判断是不是当天的打卡信息TSTO
	 * @param FILENAME
	 * @return
	 */
	private int ChenkMacRecordList(String FILENAME){
		int returnInt=0;
		 try {
			 if(DateUtil.getSysdateStr("yyyyMMdd").equals(FILENAME)){
				 returnInt=1;
			 }
		} catch (Exception e) {
			returnInt=0;
		}
		return returnInt;
	}

	
	/**
	 * 定时任务取卡
	 */
	public String readMacRecordBJList(String cpnyId) {
		LinkedHashMap logParam = new LinkedHashMap();
		logParam.put("CPNY_ID", cpnyId);
		String result="";

		//循环读取三个库数据
		logParam.put("TYPE_NAME", cpnyId + " 打卡记录");
		logParam.put("REMARK", "读取成功");
		Connection conn = ConnBean.getConn(cpnyId);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();
			/*String  sql =   " SELECT A.BADGENUMBER, DATE_FORMAT(B.CHECKTIME, '%Y-%m-%d %H:%i:%s') " +
							" FROM USERINFO A, CHECKINOUT B " +
							" WHERE A.USERID = B.USERID " +
							" AND B.CHECKTIME > DATE_SUB(CURDATE(), INTERVAL 3 DAY) ";*/
			
			String  sql =   " select P.EmployeeNo, p.FirstName, CR.ReaderName, " +
							" DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) AS LocalDateTime,  " +
							" e.OccuredDateTime as UTCDateTime " +
							" from [WACS].[dbo].[C_PSN_CardHolder] P join [WACS].[dbo].[T_EVENT_Access] E" +
							" on P.PSNID = E.PSNId right JOIN (SELECT DV.LoopID,dv.DeviceID, rd.ReaderID, RD.ReaderName" +
							" FROM T_SYS_Device_DR_RD RD join T_SYS_Device DV on dv.DeviceIDX = rd.DeviceIDX where rd.DeviceIDX in ('2083','2084','2085','2086')) CR " +
							//" FROM [WACS].[dbo].[SA_ACC_CompanyExitReader] AR join T_SYS_Device_DR_RD RD ON ar.ReaderId = rd.ReaderIDX " +
							//" join T_SYS_Device DV on dv.DeviceIDX = rd.DeviceIDX) CR" +
							" ON E.ControllerId = cr.LoopID and E.BoardNo = CR.DeviceID and E.IoIndex = CR.ReaderID" +
							" where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) >= (convert(varchar(10),DATEADD(day,-1,getdate()),120)+' 00:00:00.000') " +
							" order by LocalDateTime ";
			
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("EMPID", rs.getString(1));
					paramCard.put("CARD_TIME", rs.getString(4));
					paramCard.put("CPNY_ID", cpnyId);
					int checkOut = rs.getString(3).indexOf("Exit");
					int checkIn = rs.getString(3).indexOf("Entry");
					if (checkIn != -1) {
						paramCard.put("DOOR_TYPE", "IN");
					} else if (checkOut != -1) {
						paramCard.put("DOOR_TYPE", "OUT");
					} else {
						paramCard.put("DOOR_TYPE", "");
					}
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordHAEList");
				arReadCardDao.readMacRecordList(list,"readMacRecordHAEListFromCarkLink");
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "0";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "0";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.arReadCardDao.updateMacArDateStr();
		return result;
	}

	/**
	 * 读取DL打卡数据
	 */
	public String readMacRecordDLList(String cpnyId) {
		LinkedHashMap logParam = new LinkedHashMap();
		logParam.put("CPNY_ID", cpnyId);
		String result="";

		//循环读取三个库数据
		logParam.put("TYPE_NAME", cpnyId + " 打卡记录");
		logParam.put("REMARK", "读取成功");
		Connection conn = ConnBean.getConn(cpnyId);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();
			String  sql =   " SELECT replace(ltrim(replace(B.PIN,'0',' ')),' ','0') PIN, CONVERT(varchar(100), B.CHECKTIME, 20) " +
							" FROM CHECKINOUT B " +
							" WHERE B.CHECKTIME > getdate() - 4 ";
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("EMPID", rs.getString(1));
					paramCard.put("CARD_TIME", rs.getString(2));
					paramCard.put("CPNY_ID", cpnyId);
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordDLList");
			}
			
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "0";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "0";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.arReadCardDao.updateMacArDateStr();
		return result;
	}

	@SuppressWarnings("unchecked")
	public String readMacRecordDLList(String STIME, String RTIME, String admin) {
		LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap logParam = new LinkedHashMap();
		//AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		logParam.put("CPNY_ID", "HAE");
		logParam.put("TYPE_NAME", "读取打卡记录");
		logParam.put("REMARK", "读取成功");
		param.put("interCpnyID", "HAE");
		param.put("person_id", admin);
		String result="Read the success"; //读取成功
		Connection conn = ConnBean.getConn("HAE");
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();
			
			String  sql =   " select P.EmployeeNo, CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName ) as EmployeeName,  CR.ReaderName, " +
					" DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) AS LocalDateTime,  " +
					" e.OccuredDateTime as UTCDateTime " +
					" from [WACS].[dbo].[C_PSN_CardHolder] P join [WACS].[dbo].[T_EVENT_Access] E" +
					" on P.PSNID = E.PSNId right JOIN (SELECT DV.LoopID,dv.DeviceID, rd.ReaderID, RD.ReaderName" +
					" FROM T_SYS_Device_DR_RD RD join T_SYS_Device DV on dv.DeviceIDX = rd.DeviceIDX where rd.DeviceIDX in ('2083','2084','2085','2086')) CR " +
					//" FROM [WACS].[dbo].[SA_ACC_CompanyExitReader] AR join T_SYS_Device_DR_RD RD ON ar.ReaderId = rd.ReaderIDX " +
					//" join T_SYS_Device DV on dv.DeviceIDX = rd.DeviceIDX) CR" +
					" ON E.ControllerId = cr.LoopID and E.BoardNo = CR.DeviceID and E.IoIndex = CR.ReaderID" +
					" where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) >= '"+ STIME +"' " +
					" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), E.OccuredDateTime) <= '"+ RTIME +"' " +
					" order by LocalDateTime ";
			
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("CARD_NO", rs.getString(1));
					paramCard.put("R_TIME", rs.getString(4));
					paramCard.put("CPNY_ID", "HAE");
					paramCard.put("DEVICENAME", rs.getString(3));
					paramCard.put("EMPLOYEE_NAME", rs.getString(2));
					paramCard.put("EMPID", admin);
					int checkOut = rs.getString(3).indexOf("Exit");
					int checkIn = rs.getString(3).indexOf("Entry");
					if (checkIn != -1) {
						paramCard.put("DOOR_TYPE", "IN");
					} else if (checkOut != -1) {
						paramCard.put("DOOR_TYPE", "OUT");
					} else {
						paramCard.put("DOOR_TYPE", "");
					}
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordCompanyList");
				//arReadCardDao.deleteDuplicateRecord(list,"deleteDuplicateRecordCompanyList");
			}
			
			List list2 = new ArrayList();
			String sql2 = "SELECT dbo.T_EVENT_Access.ControllerId, dbo.T_EVENT_Access.BoardNo, dbo.[C_PSN_CardHolder].EmployeeNo, dbo.[C_PSN_CardHolder].LastName, " +
					" CONCAT(dbo.[C_PSN_CardHolder].FirstName,  ' ',  dbo.[C_PSN_CardHolder].MiddleName,  ' ', dbo.[C_PSN_CardHolder].LastName ) as EmployeeName, dbo.[C_PSN_CardHolder].PSNID as CardholderID, " +
					" dbo.[C_PSN_Department].DEPID, dbo.[C_PSN_Department].DEPName, [dbo].[T_SYS_Device].DeviceName, dbo.T_SYS_Device_DR.DoorName, " +
					" dbo.T_EVENT_Access.OccuredDateTime, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), dbo.T_EVENT_Access.OccuredDateTime) AS CheckInTime " +
					" FROM dbo.T_EVENT_Access  " +
					" INNER JOIN dbo.[C_PSN_CardHolder] ON dbo.T_EVENT_Access.PSNID = dbo.[C_PSN_CardHolder].PSNID  " +
					" INNER JOIN dbo.C_PSN_Department ON dbo.C_PSN_CardHolder.DepartmentID = dbo.C_PSN_Department.DEPID  " +
					" RIGHT JOIN [dbo].[T_SYS_Device] ON dbo.T_EVENT_Access.BoardNo = [dbo].[T_SYS_Device].DeviceID  " +
					" and dbo.T_EVENT_Access.ControllerId = [dbo].[T_SYS_Device].LoopID  " +
					" JOIN [T_SYS_Device_DR] on [T_SYS_Device].DeviceIDX = [T_SYS_Device_DR].DeviceIDX  " +
					" WHERE (dbo.T_EVENT_Access.ControllerId = 8 and (dbo.T_EVENT_Access.BoardNo = 5 )) " +
					" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), OccuredDateTime) >= ' "+STIME+" '  " +
					" and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), OccuredDateTime) <= ' "+RTIME+" ' ";
			
			ps = conn.prepareStatement(sql2);
			rs = ps.executeQuery();
			while (rs.next()) {
				LinkedHashMap cardMap = new LinkedHashMap();
				cardMap.put("CARD_NO", rs.getString(3));
				cardMap.put("R_TIME", rs.getString(12));
				cardMap.put("CPNY_ID", "HAE");
				cardMap.put("DEVICENAME", rs.getString(6));
				cardMap.put("EMPLOYEE_NAME", rs.getString(5));
				cardMap.put("EMPID", admin);
				cardMap.put("DOOR_TYPE", rs.getString(10));
				
				list2.add(cardMap);
        }
		//插入接口表
		if(list2 != null && list2.size()>0){
			arReadCardDao.readMacRecordList(list2,"readMacRecordCompanyList");
		}
			
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");//读取失败
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "Read the fail";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
			//arReadCardDao.deleteDuplicateRecord(param,"deleteDuplicateRecordCompanyList");
		} catch (Exception e) {
			e.printStackTrace();
			result = "Read the fail";
		}
		return result;
	}

	/**
	 * 读取HZ打卡数据
	 */
	public String readMacRecordHZList(String cpnyId) {
		LinkedHashMap logParam = new LinkedHashMap();
		logParam.put("CPNY_ID", cpnyId);
		String result="";

		//循环读取三个库数据
		logParam.put("TYPE_NAME", cpnyId + " 打卡记录");
		logParam.put("REMARK", "读取成功");

		Connection conn = ConnBean.getConn(cpnyId);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();
			
			String  sql =   " SELECT A.JOB_NUMBER, CONVERT(VARCHAR(100), B.CHECKTIME, 20) " +
							" FROM USERINFO A, CHECKINOUT B " +
							" WHERE A.BADGENUMBER = B.PIN " +
							" AND B.CHECKTIME > getdate() - 3 ";
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("EMPID", rs.getString(1));
					paramCard.put("CARD_TIME", rs.getString(2));
					paramCard.put("CPNY_ID", cpnyId);
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordHZList");
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "0";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "0";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.arReadCardDao.updateMacArDateStr();
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public String readMacRecordHZList(HttpServletRequest request) {
		LinkedHashMap param = new LinkedHashMap();
		LinkedHashMap logParam = new LinkedHashMap();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		logParam.put("CPNY_ID", admin.getCpnyId());
		logParam.put("TYPE_NAME", "读取打卡记录");
		logParam.put("REMARK", "读取成功");
		String STIME = "".equals(request.getParameter("STIME")) ? DateUtil.getSysdateStr("yyyy.MM.dd") : request
				.getParameter("STIME");
		String RTIME = "".equals(request.getParameter("RTIME")) ? DateUtil.getSysdateStr("yyyy.MM.dd") : request
				.getParameter("RTIME");
		String EMPID = StringUtil.checkNull(request.getParameter("EMPID"));
		param.put("from_date", STIME);
		param.put("to_date", RTIME);
		param.put("interCpnyID",admin.getCpnyId());
		param.put("person_id",admin.getPersonId());
		String result="读取成功";

		Connection conn = ConnBean.getConn(admin.getCpnyId());
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List list=new ArrayList();

			String  sql =   " SELECT A.JOB_NUMBER, CONVERT(VARCHAR(100), B.CHECKTIME, 20) " +
							" FROM USERINFO A, CHECKINOUT B " +
							" WHERE A.BADGENUMBER = B.PIN " +
							" AND B.CHECKTIME >= convert(datetime,'" + STIME + "') " + 
							" AND B.CHECKTIME <= convert(datetime,'" + RTIME + "') + 1 ";
			if(!"".equals(EMPID)){
				sql =   " SELECT ltrim(rtrim(A.JOB_NUMBER )), CONVERT(VARCHAR(100), B.CHECKTIME, 20) " +
						" FROM USERINFO A, CHECKINOUT B " +
						" WHERE A.BADGENUMBER = B.PIN " +
						" AND B.CHECKTIME >= convert(datetime,'" + STIME + "') " + 
						" AND B.CHECKTIME <= convert(datetime,'" + RTIME + "') + 1 " + 
						" AND ltrim(rtrim(A.JOB_NUMBER )) = '" + EMPID + "' ";
			}
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
					LinkedHashMap paramCard = new LinkedHashMap();
					paramCard.put("EMPID", rs.getString(1));
					paramCard.put("CARD_TIME", rs.getString(2));
					paramCard.put("CPNY_ID", admin.getCpnyId());
					list.add(paramCard);
	        }
			//插入接口表
			if(list != null && list.size()>0){
				arReadCardDao.readMacRecordList(list,"readMacRecordHZList");
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "读取失败";
		} catch (Exception e) {
			e.printStackTrace();
			logParam.put("REMARK", "读取失败");
			logParam.put("ERROR_INFO", e.getMessage());
			result = "读取失败";
		}finally{
			ConnBean.close(rs, null, ps, conn);
		}
		try {
			this.arReadCardDao.addSyLogInfo(logParam);
		} catch (Exception e) {
			e.printStackTrace();
			result = "读取失败";
		}
		this.arReadCardDao.updateMacArDateStr();
		return result;
	}
}
		

