<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">

</script>
<div class="pageContent" layoutH="10" id=courseSubjectsInfo">
	<form method="post"  action="/edu/traineducation/updatecourseSubjects" class="pageForm required-validate" onsubmit="return validateCallback(this,dialogAjaxDone);">
		<div class="pageFormContent nowrap">
		<input type="hidden" name="SUBJECT_ID" id="SUBJECT_ID" value="${courseSubjectsInfo.SUBJECT_ID }">
		<table  class="user_table" width="100%" border="1" cellpadding="2" cellspacing="1" >
		<tr>
		<td class="td_title" width="1%"><spring:message code="edu.studentEvaluate.SUBJECT_NO.a"/><!--主题--></td>
		<td class="td_type"  width="20%">
		<input type="text" class="required" name="SUBJECT_NO" id="SUBJECT_NO" value="${courseSubjectsInfo.SUBJECT_NO }">
		</td>
		</tr>
		<tr>
		<td class="td_title" width="1%"><spring:message code="edu.studentEvaluate.SUBJECT_NAME.a"/><!--主题名称--></td>
		<td class="td_type"  width="20%">
		<input size="100" type="text" class="required" name="SUBJECT_NAME" id="SUBJECT_NAME" value="${courseSubjectsInfo.SUBJECT_NAME }">
		</td>
		</tr>
		<tr >
			<td class="td_title" width="1%"><spring:message code="hrm.empinfo.MAIN_BUSINESS_NAME" /><!-- 主要业务 --></td>
			<td class="td_type" width="20%">
			    <ait:selectCodeMulti id="seach_MAIN_BUSINESS" name="seach_MAIN_BUSINESS_NAME" parentNo="14013573" selected="${MAIN_BUSINESS}" selectedNm="${MAIN_BUSINESS_NAME}"/>
			</td>
		</tr>
		<tr style="height:300px">
			<td class="td_title" ></td>
			<td class="td_type">
			<input type="hidden" id="seach_MAIN_BUSINESS_OLD" name="seach_MAIN_BUSINESS_OLD" value="${courseSubjectsInfo.MAIN_BUSINESS }">
			<input type="hidden" id="seach_MAIN_BUSINESS_NAME_OLD" name="seach_MAIN_BUSINESS_NAME_OLD" value="${courseSubjectsInfo.MAIN_BUSINESS_NAME }">
			</td>
		</tr>
		</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><!-- 提交 --><spring:message code="public.title.submit"/></button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close"><!-- 取消 --><spring:message code="public.title.cancle"/></button></div></div></li>
			</ul>
		</div>
	</form>
</div>
