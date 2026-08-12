<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">

function changeURL_teacher_eval(basicNo,teacherID){
	var href = "/edu/traineducation/teacherEvaluateTSTOSingle?BASIC_NO=" + basicNo + "&QUERY_TEA_EMPID="+teacherID;
	$.pdialog.open(href,"edu0203", "<spring:message code='pa.salary.title.fullInfo' />", {width:900,height:600,mask:true});//查看
}
</script>
<div class="pageContent" layoutH="10">
		<table id="tearcherTable" class="user_table" width="100%" border="1" cellpadding="2" cellspacing="1" >
		<span>Total:${queryPlanManageListCount }</span>
		<tr>
		<td class="td_title" width="1%">NO</td>
		<td class="td_title" style="text-align: center;"  width="15%"><spring:message code="empsubject.subjectNm"/><!--课程名称--></td>
		<td class="td_title" style="text-align: center;"  width="3%"><spring:message code="ess.infoApply.title.startTime"/><!--开始时间--></td>
		<td class="td_title" style="text-align: center;"  width="3%"><spring:message code="edu.planManager.JIESHUSHIJIAN.a"/><!--结束时间--></td>
		<td class="td_title" style="text-align: center;"  width="3%"><spring:message code="ar.viewarcardrecord.title.shijian"/><!--时间--></td>
		<td class="td_title" style="text-align: center;"  width="10%"><spring:message code="edu.planManager.XIANGXIDIDIAN.a"/><!--详细地点--></td>
		</tr>
		<c:forEach items="${queryPlanManageList}" var="d" varStatus="i">
		<tr>
		<td class="td_type"  style="text-align: center;"  width="1%" >${i.count }</td>
		<td class="td_type"  style="text-align: center;"  width="15%" >
		<a class="td_type" width="5%" style="text-align:center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_teacher_eval(${d.BASIC_NO },${TEACHER_EMPID });'>
            <span style="color: blue">${d.COURSE_NAME_CODE } (<spring:message code="edu.planManager.QI.a"/><!--期--> <spring:message code="ar.alert.message.excelimport.title.di"/><!--第--> ${d.PERIOD_TIME })</span>
            <c:if test="${d.BASIC_NO eq null}">
				- <spring:message code="edu.teacherEvaluate.WEIKAOPING.a"/>
			</c:if>
        </a>
		
		</td>
		<td class="td_type"  style="text-align: center;"  width="3%" >${d.PLAN_STARTDATE }</td>
		<td class="td_type"  style="text-align: center;"  width="3%" >${d.PLAN_ENDDATE }</td>
		<td class="td_type"  style="text-align: center;"  width="3%" >${d.SUM_HOURS } <spring:message code="ar.viewitemparameter.title.xiaoshi"/></td>
		<td class="td_type"  style="text-align: center;"  width="10%" >${d.TRAIN_ADDRESS }</td>
		</tr>
		</c:forEach>
		</table>
</div>
