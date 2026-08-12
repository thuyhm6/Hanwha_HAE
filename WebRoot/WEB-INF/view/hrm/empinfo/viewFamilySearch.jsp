<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
$(function() {
	var aa = $("#localname").val();
	var bb = $("#localempid").val();
	var cc = $("#localpostgradenoname").val();
	var dd = $("#localpostgradeotherinf").val();
	var ff = $("#localcenter").val();
	var gg = $("#localempofficename").val();
	if (gg != "" && typeof (gg) != "undefined") {
		$('#titlenameFAMILY').html(
				aa + " / " + bb + " / " + cc + "(" + dd + ") / " + ff + " / "
						+ gg);
	}

	var dataSearch = '${dataSearch}';
	if ('${lowerDepart}' == 'Y') {
		$('#lowerDepart_' + dataSearch).attr('checked', 'checked');
		$('#lowerDepart_' + dataSearch).attr('value', 'Y');
	}
	if ('${MAIN_LIAISON_OFFICE}' == 'Y') {
		$('#mainLianluo').attr('checked', 'checked');
	}
	if ('${FINAL_DEGREE_WHETHER}' == 'Y') {
		$('#FINAL_DEGREE_WHETHER').attr('value', 'Y');
		$('#FINAL_DEGREE_WHETHER').attr('checked', 'checked');
	}
});
/* function fangdajingFAMILY(flag) {
	var name = encodeURI(encodeURI($('#seach_KEYFAMILY').val()));
	var dataSearch = $('#beginSearch').val();
	$('#fangdaFAMILY')
			.attr(
					'href',
					'/hrm/empinfo/viewEmpInfoListTanchu?dataSearch='
							+ dataSearch
							+ '&pageNum=1&firstFlag=N&searchChange=familySearch&seach_KEY='
							+ name);
	if (flag == 'onkeyup')
		$('#fangdaFAMILY').click();
} */

function chaxunFAMILY(aa) {
	$('#viewFamilySearch').submit();
}
function chooseLowerFAMILY(aa) {
	var che = $('#lowerDepart_' + aa).prop('checked');
	if (che == true) {
		$('#lowerDepart_' + aa).attr('value', 'Y');
	} else {
		$('#lowerDepart_' + aa).attr('value', 'N');
	}
}
function shanchuFAMILY() {
	$('#titlenameFAMILY').html('');
	$('#PERSON_IDFAMILY').attr('value', '');
	$('#LOCAL_TITLEFAMILY').attr('value', '');
}



$("#hr3603_table",navTab.getCurrentPanel()).dataTable({"bPaginate": true,    //分页
    "bAutoWidth":false,//表格宽度自动变化
    "bProcessing":true,
    "lengthMenu": [[50,80,100,200,500,1000], [50,80,100,200,500,1000]],
	"bLengthChange": true,  //按多少条记录显示下拉框
	"iDisplayLength": 50, //默认每页显示的记录数
	"bFilter": true,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
 	"searching": true,//本地搜索
	"bSort": true,   //排序功能
	"bInfo": true,   //显示datatables的信息（底部的页数，条目数信息）
	"bScrollInfinite":true,
     "orderClasses": false,
     "order":[],//初始化不用自动排序
     "scrollY": $(document.body).height() - 390,
     "scrollX": true,
     "scrollCollapse": false,
     "deferRender":true,
     //"scroller":true,
    "oLanguage": {//多语言配置
		"sProcessing": "<spring:message code='hem.alert.empinfo.Is_loading' />",//正在加载中......
		"sZeroRecords": "<spring:message code='hem.alert.empinfo.not_find_relevant_data' />",//查询不到相关数据！
		"sEmptyTable": "<spring:message code='hrm.alert.empinfo.No_data_in_table' />",//表中无数据存在！
	 	"sSearch": "<spring:message code='hrm.alert.contractInfo.Rapid_screening' />",//快速筛选
		"sLengthMenu": "<spring:message code='hrm.alert.contractInfo.Record_page' />",//每页 _MENU_ 条记录
		"sInfo": "<spring:message code='hrm.alert.contractInfo.START_END_TOTAL' />",//从 _START_ 到 _END_ /共 _TOTAL_ 条数据
		"sInfoFiltered": "(<spring:message code='hrm.alert.contractInfo.Record_filter' />)",//从 _MAX_ 条记录过滤
		"oPaginate": {
   	 		"sPrevious": "<spring:message code='hrm.alert.contractInfo.Previous_page' />",//上一页
    		"sNext": "<spring:message code='hrm.alert.contractInfo.NEXT_PAGE' />"//下一页
        }
    },
    "sDom":'<"top"r<"clear">fBl>t<"bottom"ip<"clear">>',
    "buttons": [
          ] 
});

