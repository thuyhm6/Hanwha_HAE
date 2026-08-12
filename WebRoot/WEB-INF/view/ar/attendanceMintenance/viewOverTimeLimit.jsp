<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
$(document).ready(function(){
	$(".orderList",navTab.getCurrentPanel()).dataTable({
		"bPaginate": true,    //分页
	    "bAutoWidth":false,//表格宽度自动变化
	    "bProcessing":true,
	    "lengthMenu": [[50,100,200, 500], [50,100,200, 500]],
		"bLengthChange": true,  //按多少条记录显示下拉框
		"iDisplayLength": 50, //默认每页显示的记录数
		"bFilter": true,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
     	"searching": true,//本地搜索
		"bSort": true,   //排序功能
		"bInfo": true,   //显示datatables的信息（底部的页数，条目数信息）
		"bScrollInfinite":true,
	     "orderClasses": false,
	     "order":[],//初始化不用自动排序
	     "scrollY": $(document.body).height() - 310,
	     "scrollCollapse": false,
	     "deferRender":true,
	     //"scroller":true,
        "oLanguage": {//多语言配置
        	"sProcessing": "<spring:message code='hem.alert.empinfo.Is_loading'/>",//正在加载中......
            "sZeroRecords": "<spring:message code='hem.alert.empinfo.not_find_relevant_data'/>",//查询不到相关数据！
            "sEmptyTable": '<spring:message code="ess.infoApply.titel.messages200"/>',
            "sSearch": '<spring:message code="hrm.alert.contractInfo.Rapid_screening"/>',
            "sLengthMenu": '<spring:message code="ess.infoApply.titel.messages201"/> _MENU_ <spring:message code="ess.infoApply.titel.messages202"/>',
            "sInfo": '<spring:message code="hrm.alert.contractInfo.START_END_TOTAL"/>',
            "sInfoFiltered": "(<spring:message code='hrm.alert.contractInfo.Record_filter'/>)",//从 _MAX_ 条记录过滤
            "oPaginate": {
                "sPrevious": '<spring:message code="hrm.alert.contractInfo.Previous_page"/>',
                "sNext": '<spring:message code="hrm.alert.contractInfo.NEXT_PAGE"/>'
            }
        },
        "sDom":'<"top"r<"clear">fBl>t<"bottom"ip<"clear">>',
        "buttons": [
              ] 
		});
});
function fillValueForUpdate(personId,otLimit,empId){
	$("#personId",navTab.getCurrentPanel()).attr('value',personId);
	$("#otLimit",navTab.getCurrentPanel()).attr('value',otLimit);
	$("#empIdName",navTab.getCurrentPanel()).attr('value',empId);
}
function doUpdatePayObjAjax(url){
	var flag = false;
	var ids= document.getElementsByName("viewCheck");

	for(var i=0;i<ids.length;i++){
		if(ids[i].checked){
			flag=true;
		}
	}
	if(flag == false){//请选择要修改的内容
		alertMsg.info("<spring:message code='ar.viewApplyAttenanceManagentInfoList.QINGXUANZEXIUGAINEIRONG.b'/>");
		return false;
    }
	
	var $form = $("#updateOverTimeLimit");
	alertMsg.confirm("<spring:message code='hrm.contractInfo.SURE_UPDATE.Z' />",//确定要修改吗
  		  	{okCall:function(){
		  	$.ajax({
  				type: 'POST',
  				url:$form.attr("action"),
  				data:$form.serializeArray(),
  				dataType:"json",
  				cache: false,
  				success: doAjaxDoneWithForm,
  				error: DWZ.ajaxError
  			});
  	}});

}

/**
 * 禁用textArea以及Input框的enter键的自动提交
 */
document.onkeydown = function(event) {  
	  var target, code, tag;  
	  if (!event) {  
	       event = window.event; //针对ie浏览器  
	       target = event.srcElement;  
	       code = event.keyCode;  
	       if (code == 13) {  
	           tag = target.tagName;  
	           if (tag == "TEXTAREA") {
		           return true;
		       }else{ 
			       return false;
			   }  
	       }  
	  }else {  
	       target = event.target; //针对遵循w3c标准的浏览器，如Firefox  
	       code = event.keyCode;  
	       if (code == 13) {  
	           tag = target.tagName;  
	           if (tag == "INPUT"){ 
		           return false; 
		       }else {
			        return true;
			   }   
	      }  
	 }  
}

