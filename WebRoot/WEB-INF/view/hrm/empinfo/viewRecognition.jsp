<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@page import="com.ait.sys.service.ToolMenuSer"%>
<%@page import="com.ait.sys.service.impl.ToolMenuSerImpl"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
$(function(){
	$("#viewRecognition_Search",navTab.getCurrentPanel()).click(function(){
		$("#viewRecognition_Form",navTab.getCurrentPanel()).submit();
	});
});

function Recognitionhiddenleft(hiddenId,showId){
	$("#" + hiddenId).hide();
	$("#" + showId).show();
	$("#viewRecognitionlayout3").show();
	$("#viewRecognitionlayout5").hide();
	$("#viewRecognitionlayout2").hide();
	$("#viewRecognitionlayout4").hide();
}
function RecognitionshowId(showId){
	$("#" + showId).show();
	$("#viewResumeList_viewRecognitionleft").css("width","430px");
	$("#viewRecognitionlayout5").show();
	$("#viewRecognitionlayout2").show();
	$("#viewRecognitionlayout3").hide();
	$("#viewRecognitionlayout4").hide();
}
function RecognitionshowIdLeft(showId){
	$("#" + showId).show();
	$("#viewResumeList_viewRecognitionleft").css("width","430px");
	$("#viewRecognitionlayout5").show();
	$("#viewRecognitionlayout2").show();
	$("#viewRecognitionlayout3").hide();
	$("#viewRecognitionlayout4").hide();
}
function RecognitionhiddenRight(hiddenId,showId){
	$("#" + hiddenId).hide();
	$("#" + showId).show();
	$("#" + showId).css("width","95%");
	$("#viewRecognitionlayout5").hide();
	$("#viewRecognitionlayout2").show();
	$("#viewRecognitionlayout3").hide();
	$("#viewRecognitionlayout4").show();
}
$(function(){
	var aa=$("#Recolocalname").val();
	var bb=$("#Recolocalempid").val();
	var cc=$("#Recolocalpostgradenoname").val();
	var dd=$("#Recolocalpostgradeotherinf").val();
	var ff=$("#Recolocalcenter").val();
	var gg=$("#Recolocalempofficename").val();
	if(gg!=""&&typeof(gg)!="undefined"){
		$('#titlename11').html(aa+" / "+bb+" / "+cc+"/ "+gg);
	}
		openOnRight('/hrm/empinfo/viewSingleRecognition?pageNum=1&menuNo=2540&navTabId=hr0101&PERSON_ID=${personid}&REWARD_NO=${rewardNo}','viewResumeList_viewRecognitionunit');
});

function fangdajing11(flag){
	 var name=encodeURI(encodeURI($('#seach_KEY11').val()));
	$('#fangda11').attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewRecognition&seach_KEY='+name);
	if(flag == 'onkeyup')
		$('#fangda11').click();
}
$(".list",navTab.getCurrentPanel()).dataTable({"bPaginate": false,    //关闭分页
	"bAutoWidth":false,//表格宽度不自动变化
    "bProcessing":false,
	"bLengthChange": false,  //关闭按多少条记录显示下拉框
	"bFilter": false,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
	"bSort": false,   //关闭排序功能
	"bInfo": false,   //不显示datatables的信息（底部的页数，条目数信息）
	"bScrollInfinite":true,
	"scrollY": $(document.body).height() - 270,
    "scrollX": true,
    "orderClasses": false
});
</script>

<div class="pageHeader">
	<form id="viewRecognition_Form" onsubmit="return navTabSearch(this);" action="/hrm/empinfo/viewRecognition" method="post">
		<div class="searchBar">
			<table  border="0" cellpadding="0" cellspacing="0"
						class="user_table">
				<tr>
					<td class="td_title"  ><!-- 社号/姓名： --> <spring:message
						code="hr.viewContractByInsert.title.EMPIDANDLOCALNAME" />
					</td>
					<td class="td_type"  ><input
						type="text" name="seach_KEY11" id="seach_KEY11" value="${KEY}"  onkeydown="javascript:if(event.keyCode == 13)fangdajing11('onkeyup');"/>
					</td>
					<td class="td_type" >
						<a class="btnLook" id="fangda11" onclick="fangdajing11()" href="/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewRecognition" lookupGroup="person">
						</a>
						<span style="margin-left: 50px;" id="titlename11">${LOCAL_TITLE }</span>
					</td>
					<td><!-- 日期  --><spring:message code="pa.salary.title.date"/> </td>
					<td>
						<input type="text" id="START_DATE" name="START_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${START_DATE}"/>~
						<input type="text" id="END_DATE" name="END_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${END_DATE}"/>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>

