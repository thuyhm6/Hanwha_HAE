<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#viewBrithList_seach",navTab.getCurrentPanel()).click(function(){
		$("#viewBrithListForm",navTab.getCurrentPanel()).submit();
	});
});

</script>

<div class="pageHeader">
<form id="viewBrithListForm" onsubmit="return navTabSearch(this);" action="/ess/empinfo/viewBrithList" method="post">
<div class="searchBar">
<table class="searchContent">
	<tr>
		<td><spring:message code="inct.salesman.empNo" />/<spring:message code="alert.pa.pasalarycanshu.xingming"/></td>
		<td><input type="text" name="KEY" value="${KEY}" /></td>
		
		<td><spring:message code="ar.excelexport.title.month" /> <spring:message code="hr.viewCondSql.title.SHENGRI"/></td>
		<td><input type="text" name="MONTH" value="${MONTH}" /></td>
	</tr>
</table>
</div>
</form>
</div>
<div class="formBar">
	<ul class="toolBar">
			<li>
				<a class="buttonActive" id="viewBrithList_seach" href="#">
					<span style="margin-left:-0px"><!--查询 --><spring:message code="ess.infoApply.SELECT"/></span>
				</a>
			</li>
			<li>
				<a class="buttonActive" onclick="downloadExcel('viewBrithListForm','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=159','/ess/empinfo/viewBrithList?firstFlag=N')">
					<span><!--导出到Excel--><spring:message code="hrm.empinfo.EXPORT" /></span>
				</a>
			</li>
	</ul>
</div>
<div class="pageContent" style="padding-left:10px;padding-right:10px;">
        <div class="user_table" style="font:bold 12px/20px arial,sans-serif;">Total:${getBirthdayListCnt}</div>
		<table class="table" width="100%" layoutH="200" >
		<tr>
		<td class="td_title" width="5%">NO</td>
		<td class="td_title" width="15%"><spring:message code="inct.salesman.empNo" /><!-- 工号 --></td>
		<td class="td_title" width="15%"><spring:message code="alert.pa.pasalarycanshu.xingming" /><!-- 员工姓名 --></td>
		<td class="td_title" width="35%"><spring:message code="hr.viewPersonalInfo.title.DEPTNAME" /><!-- 部门 --></td>
		<td class="td_title" width="15%"><spring:message code="hr.viewPersonalInfo.title.POST_GRADE_NAME" /><!-- 职位 --></td>
		<td class="td_title" width="15%"><spring:message code="hrm.empinfo.DOB" /><!-- 生日 --></td>
		</tr>
		<c:forEach items="${getBirthdayList}" var="d" varStatus="i">
		<tr>
		<td class="td_type">${i.count }</td>
		<td class="td_type">${d.EMPID }</td>
		<td class="td_type">${d.LOCAL_NAME }</td>
		<td class="td_type">${d.DEPARTMENT_NAME }</td>
		<td class="td_type">${d.POST_GRADE_NAME }</td>
		<td class="td_type">${d.BIRTH }</td>
		</tr>
		</c:forEach>
		</table>
		<div class="subBar" style="padding-left: 650px;">
		</div>
</div>