function fillItem_ar0701(){
	var otLimitMonth = $("#FILL_OT_LIMIT_MONTH",navTab.getCurrentPanel()).val();
	var otLimitYear = $("#FILL_OT_LIMIT_YEAR",navTab.getCurrentPanel()).val();
	var ids= document.getElementsByName("viewCheck");
	var checked=false;
	var length = null;
	for(var i=0;i<ids.length;i++){
		if(ids[i].checked){
			checked=true;
			var index = ids[i].id.substring(9);
			if (otLimit != '') {
				$("#OT_LIMIT_MONTH_"+index,navTab.getCurrentPanel()).val(otLimitMonth);
			}
			if (otLimit100 != '') {
				$("#OT_LIMIT_YEAR_"+index,navTab.getCurrentPanel()).val(otLimitYear);
			}
		}
	}
	if(!checked){
		//请选择要修改的内容
		alertMsg.error("<spring:message code='ar.viewApplyAttenanceManagentInfoList.QINGXUANZEXIUGAINEIRONG.b'/>");
		return false;
	}
}
</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="/ar/attendanceMintenance/viewOverTimeLimit?OT_LIMIT_PARAM=1" method="post"
		id="viewOverTimeLimit" name="viewOverTimeLimit">
		<input type="hidden" id="personId" />
		<input type="hidden" id="empIdName" />
		<input type="hidden" id="includeType" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td><!-- 工号/姓名： --> <spring:message
						code="hr.viewContractByInsert.title.EMPIDANDLOCALNAME" />
					</td>
					<td><input
						type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"  onkeydown="javascript:if(event.keyCode == 13)searchPop('onkeyup');"/>
						</td>
						<td>
						<!-- 部门 --><spring:message code="ess.infoApply.DEPT" />
					</td>
					<td>
						<ait:deptTreeMulti id="seach_DEPTNO_Multi" name="seach_DEPT_NAME" limit="ar" selectedNm="${DEPT_NAME}" selected="${DEPTNO_Multi}"></ait:deptTreeMulti>
					</td>
					<td>
						<input type="hidden" format="yyyyMM" id="START_AR_MONTH_STR"
							value="${START_AR_MONTH_STR}" />
						<input type="hidden" format="yyyyMM" id="END_AR_MONTH_STR"
							value="${END_AR_MONTH_STR}" />
						<!-- 开始日期 -->
						<spring:message code="public.title.startDate" />
					</td>
					<td>
						<input type="text" id="START_AR_MONTH_STR"
							name="START_AR_MONTH_STR" value="${START_AR_MONTH_STR}" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyyMM',lang:'en'})" />
					</td>
					<td>
						<!-- 结束日期 -->
						<spring:message code="public.title.endDate" />
					</td>
					<td style="position: relative; overflow: hidden">
						<input type="text" id="END_AR_MONTH_STR"
							name="END_AR_MONTH_STR" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyyMM',lang:'en'})" value="${END_AR_MONTH_STR}" />
					</td>
					</tr>
					<tr>
					<td><!-- 加班上限 --> <spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHANGXIAN.b" /> <spring:message code="ar.excelexport.title.month" />:</td>
					<td>
						<select id="OT_LIMIT_MONTH" name="OT_LIMIT_MONTH" >
							<option value="" ><!-- 全部 --> <spring:message code="pa.salary.canShu.quanBu" /></option>
							<option value="1"  <c:if test="${OT_LIMIT_MONTH eq '1' }">selected</c:if>><!--Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
							<option value="0"  <c:if test="${OT_LIMIT_MONTH eq '0' }">selected</c:if>><!-- No --> <spring:message code="ar.viewcycle.content.no" /></option>
						</select>
					</td>
					<td><!-- 加班上限 --> <spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHANGXIAN.b" /> <spring:message code="rp.report.title.year" />:</td>
					<td>
						<select id="OT_LIMIT_YEAR" name="OT_LIMIT_YEAR" >
							<option value="" ><!-- 全部 --> <spring:message code="pa.salary.canShu.quanBu" /></option>
							<option value="1"  <c:if test="${OT_LIMIT_YEAR eq '1' }">selected</c:if>><!--Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
							<option value="0"  <c:if test="${OT_LIMIT_YEAR eq '0' }">selected</c:if>><!-- No --> <spring:message code="ar.viewcycle.content.no" /></option>
						</select>
					</td>
					<td ><spring:message code="hrm.empinfo.POST_FAMILY" /><!-- 职群 --></td>
					<td class="td_type">
						<ait:SelectSyCodeByCpnyID name="POST_FAMILY" id="POST_FAMILY" selected="${POST_FAMILY}" 	parentNo="14015812"  limit="all"/>
					</td>
					<td ><spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHIJIAN.b" /><!-- 加班时间--> >= </td>
					<td><input
						type="text" name="OT_TOTAIL_MONTH" id="OT_TOTAIL_MONTH" 
						<c:if test="${OT_TOTAIL_MONTH eq '' }">value="${0}"</c:if> 
						<c:if test="${OT_TOTAIL_MONTH ne '' }">value="${OT_TOTAIL_MONTH}"</c:if> />
					</td>
					
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">
									<spring:message code="public.title.search" />
									<!--检索-->
								</button>
							</div>
						</div>
					</li>
					
					<li>
						<a class="buttonActive" href="/ar/attendanceMintenance/overTimeLimitImportDemo"> 
						<span><spring:message code="pa.button.message.specialempimportmodeldown"/><!--导入模板下载--></span>
						</a>
					</li>
					<li>
						<a class="buttonActive" href="/pa/excelImport/importExcelData?&importFunName=/importOTLimitTSTO" target="dialog" mask="true" width="400" height="200" >
						<span><!-- EXCEL导入 --><spring:message code="ar.addempshift.title.excelimport"/></span></a>
					</li>
					<li>
						<a class="buttonActive"  onclick="doUpdatePayObjAjax();" href="#" >
							<span><!--保存--><spring:message code="button.sys.affirm.save" /></span>
						</a>
					</li>
					<li><a class="buttonActive" 
					onclick="downloadExcel('viewOverTimeLimit','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=290','/ar/attendanceMintenance/viewOverTimeLimit?OT_LIMIT_PARAM=1&firstFlag=N')" >
					<span><!-- 导出到Excel --><spring:message code="org.title.exportLOtImportExcel"/></span></a></li>
				</ul>
			</div>
		</div>
	</form>
