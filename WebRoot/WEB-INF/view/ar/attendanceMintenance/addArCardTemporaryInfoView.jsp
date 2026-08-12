<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript">
function validateCallback_addarcardtemporaryinfoview(form, callback) {

	document.addarcardtemporaryinfoview.PERSON_ID.value = document.addarcardtemporaryinfoview.personId.value;
	
	if(document.addarcardtemporaryinfoview.PERSON_ID.value == ''){
		//工号不能为空
		alertMsg.error("<spring:message code='ar.viewarcardrecord.title.empidnotnull'/>");
		return false;
	}

	var $form = $(form);
	
	if (!$form.valid()) {
		return false;
	}
	
	$.ajax({
		type: form.method || 'POST',
		url:$form.attr("action"),
		data:$form.serializeArray(),
		dataType:"json",
		cache: false,
		success: callback || DWZ.ajaxDone,
		error: DWZ.ajaxError
	});
	
	return false;
}
</script>
<div class="pageContent">
	<form id="addarcardtemporaryinfoview" name="addarcardtemporaryinfoview" method="post" action="/ar/attendanceMintenance/addArCardTemporaryInfo" 
		class="pageForm required-validate" onsubmit="return validateCallback_addarcardtemporaryinfoview(this,dialogAjaxDoneWithForm);">
			<div class="pageFormContent nowrap" layoutH="56">
				<div class="formBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><!-- 提交 --><spring:message code="public.title.submit"/></button></div></div></li>
					<li><div class="button"><div class="buttonContent"><button type="button" class="close"><!-- 取消 --><spring:message code="public.title.cancle"/></button></div></div></li>
				</ul>
			</div>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="lge_table">
			<tr>
				<td class="td_title">
					<!-- 工号 --><spring:message code="hrm.empinfo.ACCOUNT_NO.Z"/>
				</td>
				<td class="td_type">
					<input name="CARD_NO" cols="50" rows="1"/>
				</td>
			</tr>
			<tr>
				<td class="td_title">
					<!-- 工号 --><spring:message code="hr.viewPersonalInfo.title.EMPID"/>
				</td>
				<td class="td_type">
					<input id="PERSON_ID" name="PERSON_ID" value="" type="hidden"/>
					<input id="personId" name="dwz.person.personId" value="" type="hidden" lookupGroup="person"/>
					<input name="dwz.person.empId" type="text" class="required" readOnly lookupGroup="person"/>
					<a class="btnLook" href="/ar/attendanceMintenance/viewEmpCalendarList?firstFlag=1&limit=ar&pageNum=1" lookupGroup="person">
					<!-- 查找带回 --><spring:message code="ar.alert.message.viewattendencekeeper.chazhaodaihui"/></a>
				</td>
			</tr>
			<tr>
				<td class="td_title">
					<!-- 类型 --><spring:message code="ar.viewarcardrecord.title.leixing"/>
				</td>
				<td class="td_type">
					<select id="ACTIVITY" name="ACTIVITY">
						<option value="1"><!-- Yes --><spring:message code="empsubject.useY"/></option>
						<option value="0"><!-- No --><spring:message code="empsubject.useN"/></option>
					</select>
				</td>
			</tr>
		</table>	
		</div>
		
	</form>
</div>