function changeFAMILYINFOR(no, status, id, aid) {
	var idvalue = $('#' + id).val();
	var idhref = '/hrm/empinfo/searchTanchu?PARENT_CODE_NO=' + no
			+ '&firstFlag=N&status=' + status + '&nameid=' + id
			+ '&typeFlag=Y&idvalue=' + idvalue;
	$('#' + aid).attr('href', idhref);

}
function changeZhijiFAMILYINFOR(status, id, aid) {
	var idvalue = $('#' + id).val();
	var parentnoFAMILYINFOR = $('#POST_FAMILY_FAMILYINFOR').val();
	var idhref = '/hrm/empinfo/searchTanchu?PARENT_CODE_NO='
			+ parentnoFAMILYINFOR + '&firstFlag=N&status=' + status
			+ '&nameid=' + id + '&typeFlag=Y&idvalue=' + idvalue;
	$('#' + aid).attr('href', idhref);
}

function deleteFamilyInfoView() {
	var FAMILY_NO="";
	var flag=false;
	$("input[name='ACTIVITY']",navTab.getCurrentPanel()).each(function(){
		if($(this).attr("checked") == "checked"){
			FAMILY_NO = FAMILY_NO  + $(this).val() + ",";
			flag = true;
		}
	});
	FAMILY_NO = FAMILY_NO + "";
	if(flag == false){
		alertMsg.error("<spring:message code="hrm.alert.empinfo.Choice_Perform_operation" />");//请先选择要执行此操作
		return false;
	}
	alertMsg.confirm("<spring:message code="hrm.alert.empinfo.Sure.delete" />",//确定要执行此操作吗？
  		  	{okCall:function(){
		  	$.ajax({
  				type:'POST',
  				url:'/hrm/empinfo/deleteFamilyInfoView',
  				data:{FAMILY_NO:FAMILY_NO,isEssSystem:2},
  				dataType:"json",
  				cache: false,
  				success: navTabAjaxDoneWithForm,
  				error: DWZ.ajaxError
  			});
  	}});
	return false;
}
</script>
<form id="viewFamilySearch" method="post" action="/hrm/empinfo/viewFamilySearch" class="pageForm required-validate" onsubmit="return navTabSearch(this);">
		
		<input type="hidden" id="PERSON_IDFAMILY" name="PERSON_ID"
				value="${PERSON_ID }">
			<input type="hidden" id="LOCAL_TITLEFAMILY" name="LOCAL_TITLE"
				value="${LOCAL_TITLE }">
			<input type="hidden" id="dataSearch" name="dataSearch" value="family">
			<input type="hidden" id="FLAG" name="FLAG" value="1">
<!-- <div class="pageContent"
	style="width: 92%; margin-left: auto; margin-right: auto;">
 --><div class="pageHeader">
