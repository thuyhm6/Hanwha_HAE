<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<style type="text/css">
.feedbackListTable tbody tr { cursor:pointer; }
</style>
<script type="text/javascript">
function openFeedbackDetail(row, evt){
	if($(evt.target).closest("a.j-feedbackDetail").length > 0){
		return true;
	}
	$(row).find("a.j-feedbackDetail").eq(0).click();
	return false;
}
</script>
<div class="pageHeader">
<form onsubmit="return navTabSearch(this);"
	action="/sys/notice/viewFeedbackComplaintsList" rel="pagerForm" method="post">
<div class="searchBar">
<table class="searchContent">
	<tr>
		<td><spring:message code="sys.notice.feedback.list.col.title"/><!-- Tiêu đề --></td>
		<td><input type="text" id="seach_TITLE" name="seach_TITLE" value="${TITLE}" /></td>
		<td><spring:message code="sys.notice.feedback.list.col.type"/><!-- Loại góp ý/ khiếu nại --></td>
		<td><ait:SelectSyCodeByCpnyID id="seach_FEEDBACK_TYPE" name="seach_FEEDBACK_TYPE" parentNo="14014426" selected="${FEEDBACK_TYPE}" limit="ALL"/></td>
		<td><spring:message code="sys.notice.feedback.list.search.fromDate"/><!-- Từ ngày --></td>
		<td>
			<input type="text" name="seach_FROM_DATE" id="seach_FROM_DATE" value="${FROM_DATE }" class="Wdate" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
		</td>
		<td><spring:message code="sys.notice.feedback.list.search.toDate"/><!-- Đến ngày --></td>
		<td>
			<input type="text" name="seach_TO_DATE" id="seach_TO_DATE" value="${TO_DATE }" class="Wdate" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
		</td>
	</tr>
</table>
<div class="subBar">
<ul>
	<li>
	<div class="buttonActive">
	<div class="buttonContent">
	<button type="submit"><spring:message code="public.title.search" /><!-- Tìm kiếm --></button>
	</div>
	</div>
	</li>
</ul>
</div>
</div>
</form>
</div>
<div class="pageContent">
  <table class="table feedbackListTable" width="100%" layoutH="206">
	<thead>
	  <tr>
		<th width="5%"><spring:message code="sys.notice.feedback.list.col.stt"/></th>
		<th width="18%"><spring:message code="sys.notice.feedback.list.col.title"/></th>
		<th width="15%"><spring:message code="sys.notice.feedback.list.col.type"/></th>
		<th width="32%"><spring:message code="sys.notice.feedback.list.col.content"/></th>
		<th width="15%"><spring:message code="sys.notice.feedback.list.col.sendDate"/></th>
		<th width="15%"><spring:message code="sys.notice.feedback.list.col.sender"/></th>
	  </tr>
	</thead>
	<tbody>
	  <c:forEach items="${fList }" var="item" varStatus="status">
		<tr onclick="return openFeedbackDetail(this, event);">
			<td style="text-align:center;">${status.count}</td>
			<td style="text-align:left;">
				<a class="j-feedbackDetail" href="/sys/notice/viewFeedbackDetail?ID=${item.FEEDBACK_ID}" target="dialog" mask="true" width="600" height="450" title="<spring:message code='sys.notice.feedback.detail.title' />">${item.TITLE }</a>
			</td>
			<td style="text-align:left;">${item.FEEDBACK_TYPE_NAME}</td>
			<td style="text-align:left;">${fn:substring(item.CONTENT, 0, 60)}<c:if test="${fn:length(item.CONTENT) > 60}">...</c:if></td>
			<td style="text-align:center;">${item.CREATE_DATE}</td>
			<td style="text-align:center;">${item.CREATED_NAME}</td>
		</tr>
	  </c:forEach>
	</tbody>
</table>
<c:set value="/sys/notice/viewFeedbackComplaintsList" var="pageUrl"/>
<%@include file="/WEB-INF/view/inc/initPagination.jsp"%>
</div>
