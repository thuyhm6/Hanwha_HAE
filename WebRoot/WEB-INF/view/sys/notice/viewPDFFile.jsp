<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<div class="pageContent" layouth="10">
<div style="width:530px;height:50px;font-size:12px;padding-right:15px;padding-left:15px;line-height:20px;margin-top:30px">${fileName}</div>
<div>
	<iframe src="${fileURl}#toolbar=0" width="100%" height="900px"></iframe>
</div>
</div>