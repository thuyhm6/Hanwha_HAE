<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
 

$('#allCheck').click(function(){  
    $('input[name="check"]').prop("checked",this.checked);  
});
function baocun1(){
	var sNo= "";
	var sName="";
	 $("#eduSubjectTable input[name=check]").each(function(){ //遍历table里的全部checkbox
	        if($(this).attr("checked")){ //如果被选中
	        	sNo += $(this).val() + ",";
	        	sName +=$(this).attr('valuename') +",";
	        	
	        } //获取被选中的值
	    });
	 	 sNo=sNo.substring(0,sNo.length-1);
	 	 sName=sName.substring(0,sName.length-1);
		 $('#subject').html(sName);
         $('#SUBJECT_NO').attr('value',sNo);
         $('#SUBJECT_NAME').attr('value',sName);
         $.pdialog.closeCurrent();
	 
}
function quxiao1(){
	 $.pdialog.closeCurrent();
}
function childCheck1(count){
	
	var ischeck=$('#check_'+count).prop('checked');
	if(ischeck==true){
		$('#check_'+count).removeAttr('checked');
	}else{
		$('#check_'+count).attr('checked','checked');
	}
} 
</script>
<div class="pageContent" layoutH="10">
                <ul style="padding-left: 470px;">
					<li>
						<a class="buttonActive" href="#" onclick="baocun1()">
							<span><spring:message code="hrm.empinfo.CONFIRM"/><!--确定--></span>
						</a>
					</li>
					<li >
						<a class="buttonActive"  href="#" onclick="quxiao1()">
							<span><spring:message code="hrm.empinfo.CANCLE"/><!--取消--></span>
						</a>
					</li>
				</ul>
		<table id="eduSubjectTable" class="user_table" width="100%" border="1" cellpadding="2" cellspacing="1" >
		<tr>
		<td class="td_title" width="5%"><input type="checkbox" name="allCheck" id="allCheck" checked="checked">NO</td>
		<td class="td_title" width="5%"><spring:message code="ess.infoApply.EMP_ID"/><!--工号--></td>
		<td class="td_title" width="5%"><spring:message code="org.title.LOCAL_NAME"/><!--姓名--></td>
		</tr>
		<c:forEach items="${eduSubject}" var="d" varStatus="i">
		<tr onclick="childCheck1('${d.SUBJECT_NO }')">
		<td class="td_type"  width="5%" ><input type="checkbox" onclick="childCheck1('${d.SUBJECT_NO }')" id="check_${d.SUBJECT_NO }" name="check" value="${d.SUBJECT_NO }" valuename="${d.SUBJECT_NAME }">${i.count }</td>
		<td class="td_type"  width="5%" >${d.SUBJECT_NO }</td>
		<td class="td_type"  width="5%" >${d.SUBJECT_NAME }</td>
		</tr>
		</c:forEach>
		</table>
		<div class="subBar" style="padding-left: 650px;">
		
				</div>
</div>