</div>
<div id="viewApplyAttenBatch" class="pageHeader" >
    <div class="searchBar">
			<table class="searchContent">
			    <tr>
			       <td><!-- 加班上限 --> <spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHANGXIAN.b" /> <spring:message code="ar.excelexport.title.month" />:</td>
					<td>
						<select id="FILL_OT_LIMIT_MONTH" name="FILL_OT_LIMIT_MONTH" >
							<option value="" ><!-- 全部 --> <spring:message code="pa.salary.canShu.quanBu" /></option>
							<option value="1" ><!--Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
							<option value="0" ><!-- No --> <spring:message code="ar.viewcycle.content.no" /></option>
						</select>
					</td>
					<td><!-- 加班上限 --> <spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHANGXIAN.b" /> <spring:message code="rp.report.title.year" />:</td>
					<td>
						<select id="FILL_OT_LIMIT_YEAR" name="FILL_OT_LIMIT_YEAR" >
							<option value="" ><!-- 全部 --> <spring:message code="pa.salary.canShu.quanBu" /></option>
							<option value="1" ><!--Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
							<option value="0" ><!-- No --> <spring:message code="ar.viewcycle.content.no" /></option>
						</select>
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul class="toolBar">
	             <li>
	             	<a class="buttonActive" onclick="fillItem_ar0701();"><span><!-- 全部反应 --><spring:message code="hrm.approve.ALL_REACTION"/></span></a>
	             </li>
				</ul>
			</div>
	</div>
