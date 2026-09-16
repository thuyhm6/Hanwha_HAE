<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<style type="text/css">
.pdcListTable tbody tr { cursor:pointer; }
</style>
<script type="text/javascript">
function openPersonalDataConfirmDetail(row, evt){
	if($(evt.target).closest("a.j-pdcDetail").length > 0){
		return true;
	}
	$(row).find("a.j-pdcDetail").eq(0).click();
	return false;
}
</script>
<div class="pageHeader">
<form onsubmit="return navTabSearch(this);"
	action="/sys/notice/viewPersonalDataConfirmList" rel="pagerForm" method="post">
<div class="searchBar">
<table class="searchContent">
	<tr>
		<td>Họ và tên / ID</td>
		<td><input type="text" id="seach_KEY" name="seach_KEY" value="${KEY}" /></td>
		<td>Ngày xác nhận từ</td>
		<td><input type="text" name="seach_FROM_DATE" id="seach_FROM_DATE" value="${FROM_DATE }" class="Wdate" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" /></td>
		<td>đến</td>
		<td><input type="text" name="seach_TO_DATE" id="seach_TO_DATE" value="${TO_DATE }" class="Wdate" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" /></td>
	</tr>
</table>
<div class="subBar"><ul><li><div class="buttonActive"><div class="buttonContent">
<button type="submit"><spring:message code="public.title.search" /></button>
</div></div></li></ul></div>
</div>
</form>
</div>
<div class="pageContent">
<table class="table pdcListTable" width="100%" layoutH="206">
	<thead>
	  <tr>
		<th width="5%">STT</th>
		<th width="16%">Họ và tên</th>
		<th width="8%">ID</th>
		<th width="15%">Chức vụ</th>
		<th width="12%">Team</th>
		<th width="12%">Part</th>
		<th width="12%">Cell</th>
		<th width="12%">Ngày xác nhận</th>
		<th width="8%">Địa chỉ IP</th>
	  </tr>
	</thead>
	<tbody>
	  <c:forEach items="${pList }" var="item" varStatus="status">
		<tr onclick="return openPersonalDataConfirmDetail(this, event);">
			<td style="text-align:center;">${status.count}</td>
			<td style="text-align:left;">
				<a class="j-pdcDetail" href="/sys/notice/viewPersonalDataConfirmDetail?PERSON_ID=${item.PERSON_ID}" target="dialog" mask="true" width="800" height="640" title="Chi tiết xác nhận đồng ý xử lý dữ liệu cá nhân">${item.LOCAL_NAME }</a>
			</td>
			<td style="text-align:center;">${item.EMPID}</td>
			<td style="text-align:left;">${item.POSITION_NAME}</td>
			<td style="text-align:left;">${item.TEAM}</td>
			<td style="text-align:left;">${item.PART}</td>
			<td style="text-align:left;">${item.CELL}</td>
			<td style="text-align:center;">${item.CONFIRM_DATE}</td>
			<td style="text-align:center;">${item.IP}</td>
		</tr>
	  </c:forEach>
	</tbody>
</table>
<c:set value="/sys/notice/viewPersonalDataConfirmList" var="pageUrl"/>
<%@include file="/WEB-INF/view/inc/initPagination.jsp"%>
</div>