<div class="searchBar" >
	<table class="searchContent">

		<tr>
			<td><!-- 社号/姓名 --><spring:message code="hrm.empinfo.nameAndEmpid"/></td>
			<td>
				<div style="float: left"><input type="text" name="KEY" id="KEY" value="${KEY}"/></div>
				<%--	onkeydown="javascript:if(event.keyCode == 13)fangdajingFAMILY('onkeyup');" /></div>
			 <div style="float: left"><a class="btnLook" id="fangdaFAMILY" onclick="fangdajingFAMILY('1')"
					href="/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=familySearch"
					lookupGroup="person"> </a></div>
				<span style="margin-left: 20px;" id="titlenameFAMILY">${LOCAL_TITLE}</span> --%>
			</td>
			<td>
				<spring:message code ="pa.viewPaEmpAccount.SHUIHAO.b" /> (<spring:message code="pa.viewResultConfirmSonList.TESHUKOUSHUIRENSHU.b" />)<!-- 税法 -->
			</td>
			<td >
					<input type="type" name="FAM_TAX_CODE" id="FAM_TAX_CODE"  value="${FAM_TAX_CODE }">
				</td>
				<td>
				<spring:message code ="rp.report.title.idcardorpassport" /><!-- 护照号码 -->
			</td>
			<td >
					<input type="type" name="FAM_IDCARD" id="FAM_IDCARD"  value="${FAM_IDCARD }">
				</td>
                <td>
					<spring:message code="hrm.empinfo.FAM_TYPE_CODE_NAME" /><!--关系-->
				</td>
				<td  style="padding-top: 3px">
					<ait:SelectSyCodeByCpnyID name="FAM_TYPE_CODE" id="FAM_TYPE_CODE"
                                 parentNo="950" cnpyID="${defaultCpny}" selected="${FAM_TYPE_CODE}" limit="all"/>
					
					<%-- <ait:selectCodeMulti id="seach_FAM_TYPE_CODE_Multi" name="seach_FAM_TYPE_CODE_NAME" parentNo="950"
							selected="${FAM_TYPE_CODE_Multi}" selectedNm="${FAM_TYPE_CODE_NAME}" /> --%>
				</td>
			<%-- <td >
					<spring:message code="pa.viewResultConfirmSonList.TESHUKOUSHUIRENSHU.b" /><!--员工类型--> 
				</td> --%>
				<%-- <td>
						<select id="DEP_PERSON_NO" name="DEP_PERSON_NO" >
							
							<option value="1" ><!--Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
							<option value="0" ><!-- No --> <spring:message code="ar.viewcycle.content.no" /></option>
						</select>
					</td> --%>
				
			<td  >
					<spring:message code="hrm.empinfo.family_name" /><!--姓名-->
				</td>
				<td >
					<input type="type" name="FAM_NAME" id="FAM_NAME"  value="${FAM_NAME }">
				</td>
				
				
				<td><!-- 加班上限 --> <spring:message code="pa.viewResultConfirmSonList.TESHUKOUSHUIRENSHU.b" /></td>
					<td>
						<select id="DEP_PERSON_NO" name="DEP_PERSON_NO" >
							<option value="" ><!-- 全部 --> <spring:message code="pa.salary.canShu.quanBu" /></option>
							<option value="1"  <c:if test="${DEP_PERSON_NO eq '1' }">selected</c:if>><!--Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
							<option value="0"  <c:if test="${DEP_PERSON_NO eq '0' }">selected</c:if>><!-- No --> <spring:message code="ar.viewcycle.content.no" /></option>
						</select>
					</td>
		</tr>
			
			
			
		
	</table>
	<input type="hidden" id="localname" value="${personinfo.LOCAL_NAME }">
	<input type="hidden" id="localempid" value="${personinfo.EMPID }">
	<input type="hidden" id="localpostgradenoname"
		value="${personinfo.POST_GRADE_NO_NAME_TITLE }">
	<input type="hidden" id="localpostgradeotherinf"
		value="${personinfo.POST_GRADE_OTHERINF }">
	<input type="hidden" id="localcenter"
		value="${personinfo.COST_CENTER_TITLE }">
	<input type="hidden" id="localempofficename"
		value="${personinfo.EMP_OFFICE_NAME_TITLE }">
	<input type="hidden" id="beginSearch" value="family">
