<%@ page contentType="text/html; charset=UTF-8" language="java"errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	/* $("#onlyForm").attr("action",'${param.actionUrl}'
								  +"?SUBSD_CD="+'${param.SUBSD_CD}'
	                              +"&JOB_TP="+'${param.JOB_TP}'
	                              +"&ATT_MON="+'${param.ATT_MON}'
	                              +"&reportName="+'${param.reportName}'
	                              +"&SUBSD_NAME="+'${param.SUBSD_NAME}'
	                              +"&ORG_ID="+'${param.ORG_ID}'
	                              +"&suffix="+'${param.suffix}'); */
	var params = '${param.params}';
	params = params.replaceAll("@", "&");
	
	$("#onlyForm").attr("action",'${param.actionUrl}'
	    								  +"?params="+params);
	$("#onlyForm").attr("target","result");
	$("#onlyForm").submit(); 
});
</script>
<form action="" id="onlyForm" rel="htmlReport" method="post"></form>
<iframe name=result id=result width=100% height=100% frameborder=0 scrolling=auto src="/resources/reportFile/blank.html"></iframe>