</div>
<div class="pageContent" >
	<form name="updateOverTimeLimit" id="updateOverTimeLimit" method="post" action="/ar/attendanceMintenance/updateOverTimeLimit" 
	  onsubmit="return delLeaveApplyCallback(this, navTabAjaxDone);"> 
		<table class="orderList" width="100%">   
			<thead>
			<tr>
				<th width="20" rowspan="2">
				    <input type="checkbox" class="checkboxCtrl" group="viewCheck" />
				</th>
			
				<th rowspan="2">No.</th>
				<th rowspan="2"><!--工号--> <spring:message code="ess.infoApply.EMP_ID" /></th>
				<th rowspan="2"><!-- 姓名--> <spring:message code="alert.pa.pasalarycanshu.xingming" /></th>
				<th rowspan="2"><!-- 部门名 --> <spring:message code="ess.infoApply.DEPT_NAME" /></th>
				<th rowspan="2"><!-- 月加班 --> <spring:message code="ar.excelexport.title.month" /></th>
				<th rowspan="2"><!-- 加班上限 --> <spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHANGXIAN.b" /> <spring:message code="ar.excelexport.title.month" /></th>
				<th rowspan="2"><!-- 加班上限 --> <spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHANGXIAN.b" /> <spring:message code="rp.report.title.year" /></th>
				<th colspan="6"><!--加班累计--><spring:message code="ess.title.JIABANLEIJI" /></th>
				<th rowspan="2"><!-- 变更者--> <spring:message code="hrm.empinfo.UPDATED_BY" /></th>
				<th rowspan="2"><!-- 变更时间--> <spring:message code="hrm.empinfo.UPDATE_DATE" /></th>
			</tr>
			<tr>
			<th  width="70px">
				<!--本年--><spring:message code="ess.viewPiciOtAffirmBatchList.BENNIAN.b" />
				</th>
				<th  width="80px">
					<!--本月--><spring:message code="ess.viewPiciOtAffirmBatchList.BENYUE.b" />
				</th>
				<th  width="80px">
					<!--平时--><spring:message code="ar.viewitemparameter.title.pingshi" />
				</th>
				<th  width="80px">
					<!--Saturday--><spring:message code="ess.viewMonthDetailList.OT_ON_SATURDAY.b" />
				</th>
				<th  width="80px">
					<!--周末--><spring:message code="ar.viewitemparameter.title.zhoumo" />
				</th>
				<th  width="80px">
					<!--节假日--><spring:message code="ar.viewitemparameter.title.jiejiari" />
				</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${OverTimeLimitList}" var="Ot" varStatus="i">
			
			<tr target="OT_LIMIT_NO" rel="${Ot.OT_LIMIT_NO}">
				<td style="text-align: center;padding-top:7px;">
					<input id="viewCheck${i.index}" type="checkbox" name="viewCheck" value="${i.index}"/>
					<input type="hidden" name="OT_LIMIT_NO_${i.index}" value="${Ot.OT_LIMIT_NO}" />
				</td>
				<td style="text-align: center">${i.count}</td>
				<td style="text-align: center">${Ot.EMPID}</td>
				<td style="text-align: center">${Ot.LOCAL_NAME}</td>
				<td style="text-align: center">${Ot.DEPT_NAME}</td>
				<td style="text-align: center">${Ot.AR_MONTH_STR}</td>
				<td style="text-align: center">
					<select id="OT_LIMIT_MONTH_${i.index}" name="OT_LIMIT_MONTH_${i.index}" onchange="$('#viewCheck${i.index}',navTab.getCurrentPanel()).attr('checked','checked');fillValueForUpdate('${Ot.OT_LIMIT_NO}',this.value,'[${Ot.EMPID}]${Ot.EMPNAME}')">
						<option value="1"  <c:if test="${Ot.OT_LIMIT_MONTH == 1 }">selected</c:if>><!-- Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
						<option value="0"  <c:if test="${Ot.OT_LIMIT_MONTH == 0 }">selected</c:if>><!--No--> <spring:message code="ar.viewcycle.content.no" /></option>
					</select>
				</td>
				<td style="text-align: center">
					<select id="OT_LIMIT_YEAR_${i.index}" name="OT_LIMIT_YEAR_${i.index}" onchange="$('#viewCheck${i.index}',navTab.getCurrentPanel()).attr('checked','checked');fillValueForUpdate('${Ot.OT_LIMIT_NO}',this.value,'[${Ot.EMPID}]${Ot.EMPNAME}')">
						<option value="1"  <c:if test="${Ot.OT_LIMIT_YEAR == 1 }">selected</c:if>><!-- Yes --> <spring:message code="ar.viewcycle.content.yes" /></option>
						<option value="0"  <c:if test="${Ot.OT_LIMIT_YEAR == 0 }">selected</c:if>><!--No--> <spring:message code="ar.viewcycle.content.no" /></option>
					</select>
				</td>
				<td style="text-align: center">${Ot.OT_TOTAIL}</td>
				<td style="text-align: center">${Ot.OT_TOTAIL_MONTH}</td>
				<td style="text-align: center">${Ot.WEEKDAY_OT_TOTAIL}</td>
				<td style="text-align: center">${Ot.SATURDAY_OT_TOTAIL}</td>
				<td style="text-align: center">${Ot.WEEKEND_OT_TOTAIL}</td>
				<td style="text-align: center">${Ot.HOILDAY_OT_TOTAIL}</td>
				<td style="text-align: center">${Ot.UPDATED_BY_ID} - ${Ot.UPDATE_LOCAL_NAME}</td>
				<td style="text-align: center">${Ot.UPDATE_DATE}</td>
			</tr>
		</c:forEach>
		</tbody>
		</table>
	</form>
	<div style="visibility: hidden">
    <%--<c:set value="/ess/infoApplyAttendance/viewApplyAttendanceInfoList?firstFlag=N" var="pageUrl"/>
	<%@ include file="/WEB-INF/view/inc/initPagination2.jsp"%>--%>
	</div>
</div>