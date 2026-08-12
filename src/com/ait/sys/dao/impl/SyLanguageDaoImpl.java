package com.ait.sys.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.ait.sys.bean.AdminBean;
import com.ait.sys.dao.SyLanguageDao;
import com.ait.web.util.SessionUtil;
import com.ait.web.util.SqlMapClientSupport;
import com.ait.web.util.StringUtil;

/**
 * Copyright:   LDCC
 * Company:     LDCC
 * @fileName: SyLanguageDaoImpl.java
 * @Description:
 * @Create date: 2012-1-6 下午02:44:48
 * @Create by: jiahc(jiahongchang@ait.net.cn)
 * @version 5.1
 */
@Repository
public class SyLanguageDaoImpl extends SqlMapClientSupport implements
		SyLanguageDao {

	/**
	 * 取得国际化语言
	 * @param 
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	public List getSyLanguageListByActivity() {
		List temp = new ArrayList();
		try {
			temp = this
					.queryForList("sys.language.getSyLanguageListByActivity");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return temp;
	}
	
	/**
	 * 取得国际化语言信息
	 * @param 
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	public List getSyLanguageNameListByActivity(Object object) {
		List temp = new ArrayList();
		try {
			temp = this.queryForList(
					"sys.language.getSyLanguageNameListByActivity", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return temp;
	}
	
	/**
	 * 取得全局SEQ
	 * @param request
	 * @return
	 */
	public String getSyGlobalNameNo() {

		String globalNo = "";

		try {
			globalNo = this.queryForObject("sys.language.getSyGlobalNameNo")
					.toString();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return globalNo;
	}

	/**
	 * 插入国际化信息
	 * @param Object
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void insertSyGlobalName(Object obj) throws Exception {
        boolean zhFlag = true;
        String no = "";
        String zhContent = "";
        String zhCreateBy = "";
		List languageList = new ArrayList();
		languageList = this.getSyLanguageListByActivity();
		List paramList = new ArrayList();
		for (int i = 0; i < languageList.size(); i++) {
			LinkedHashMap languageMap = new LinkedHashMap();
			languageMap = (LinkedHashMap) languageList.get(i);
			no = StringUtil.checkNull(((LinkedHashMap) obj).get("NO"));
			String created_by = StringUtil.checkNull(((LinkedHashMap) obj).get("CREATED_BY"));
			String language = StringUtil.checkNull(languageMap.get("LANGUAGE"));
			String content = StringUtil.checkNull(((LinkedHashMap) obj)
					.get("proName_" + languageMap.get("LANGUAGE")));
			//如果国外系统  没有添加中文,默认添加标识
			if("vi".equals(languageMap.get("LANGUAGE"))){
				zhContent = StringUtil.checkNull(((LinkedHashMap) obj).get("proName_" + languageMap.get("LANGUAGE")));
				zhCreateBy = StringUtil.checkNull(((LinkedHashMap) obj).get("CREATED_BY"));
			}
			if("zh".equals(language)){
				zhFlag = false;
			} 
			if (no.equals("") || language.equals("") || content.equals("")) {
				continue;
			} else {
				LinkedHashMap paramMap = new LinkedHashMap();
				paramMap.put("NO", no);
				paramMap.put("LANGUAGE", language);
				paramMap.put("CONTENT", content);
				paramMap.put("CREATED_BY", created_by);
				paramList.add(paramMap);
			}
		}
		//如果页面没有添加中文,则默认添加越南语字段为中文
		if(zhFlag){
			LinkedHashMap paramMap = new LinkedHashMap();
			paramMap.put("NO", no);
			paramMap.put("LANGUAGE", "zh");
			paramMap.put("CONTENT", zhContent);
			paramMap.put("CREATED_BY", zhCreateBy);
			paramList.add(paramMap);
		}
		
		this.insertForList("sys.language.insertSyGlobalName", paramList);
	}
	
	/**
	 * 删除国际化信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public void deleteSyGlobalName(Object obj) throws Exception {

		this.delete("sys.language.deleteSyGlobalName", obj);
		
	}
	
	/**
	 * 更新国际化信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Object saveSyGlobalName(Object obj) throws Exception {

		String no = "";

		no = this.getSyGlobalNameNo();

		// 保存SY_GLOBAL_NAME表NO字段
		((LinkedHashMap) obj).put("NO", no);

		this.deleteSyGlobalName(obj);

		this.insertSyGlobalName(obj);

		return obj;
	}

	/**
	 * 更新国际化信息
	 * @param Object
	 * @return
	 * @throws Exception
	 */
	public void updateSyGlobalName(Object obj) throws Exception {

		this.deleteSyGlobalName(obj);

		this.insertSyGlobalName(obj);
		
	}
}