<div class="pageContent">

<div class="formBar">

<ul class="toolBar">
	<c:if test="${toolbarInfo.INSERTR == '1'}">
	</c:if>
	<li>
		<a class="buttonActive" id="viewRecognition_Search" href="#">
			<span><spring:message code="button.search"/><!--查询--></span></a>
	</li>
	<li>
		<a class="buttonActive" href="/pa/excelExport/downloadExcelTemplateReward?file=Reward_Information">
				<span><spring:message code="hrm.contract.Download_templates" /> <!-- 下载模板 --> </span>
		</a>
	</li>
	<li><a class="buttonActive"
		onclick="openOnRight('/hrm/empinfo/viewSingleRecognition?pageNum=1&menuNo=2540&navTabId=hr0101&PERSON_ID=${personid}&REWARD_NO=0','viewResumeList_viewRecognitionunit');"
		href="#"> <span><spring:message code="button.add" /><!--添加--></span>
	</a></li>
	<li><a class="buttonActive"
		onclick="validateDeleteResumeInfoCallback('editRecognition',navTabAjaxDone)"
		href="#"><span><spring:message code="button.delete" /><!--删除--></span></a>
	</li>
	<li><a class="buttonActive"
		onclick="validateAddResumeInfoCallback('editRecognition',navTabAjaxDone)"
		href="#"><span><spring:message
		code="button.sys.affirm.save" /><!--保存--></span></a></li>
	<li>
		<a class="add" href="/pa/excelImport/importExcelData?importFunName=/importRecruitTempReward" target="dialog" mask="true">
			<span><spring:message code="hrm.contract.Excel_import" /><!-- EXCEL导入 --></span>
		</a>
	</li>
	<li><a class="buttonActive"
		href="/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=21&PERSON_ID=${PERSON_ID }"><span><spring:message
		code="hrm.empinfo.EXPORT" /><!--导出到EXECL--></span></a></li>
</ul>
</div>
<div id="viewResumeList_viewRecognitionleft"
	style="float: left; display: block; width: 430px; border: solid 1px #CCC;height:auto; line-height: 21px; background: #fff">
