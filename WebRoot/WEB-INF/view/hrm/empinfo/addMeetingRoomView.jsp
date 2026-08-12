<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript">
function validateCallback_addMeetingRoomView(form, callback) {

	document.addMeetingRoomView.PERSON_ID.value = document.addMeetingRoomView.personId.value;
	
	if(document.addMeetingRoomView.PERSON_ID.value == ''){
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
	<form id="addMeetingRoomView" name="addMeetingRoomView" method="post" action="/hrm/empinfo/addMeetingRoomInfo" 
		class="pageForm required-validate" onsubmit="return validateCallback_addMeetingRoomView(this,dialogAjaxDoneWithForm);">
			<div class="pageFormContent nowrap" layoutH="56">
				<div class="formBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><!-- 提交 --><spring:message code="public.title.submit"/></button></div></div></li>
					<li><div class="button"><div class="buttonContent"><button type="button" class="close"><!-- 取消 --><spring:message code="public.title.cancle"/></button></div></div></li>
				</ul>
			</div>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="user_table">
			<tr>
					<td class="td_title"><spring:message code="ga.meetingRoom.DAY"/><!-- 发布日期 --></td>
					<td class="td_type">
			            <input type="text" name="ROOM_DATE" id="ROOM_DATE" value="" class="Wdate required" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
					</td>
				</tr>
				<tr>
					<td class="td_title"><spring:message code="ga.meetingRoom.DATE"/><!-- 发布日期 --></td>
					<td class="td_type">
			            <ait:time name="ROOM_FROM_TIME" spacing="15" selected="08:00" onChange="getOtLengthSST(0);"/>
						<ait:time name="ROOM_TO_TIME" spacing="15" selected="17:00" onChange="getOtLengthSST(0);"/>
					</td>
				</tr>
			<tr>
				<td class="td_title">
					<!-- 工号 --><spring:message code="hr.viewPersonalInfo.title.EMPID"/>(<spring:message code="ga.meetingRoom.CHAIRED_THE_MEETING"/>)
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
				<td class="td_title"><!-- 姓名 --><spring:message code="public.title.name"/>(<spring:message code="ga.meetingRoom.CHAIRED_THE_MEETING"/>)</td>
				<td class="td_type">
					<input id="empName" name="dwz.person.empName" value="" readOnly type="text" lookupGroup="person"/>
				</td>
			</tr>
			<tr>
					<td class="td_title" style="width:122px"><spring:message code="hrm.empinfo.PARTICIPANTS"/><!-- 公告内容 --></td>
					<td class="td_type">
						<textarea style="width:400px;height:150px" name="EMPLOYEE_LIST"
						 class="editor" tools="Cut,Copy,Paste,|,Fullscreen"></textarea>
					</td>
				</tr>
			<tr>
					<td class="td_title" style="width:122px"><spring:message code="hr.viewAdditional.title.REMARK"/><!-- 公告内容 --></td>
					<td class="td_type">
						<textarea style="width:400px;height:200px" name="REMARK"
						 class="editor" tools="Cut,Copy,Paste,|,Fullscreen"></textarea>
					</td>
				</tr>
				 <tr>
				<td class="td_title">
					<!-- 工号 --><spring:message code="ar.monthwork.title.RemindDate"/>
				</td>
				<td class="td_type">
			            <input type="text" name="ROOM_END_DATE" id="ROOM_END_DATE" value="" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
					</td>
			</tr> 
			<tr>
				<td class="td_title"><!-- Level of importance --><spring:message code="ga.meetingRoom.levelOfImportance"/></td>
				<td class="td_type">
					<ait:SelectSyCodeByCpnyID name="LEVEL_IMPORTANCE" parentNo="14015488" limit="all" />
				</td>
			</tr>
		</table>	
		</div>
		
	</form>
</div>
