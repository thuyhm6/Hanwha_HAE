<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<div class="pageContent">
	<form id="updateMeetingRoomView" method="post" action="/hrm/empinfo/updateMeetingRoomInfo" class="pageForm required-validate" onsubmit="return validateCallback(this,dialogAjaxDoneWithForm);">
		
		<input type="hidden" id="ROOM_NO" name="ROOM_NO" value="${updateMeetingRoom.ROOM_NO}"/>
		<input type="hidden" id="PERSON_ID" name="PERSON_ID" value="${updateMeetingRoom.PERSON_ID}"/>
		
		<div class="pageFormContent nowrap" layoutH="56">
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><!-- 提交 --><spring:message code="public.title.submit"/></button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close"><!-- 取消 --><spring:message code="public.title.cancle"/></button></div></div></li>
			</ul>
		</div>
		<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="user_table margin_b">
			<tr>
				<td class="td_title"><spring:message code="ga.meetingRoom.DAY"/><!-- 标题 --></td>
				<td class="td_type">
				<input type="text" name="ROOM_DATE" id="ROOM_DATE" value="${updateMeetingRoom.ROOM_DATE }" class="Wdate required" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
				</td>
			</tr>
			<tr>
				<td class="td_title"><spring:message code="ga.meetingRoom.DATE"/><!-- 标题 --></td>
				<td class="td_type">
				<ait:time name="ROOM_FROM_TIME" spacing="30" selected="${updateMeetingRoom.ROOM_FROM_TIME}" onChange="calPoTLengthEdit();getChangeOtType();"/>	
				<ait:time name="ROOM_TO_TIME" spacing="30" selected="${updateMeetingRoom.ROOM_TO_TIME}" onChange="calPoTLengthEdit();getChangeOtType();"/>		
				</td>
			</tr>
			<tr>
				<td class="td_title"><spring:message code="hr.viewPersonalInfo.title.EMPID"/><!-- 标题 -->(<spring:message code="ga.meetingRoom.CHAIRED_THE_MEETING"/>)</td>
				<td class="td_type">
					<input id="PERSON_ID" name="PERSON_ID" value="" type="hidden"/>
					<input id="personId" name="dwz.person.personId" value="" type="hidden" lookupGroup="person"/>
					<input name="dwz.person.empId" type="text" class="required" readOnly lookupGroup="person" value="${updateMeetingRoom.EMPID }"/>
					<a class="btnLook" href="/ar/attendanceMintenance/viewEmpCalendarList?firstFlag=1&limit=ar&pageNum=1" lookupGroup="person">
					<!-- 查找带回 --><spring:message code="ar.alert.message.viewattendencekeeper.chazhaodaihui"/></a>
				</td>
			</tr>
			<tr>
				<td class="td_title"><spring:message code="public.title.name"/><!-- 标题 -->(<spring:message code="ga.meetingRoom.CHAIRED_THE_MEETING"/>)</td>
				<td class="td_type">
				${updateMeetingRoom.LOCAL_NAME}
				</td>
			</tr>
			<tr>
					<td class="td_title" style="width:122px"><spring:message code="hrm.empinfo.PARTICIPANTS"/><!-- 公告内容 --></td>
					<td class="td_type">
						<textarea style="width:400px;height:200px" name="EMPLOYEE_LIST" class="editor" tools="Cut,Copy,Paste,|,Fullscreen">${updateMeetingRoom.EMPLOYEE_LIST }</textarea>
					</td>
			</tr>
			<tr>
					<td class="td_title" style="width:122px"><spring:message code="hr.viewAdditional.title.REMARK"/><!-- 公告内容 --></td>
					<td class="td_type">
						<textarea style="width:400px;height:200px" name="REMARK" class="editor" tools="Cut,Copy,Paste,|,Fullscreen">${updateMeetingRoom.REMARK }</textarea>
					</td>
			</tr>
			<tr>
				<td class="td_title"><spring:message code="ar.monthwork.title.RemindDate"/><!-- 标题 --></td>
				<td class="td_type">
				<input type="text" name="ROOM_END_DATE" id="ROOM_END_DATE" value="${updateMeetingRoom.ROOM_END_DATE }" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
				</td>
			</tr>
			<tr>
				<td class="td_title"><!-- Level of importance --><spring:message code="ga.meetingRoom.levelOfImportance"/></td>
				<td class="td_type">
					<ait:SelectSyCodeByCpnyID name="LEVEL_IMPORTANCE" selected="${updateMeetingRoom.LEVEL_IMPORTANCE}" parentNo="14015488" limit="all" />
				</td>
			</tr>
			</table>
		</div>
		
	</form>
</div>
