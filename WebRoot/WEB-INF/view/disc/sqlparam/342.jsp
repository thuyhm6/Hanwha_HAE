<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@include file="newheader.jsp" %>
<tr    height= "50" onMouseOver=this.style.backgroundColor="#F7F7F7" onMouseOut=this.style.backgroundColor="FFFFFF">
	<td width="15%" align="center">
PAY_SCHEDULE_NO_BEFORE	</td>
	<td width="25%" align="center">
payScheduleBefore	</td>
<td width="25%" align="center">
payScheduleBefore</td>
<td width="35%">
<ait:SelectPayScheduleNo name="PAY_SCHEDULE_NO_BEFORE" id="PAY_SCHEDULE_NO_BEFORE"></ait:SelectPayScheduleNo></td>
</tr>
<tr    height= "50" onMouseOver=this.style.backgroundColor="#F7F7F7" onMouseOut=this.style.backgroundColor="FFFFFF">
	<td width="15%" align="center">
PAY_SCHEDULE_NO_CURRENT	</td>
	<td width="25%" align="center">
payScheduleCurrent	</td>
<td width="25%" align="center">
payScheduleCurrent</td>
<td width="35%">
<ait:SelectPayScheduleNo name="PAY_SCHEDULE_NO_CURRENT" id="PAY_SCHEDULE_NO_CURRENT"></ait:SelectPayScheduleNo></td>
</tr>
<%@include file="newfooter.jsp" %>
