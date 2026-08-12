<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="pageContent">
	<div class="panel">
		<h1>
			<spring:message code="hr.viewPersonalInfo.title.STAFF_FOUNDATION_INFORMATION"/>
			<!--员工基础信息-->
		</h1>
		<div layoutH="365"><%@ include file="/WEB-INF/view/hrm/empinfo/viewPersonalInfoHead1.jsp"%></div>
	</div>
	<div class="panel">
		<h1>
			<spring:message code="hr.viewGoAbroad.title.ABROAD_INFORMATION"/>
			<!--出国信息-->
		</h1>
	<div>
	<table class="table" width="100%">
		<thead>
			<tr>
				<th width="80">
					<spring:message code="hr.viewGoAbroad.title.COUNTRY_NAME"/>
					<!--国家-->
				</th>
				<th width="80">
					<spring:message code="hr.viewTranslate.title.PUBLIC_START_DATE"/>
					<!--开始时间-->
				</th>
				<th width="80">
					<spring:message code="hr.viewTranslate.title.PUBLIC_END_DATE"/>
					<!--结束日期-->
				</th>
				<th width="80">
					<spring:message code="hr.viewGoAbroad.title.COST"/>
					<!--费用(元)-->
				</th>
				<th width="80">
					<spring:message code="hr.viewGoAbroad.title.PURPOSE"/>
					<!--目的-->
				</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${goAbroadList}" var="item" varStatus="i">
			
				<tr>
					<td>${item.COUNTRY_NAME}</td>
					<td>${item.START_DATE}</td>
					<td>${item.END_DATE}</td>
					<td style="text-align:right"><fmt:formatNumber value="${item.COST}" pattern="#,##0.00"/></td>
					<td>${item.PURPOSE}</td>
				</tr>			
			</c:forEach>		
		</tbody>
	</table>
	</div>		

</div>