</div>
</div>
<!-- 家庭搜索 -->
<div id="family" style="width: 99%;margin-left:auto;margin-right:auto;"
	>
	
		<div class="formBar">

			<ul class="toolBar">
				<li>
					<a class="buttonActive" onclick="chaxunFAMILY('family')" href="#">
					<span><spring:message code="button.search" /><!--查询--></span>
					</a>
				</li>
				<li>
				<a class="buttonActive" href="/pa/excelExport/downloadExcelTemplateHMTC?file=Family_Person_add">
					<span><spring:message code="ar.addempshift.title.downloadmodule" /><!-- 下载导入模板 --></span>
				</a>
				</li>
				<li>
					<a class="add" href="/pa/excelImport/importExcelData?importFunName=/importviewFamilyTemp&REGISTER_SEQ=${SEQ}" target="dialog" mask="true">
						<span><spring:message code="ar.addempshift.title.excelimport" /><!-- EXCEL导入 --></span>
					</a>
				</li>
				<li><a class="buttonActive" href="#" onclick="deleteFamilyInfoView()"> <span><spring:message code="button.delete"/><!--删除--></span></a></li>
				<li>
					<a class="buttonActive" href="/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=47">
						<span><spring:message code="hrm.empinfo.EXPORT" /><!--导出到EXECL--></span>
					</a>
				</li>
			</ul>
		</div>
		<table class="orderList" id="hr3603_table" width="1901px" cellpadding="2" cellspacing="1">
			<thead>
				<tr>
					<th rowspan="3"> NO.</th>
					<th rowspan="3"><input type="checkbox" class="checkboxCtrl" group="ACTIVITY"/><!--已处理--></th>
					<th rowspan="3"><spring:message code="inct.salesman.empNo"/><!-- 工号  --></th>
					<th rowspan="3"><spring:message code="hrm.empinfo.empname"/><!-- 员工姓名 --></th>
					<th rowspan="3"><spring:message code="pa.viewPaEmpAccount.SHUIHAO.b" /><!-- mã số thuế --></th>
					<th rowspan="3"><spring:message code="hrm.empinfo.family_name" /></th>
					<th rowspan="3"><spring:message code="ess.empInfo.relationship" /><!-- quan hệ  --></th>
					<th rowspan="3"><spring:message code="pa.viewResultConfirmSonList.TESHUKOUSHUIRENSHU.b" /> </th><!-- Người phụ thuộc -->
					<th rowspan="3"><spring:message code="ess.empInfo.birth" /><!-- Ngày sinh --></th>
					<%-- <th rowspan="3"><spring:message code="hr.viewCondSql.title.YUANGONGNIANLING" /><!-- Độ tuổi --></th> --%>
					<th rowspan="3"><spring:message code="pa.viewPaEmpAccount.SHUIHAO.b" /> (<spring:message code="pa.viewResultConfirmSonList.TESHUKOUSHUIRENSHU.b" />)<!-- Mã số thuế --></th>
					<th rowspan="3"><spring:message code="ess.empInfo.nationality" /><!-- Quốc tịch --></th>
					<th rowspan="3"><spring:message code="rp.report.title.idcardorpassport" /><!-- Số định danh --></th>
					<th colspan="6"><spring:message code="hrm.empinfo.birth_certificate_info" /><!-- thông tin giấy khai sinh --> </th>
					<th rowspan="2" colspan="2"><spring:message code="pa.viewResultConfirmSonList.deduction_info" /><!-- thông tin giảm trừ  --></th>
					<th rowspan="3"><spring:message code="org.title.REMARK" /><!-- Ghi chú --></th>
				</tr>
				<tr>
					<th rowspan="2"><spring:message code="hrm.empinfo.shieldingGoods.Number" /><!-- số  --></th>
					<th rowspan="2"><spring:message code="hrm.empinfo.book_no" /><!-- quyển số --></th>
					<th colspan="4"><spring:message code="hrm.empinfo.registration_place" /><!-- Nơi đăng ký --></th>
				</tr>
				<tr>
					<th ><spring:message code="hr.viewGoAbroad.title.COUNTRY_NAME" /><!-- quốc gia   --></th>
					<th ><spring:message code="pa.salary.canShu.shengFen" />/<spring:message code="empsubject.cityName" /></th>
					<th ><spring:message code="hrm.empinfo.county" /> <!-- quận huyện --></th>
					<th ><spring:message code="hrm.empinfo.ward" /><!-- Phường/xã --></th>
					<th ><spring:message code="ar.excelexport.title.armonthfrom" /><!-- từ tháng -->  </th>
					<th ><spring:message code="ar.excelexport.title.armonthto" /><!-- đến tháng --></th>
				</tr>
				
			</thead>
			<c:forEach items="${viewFamilySearch }" var="a" varStatus="i">
				<tr>
					<td class="td_type">${i.count }</td>
					<td class='td_type'>
						<input type="checkbox" name="ACTIVITY" value="${a.FAMILY_NO}"/>
						<input type="hidden" id="FAMILY_NO_${i.index}" value="${a.FAMILY_NO}"/>
						<input type="hidden" id="PERSON_ID_${i.index}" value="${a.PERSON_ID}"/>
					</td>
					<td class="td_type">${a.EMPID }</td>
					<td style="text-align: center"> 
						  <a style="cursor: pointer; color: blue" 
						  onclick="navTabNum('/hrm/empinfo/viewFamily?PERSON_ID=${a.PERSON_ID}','pageNum=1&menuNo=125244&navTabId=hr2100','hr2100','<spring:message code="rp.report.title.familyinfo" />');">
						  ${a.LOCAL_NAME}
						 </a> 
					</td>
					<td class="td_type">${a.TAX_CODE }</td>
					<td class="td_type">${a.FAM_NAME }</td>
					<td class="td_type">${a.FAM_TYPE_CODE_NAME }</td>
					<td class="td_type">${a.DEP_PERSON_NO_NAME }</td>
					<td class="td_type">${a.FAM_BORNDATE }</td>
					<td class="td_type">${a.FAM_TAX_CODE }</td>
					<td class="td_type">${a.NATIONALITY_NAME }</td>
					<td class="td_type">${a.FAM_IDCARD }</td>
					<td class="td_type">${a.FAM_INFO_NO }</td>
					<td class="td_type">${a.FAM_INFO_BOOK_NO }</td>
					<td class="td_type">${a.FAM_INFO_NATION }</td>
					<td class="td_type">${a.FAM_INFO_CITY }</td>
					<td class="td_type">${a.FAM_INFO_COUNTY_CODE }</td>
					<td class="td_type">${a.FAM_INFO_WARD }</td>
					<td class="td_type">${a.FAM_TAX_DATE_START }</td>
					<td class="td_type">${a.FAM_TAX_DATE_END }</td>
					<td class="td_type">${a.REMARKS }</td>
				</tr>
			
				
			</c:forEach>
		</table>
		</div>
	</form>