Total:${totalcount }
<table class="list" width="2800px;">
	<thead>
		<tr>
			<th>No.</th>
			<th><!--社号 --> <spring:message code="ess.infoApply.EMPID" /></th>
			<th><!--姓名 --> <spring:message code="ess.infoApply.NAME" /></th>
			<th><!--部门--><spring:message code="ar.menu.title.team" /></th>
			<th><!--部门--><spring:message code="ar.menu.title.part" /></th>
			<th><!--部门--><spring:message code="ar.menu.title.dept" /></th>
			<th><!--职务--><spring:message code="org.title.MAIN_BUSINESS" /></th>
			<th><!--职责 --> <spring:message code="hrm.contract.POSITION_NO" /></th>
			<th><!-- 表扬/得奖 --><spring:message code="hrm.empinfo.praise_prize" /></th>
			<th><!-- 表扬(得奖)日 --><spring:message code="hrm.empinfo.praise_prize_date" /></th>
			<%-- <th><!-- Reward no --><spring:message code="hrm.empinfo.reward_no" /></th> --%>
			<th><!-- 授予机关  --><spring:message code="ess.empInfo.awarding_authority" /></th>
			<th><!--  奖金 --><spring:message code="ess.empInfo.bonus" /></th>
			<th><!-- 备注 --> <spring:message code="ess.empInfo.remarks" /></th>
			<th ><!-- 人事卡查询与否 --><spring:message code="hrm.empinfo.Personnel_card_inquiry" /></th>
			<th><!-- 变更者 --> <spring:message code="org.title.UPDATED_IP" /></th>
			<th><!-- 变更时间 --> <spring:message code="org.title.UPDATE_DATE" /></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${viewRecognition}" var="item" varStatus="i">
			<tr id="REC_${item.REWARD_NO }"
				onclick="openOnRight('/hrm/empinfo/viewSingleRecognition?pageNum=1&menuNo=2540&navTabId=hr0101&PERSON_ID=${item.PERSON_ID}&REWARD_NO=${item.REWARD_NO }','viewResumeList_viewRecognitionunit');">
				<td style="text-align: left" nowrap="nowrap">${i.count}</td>
				<td style="text-align: center">${item.EMPID}</td>
				<td style="text-align: center">${item.LOCAL_NAME}</td>
				<td style="text-align: center">${item.TEAM}</td>
				<td style="text-align: center">${item.PART}</td>
				<td style="text-align: center">${item.DEPT}</td>
				<td style="text-align: center">${item.MAIN_BUSINESS}</td>
				<td style="text-align: center">${item.RANK}</td>
				<td style="text-align: center" nowrap="nowrap">${item.REWARD_TYPE_NAME}</td>
				<td style="text-align: center" nowrap="nowrap">${item.REWARD_DATE}</td>
				<%-- <td style="text-align: left" nowrap="nowrap">${item.REWARD_TYPE_NO}</td> --%>
				<td style="text-align: center" nowrap="nowrap">${item.REWARD_CNPY}</td>
				<td style="text-align: right" nowrap="nowrap">${item.REWARD}</td>
				<td style="text-align: left" nowrap="nowrap">${item.REMARKS}</td>
				<td style="text-align: left" nowrap="nowrap"><input type="checkbox" disabled="disabled" <c:if test="${item.PERSONNEL_CARD_INQUIRY eq 'Y'}"> checked="checked" </c:if> ></input></td>
				<c:if test="${not empty item.UPDATED_BY}">
					<td style="text-align: left" nowrap="nowrap">${item.UPDATED_BY
					}&nbsp&nbsp${item.UPDATED_IP }</td>
					<td style="text-align: left" nowrap="nowrap">${item.UPDATED_DATE
					}</td>
				</c:if>
				<c:if test="${empty item.UPDATED_BY}">
					<td style="text-align: left" nowrap="nowrap">${item.CREATED_BY
					}&nbsp&nbsp${item.CREATED_IP }</td>
					<td style="text-align: left" nowrap="nowrap">${item.CREATE_DATE
					}</td>
				</c:if>
			</tr>

		</c:forEach>
	</tbody>
</table>
<input type="hidden" id="Recolocalname" value="${title.LOCAL_NAME }">
<input type="hidden" id="Recolocalempid" value="${title.EMPID }">
<input type="hidden" id="Recolocalpostgradenoname"
	value="${title.POST_GRADE_NO_NAME_TITLE }"> 
<input
	type="hidden" id="Recolocalpostgradeotherinf"
	value="${title.RANK_STATISTICS_NAME }">
<input type="hidden"
	id="Recolocalcenter" value="${title.COST_CENTER_TITLE }"> 
<input
	type="hidden" id="Recolocalempofficename"
	value="${title.EMP_OFFICE_NAME_TITLE }"> 
	<%@ include file="/WEB-INF/view/inc/initPagination11.jsp"%>
</div>
<div class="w-layout-collapse">
<div id="viewRecognitionlayout5" class="w-layout-collapse-left"
	onclick="RecognitionhiddenRight('viewResumeList_viewRecognitionunit','viewResumeList_viewRecognitionleft')"></div>
<div id="viewRecognitionlayout4" class="w-layout-collapse-right"
	style="display: none;"
	onclick="RecognitionshowIdLeft('viewResumeList_viewRecognitionunit')"></div>
<!-- <div id="viewRecognitionlayout2" class="w-layout-collapse-right" onclick="Recognitionhiddenleft('viewResumeList_viewRecognitionleft','viewResumeList_viewRecognitionunit')"></div> -->
<div id="viewRecognitionlayout3" class="w-layout-collapse-left"
	style="display: none;" onclick="RecognitionshowId('viewResumeList_viewRecognitionleft')";
></div>
</div>
<div id="viewResumeList_viewRecognitionunit" style="display: block;">
</div>
</div>