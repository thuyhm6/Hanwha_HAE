<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
 $(document).ready(function(){
	     var empid="";
	    if("${flag}"=="2"){
	    	empid="${finalempid2}";
	    }else{
	    	empid="${finalempid1}";
	    }
		if(empid!=''){
			var array=empid.split(',');
			for(var i=0;i<array.length;i++){
				$('#teaCheck_'+array[i]).attr('checked','checked');
			}
		}
		
});

$('#teaAllCheck').click(function(){  
    $('input[name="teaCheck"]').prop("checked",this.checked);  
});
function baocun1(){
	var empid= "";
	var localname="";
	 $("#tearcherTable input[name=teaCheck]").each(function(){ //遍历table里的全部checkbox
	        if($(this).attr("checked")){ //如果被选中
	        	    empid += $(this).val() + ",";
	        	    localname +=$(this).attr('valuename') +",";
	        	
	        } //获取被选中的值
	    });
		 empid=empid.substring(0,empid.length-1);
		 localname=localname.substring(0,localname.length-1);
		 $('#finalstudent').html(localname);
         $('#FINAL_STUDENT_NAME').attr('value',localname);
         $('#FINAL_STUDENT_EMPID').attr('value',empid);
         $('#finalcount').html(splitMethod(empid)+splitMethod("${checkplanempid}"));
         $.pdialog.closeCurrent();
	 
}
function quxiao1(){
	 $.pdialog.closeCurrent();
}
function childCheck1(count){
	
	var ischeck=$('#teaCheck_'+count).prop('checked');
	if(ischeck==true){
		$('#teaCheck_'+count).removeAttr('checked');
	}else{
		$('#teaCheck_'+count).attr('checked','checked');
	}
} 
</script>
<div class="pageContent" layoutH="10">
          <ul style="padding-left: 470px;"></ul>
          <div style="padding-left:10px;padding-right:10px;padding-top:10px;padding-bottom:10px;">
		<table id="tearcherTable" class="user_table" width="100%" border="1" cellpadding="2" cellspacing="1" >
		<span style="font:bold 14px/20px arial,sans-serif;float:left;height:20px;line-height:20px;">
		<spring:message code="edu.studentEvaluate.SUBJECT_NO.a"/>, <spring:message code="edu.trainreport.KECHENGQUFEN.a"/> - <spring:message code="edu.studentEvaluate.PARTICIPATED.a"/></span>
		<span style="font:bold 14px/20px arial,sans-serif;float:left;height:20px;line-height:20px;"> :${empTrainInfoWithSubjectCnt }</span>
		<tr>
		<td class="td_title" width="1%"><input type="checkbox" name="teaAllCheck" id="teaAllCheck" >NO</td>
		<td class="td_title" width="3%"><spring:message code="hrm.empinfo.TRAIN_curriculum"/><!--培训课程--></td>
		<td class="td_title" width="2%"><spring:message code="edu.planManager.SHISHIRIQI.a"/><!--实施日期--></td>
		<td class="td_title" width="2%"><spring:message code="hrm.empinfo.Valid_date"/><!--到期日期--></td>
		<td class="td_title" width="1%"><spring:message code="edu.studentEvaluate.SUBJECT_NO.a"/><!--主题号--></td>
        <td class="td_title" width="5%"><spring:message code="edu.studentEvaluate.SUBJECT_NAME.a"/><!--主题名称--></td>
		</tr>
		<c:forEach items="${empTrainInfoWithSubject}" var="d" varStatus="i">
		<tr >
		<td class="td_type"  width="1%" >${i.count }</td>
		<td class="td_type"  width="3%">
		<span style="color: blue">${d.COURSE_NAME_CODE }&nbsp&nbsp(<spring:message code="edu.planManager.QI.a"/><!--期-->
		&nbsp<spring:message code="ar.alert.message.excelimport.title.di"/>&nbsp<!--第-->${d.PERIOD_TIME })</span>
		</td>
		<td class="td_type"  width="2%">${d.PLAN_STARTDATE }~${d.PLAN_ENDDATE }</td>
		<td class="td_type"  width="2%">${d.VALID_DATE }</td>
		<td class="td_type"  width="1%">${d.SUBJECT_NO }</td>
		<td class="td_type"  width="5%">${d.SUBJECT_NAME }</td>
		</tr>
		</c:forEach>
		</table>
		</div>
		<div style="padding-left:10px;padding-right:10px;padding-top:10px;padding-bottom:10px;">
		<table id="tearcherTable" class="user_table" width="100%" border="1" cellpadding="2" cellspacing="1" >
		<span style="font:bold 14px/20px arial,sans-serif;float:left;height:20px;line-height:20px;">
		<spring:message code="edu.studentEvaluate.SUBJECT_NAME.a"/> - <spring:message code="edu.studentEvaluate.NOT_PARTICIPATE.a"/></span>
		<span style="font:bold 14px/20px arial,sans-serif;float:left;height:20px;line-height:20px;"> :${empTrainInfoWithSubject_NotStudyCnt }</span>
		<tr>
		<td class="td_title" width="1%"><input type="checkbox" name="teaAllCheck" id="teaAllCheck" >NO</td>
		<td class="td_title" width="10%"><spring:message code="edu.studentEvaluate.SUBJECT_NO.a"/><!--主题号--></td>
        <td class="td_title" width="10%"><spring:message code="edu.studentEvaluate.SUBJECT_NAME.a"/><!--主题名称--></td>
		</tr>
		<c:forEach items="${empTrainInfoWithSubject_NotStudy}" var="d" varStatus="i">
		<tr >
		<td class="td_type"  width="1%" >${i.count }</td>
		<td class="td_type"  width="10%">${d.SUBJECT_NO }</td>
		<td class="td_type"  width="10%">${d.SUBJECT_NAME }</td>
		</tr>
		</c:forEach>
		</table>
		</div>
		<div class="subBar" style="padding-left: 650px;"></div>
</div>
