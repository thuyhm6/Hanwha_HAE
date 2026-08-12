<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@include file="newheader.jsp" %>
<tr    height= "50" onMouseOver=this.style.backgroundColor="#F7F7F7" onMouseOut=this.style.backgroundColor="FFFFFF">
	<td width="15%" align="center">
AR_START_MONTH	</td>
	<td width="25%" align="center">
AR_START_MONTH	</td>
<td width="25%" align="center">
Start_Date</td>
<td width="35%">
<input type="text" name="AR_START_MONTH"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy/MM',lang:'en'})"/></td>
</tr>
<tr    height= "50" onMouseOver=this.style.backgroundColor="#F7F7F7" onMouseOut=this.style.backgroundColor="FFFFFF">
	<td width="15%" align="center">
AR_END_MONTH	</td>
	<td width="25%" align="center">
AR_END_MONTH	</td>
<td width="25%" align="center">
End_Date</td>
<td width="35%">
<input type="text" name="AR_END_MONTH"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy/MM',lang:'en'})"/></td>
</tr>
<%@include file="newfooter.jsp" %>
