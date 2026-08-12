<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<style type="text/css">
.feedbackDetailTable { width:100%; border-collapse:collapse; }
.feedbackDetailTable td { border:1px solid #ddd; padding:8px 10px; vertical-align:top; }
.feedbackDetailTable td.feedbackLabel { background:#4a90d9; color:#fff; width:150px; font-weight:bold; }
.feedbackDetailTable td.feedbackContentCell { white-space:pre-wrap; word-break:break-word; }
</style>
<div class="pageContent">
	<table class="feedbackDetailTable">
		<tr>
			<td class="feedbackLabel"><spring:message code="sys.notice.feedback.list.col.title"/></td>
			<td>${item.TITLE}</td>
		</tr>
		<tr>
			<td class="feedbackLabel"><spring:message code="sys.notice.feedback.list.col.type"/></td>
			<td>${item.FEEDBACK_TYPE_NAME}</td>
		</tr>
		<tr>
			<td class="feedbackLabel"><spring:message code="sys.notice.feedback.list.col.sendDate"/></td>
			<td>${item.CREATE_DATE}</td>
		</tr>
		<tr>
			<td class="feedbackLabel"><spring:message code="sys.notice.feedback.list.col.sender"/></td>
			<td>${item.CREATED_NAME}</td>
		</tr>
		<tr>
			<td class="feedbackLabel"><spring:message code="sys.notice.feedback.list.col.content"/></td>
			<td class="feedbackContentCell">${item.CONTENT}</td>
		</tr>
	</table>
</div>
