<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
	function  openLoginUserExecl(a){
    	var $this=$(a);
      	var title = $this.attr("title"); 
      	var $from = $("#viewLoginUser");  
      
	  	var url ="/sys/rightsManagement/viewLoginUserExcel";
	   	alertMsg.confirm(title, {
					okCall: function(){  
					   window.location =url+ (url.indexOf('?') == -1 ? "?" : "&") + $from.serialize();
					}});
    
 	}
 </script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="/sys/notice/viewSendSMS" method="post" rel="pagerForm">
	<div class="searchBar" >
		<table class="searchContent">
			<tr>
				<td> <!-- 期间 --><spring:message code="ess.infoApply.Period" /></td>
				<td>
					<input type="text" id="seach_START_DATE" name="seach_START_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd.MM.yyyy',lang:'en'})" value="${START_DATE}"/>~
					<input type="text" id="seach_END_DATE" name="seach_END_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd.MM.yyyy',lang:'en'})" value="${END_DATE}"/>
				</td>
				<td><!-- 手机号码 --><spring:message code="liang.hr.viewPersonalInfo.title.PHONE_NUMBER" /></td>
				<td>
					<div style="float:left"><input type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"/></div>
				</td>
		</table>
		<div class="subBar">
			<ul>
				<li>
					<div class="buttonActive"><div class="buttonContent"><button type="submit">
					<spring:message code="public.title.search"/><!-- 检索 --></button></div></div>
				</li>
				<li>
				  <a class="button" onclick="openLoginUserExecl(this)" <%--是否导出?--%> title="<spring:message code='rp.report.title.exportYN'/>">
				  <span><%--Excel导出--%><spring:message code="ar.addempshift.title.excelexport"/></span></a>
	           	</li>
			</ul>
			
		</div>
	</div>
	</form>
</div>

<div class="pageContent">
	<c:set value="dialog" var="add_tab"/>
	<c:set value="800" var="add_width"/>
	<c:set value="400" var="add_height"/>
	<c:set value="/sys/notice/addSendSMS" var="add_Url"/>
	<%@ include file="/WEB-INF/view/inc/includeButton.jsp"%>
	<table class="table" width="100%" layoutH="206">
		<thead>
			<tr>
				<th width="5">No<!--发送时间--></th>
			    <th width="60"><spring:message code="pa.salary.title.sendtime"/><!--发送时间--></th>
				<th width="80"><spring:message code="liang.hr.viewPersonalInfo.title.PHONE_NUMBER"/><!--手机号码--></th>
				<th width="80"><spring:message code="hrm.contract.content"/><!--内容--></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sendSMSList}" var="sendSMS" varStatus="i">
			
				<tr target="sid" rel="${sendSMS.USER_NO}&SMS_ID=${sendSMS.SMS_ID}">
					<td style="text-align: center">${i.index + 1}</td>
					<td>${sendSMS.SEND_TIME}</td>
					<td>${sendSMS.PHONE_NUMBER}</td>
					<td>${sendSMS.MESSAGE}</td>
				</tr>
			
			</c:forEach>
			
		</tbody>
	</table>
	
		<c:set value="/sys/notice/viewSendSMS" var="pageUrl"/>
	<%@ include file="/WEB-INF/view/inc/initPagination.jsp"%>
	
</div>
