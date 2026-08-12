<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript"> 
$(document).ready(function(){
	$("#insertMacTemporaryList_search",navTab.getCurrentPanel()).click(function(){
		$("#viewarcardtemporaryForm",navTab.getCurrentPanel()).submit();
	});
	$("#seach_KEY",navTab.getCurrentPanel()).keydown(function(e) {
        if ( e.keyCode == 13) {
       	 	var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       		$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewArCardTemporary&seach_KEY='+name);
       		$('.btnLook',navTab.getCurrentPanel()).click();
        }
    });
	$(".btnLook",navTab.getCurrentPanel()).click(function(e) {
       	 var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       	$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewArCardTemporary&seach_KEY='+name);
    });

	$(".list",navTab.getCurrentPanel()).dataTable({"bPaginate": false,    //关闭分页
	    "bAutoWidth":false,//表格宽度不自动变化
	    "bProcessing":false,
		"bLengthChange": false,  //关闭按多少条记录显示下拉框
		"bFilter": true,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
		"bSort": true,   //关闭排序功能
		"bInfo": false,   //不显示datatables的信息（底部的页数，条目数信息）
		"bScrollInfinite":true,
		"bAutoWidth": false,    //表格宽度不自动变化
		"scrollY": $(document.body).height() - 310,
        "scrollX": true,
        "orderClasses": false,
        "oLanguage": {
			//正在加载中......
	    	"sProcessing": "<spring:message code='ess.message.loading' />",
	    	//查询不到相关数据！
	        "sZeroRecords": "<spring:message code='ess.message.NOT_FOUND_DATA' />",
	        //表中无数据存在！
	        "sEmptyTable": "<spring:message code='ess.message.NOT_FOUND_DATA_FROM_TABLE' />",
	        //快速筛选
	        "sSearch": "<spring:message code='ess.message.rapid_screening' />"
        } //多语言配置
	});
});

function f_delete_viewarcardrecord(callback) {
	var checked=false;
	var ids= document.getElementsByName("c1");
	for(var i=0;i<ids.length;i++){
		if(ids[i].checked){
			checked=true;
		}
	}
	if(!checked){
		//请选择信息再进行删除操作!
		alert("<spring:message code='ar.alert.message.viewArAnnualStandard.choosedelete'/>");
		return;
	}
	var defaultCpny = $("#defaultCpny").val();
	//json传值
	var jsonData = '[';

	$.each($("input[name='c1']"),
	function(i, obj) {
		if (obj.checked) {
			
			if (jsonData.length > 1) {

				jsonData += ',{';
			} else {
				jsonData += '{';
			}

			jsonData += ' "APPLY_NO": "' + obj.value + '",';
			jsonData += ' "CPNY_ID": "${LoginUser.cpnyId}" ';
			jsonData += '}';

		}
	});
	jsonData += ']';

	if (jsonData.length == 2) {
		//请选择要删除的数据
		alertMsg.error("<spring:message code='ar.alert.message.viewArAnnualStandard.chooseinfo'/>");
		return;
	}
	//确定要提交吗？
	if (confirm ("<spring:message code='ar.alert.message.viewArAnnualStandard.consubmit'/>")){	
		$.ajax({
			type: 'POST',
			url: '/edu/traineducation/delTrainApplyInBatch',
			data: [{ name: 'jsonData', value: jsonData }],
			dataType:"json",
			cache: false,
			success: callback || DWZ.ajaxDone,
			error: DWZ.ajaxError
		});	
	}
}

</script>
<a id="importExcel_ar0104"  href="#" target="navTab" mask="true"><span style="display:none;"><!--刷卡维护数据导入结果--><spring:message code="ess.infoApply.cardinsertmodify" /> </span></a>
<div class="pageHeader">
	<form id="viewarcardtemporaryForm" onsubmit="return navTabSearch(this);" action="/edu/traineducation/viewRegisterForTraining" method="post">
		<input type="hidden" name='CPNY' value="${LoginUser.cpnyId }"/>
		<div class="searchBar">
			<table class="searchContent">
				
				<tr>
				    <td><spring:message code="ess.infoApply.attendance_type" /><!--考勤类型--></td>	 
					<td>
						<ait:SelectSyCodeByCpnyID name="seach_TRAINING_TYPE" parentNo="1682" limit="all" selected="${TRAINING_TYPE}"/>
					</td>
				</tr>
			</table>
		</div>
	</form>	
</div>
<div class="pageContent">
	<div class="formBar">
		<ul class="toolBar">
			<li>	            
				<a class="buttonActive" id="insertMacTemporaryList_search" href="#"><span><!-- 查询 --><spring:message code="hrm.empinfo.QUERY"/></span></a> 
			</li>	
			<li>
				<a class="buttonActive" href="/edu/traineducation/RegisterForTrainingView" target="dialog" mask="true" width="1200" height="600" rel="addArCardTemporaryInfoView"><span><!-- 添加 --><spring:message code="ess.empInfo.insert"/></span></a>
			</li>
			<%-- <li>
				<a class="buttonActive" href="#" onclick="javascript:f_delete_viewarcardrecord(navTabAjaxDoneWithForm);"><span><!-- 删除 --><spring:message code="ess.empInfo.Delete"/></span></a>
			</li> --%>
	</ul>
</div>
	<div class="user_table" style="font:bold 12px/20px arial,sans-serif;">Total:${fn:length(getArCardTemporaryList)}</div>
	<table class="list" width="99%">
		<thead>
			<tr>
				<th rowspan="2">No.</th>
				<th rowspan="2"><input type="checkbox" class="checkboxCtrl" group="c1"></th>
				<th rowspan="2"><!-- 工号 --><spring:message code="ess.affirmApply.title.remark.shenpizhuangtai"/></th>
				<th rowspan="2"><!-- 工号 --><spring:message code="ess.empInfo.apply_content"/> <spring:message code="hr.viewCondSql.title.PEIXUNXINXI"/></th>
				<th rowspan="2"><!-- 工号 --><spring:message code="hr.viewGoAbroad.title.PURPOSE"/> <spring:message code="hr.viewCondSql.title.PEIXUNXINXI"/></th>
				<th rowspan="2"><!-- 工号 --><spring:message code="edu.systemManager.PEIXUNLEIXING.a"/> <spring:message code="hr.viewCondSql.title.PEIXUNXINXI"/></th>
				<th rowspan="2"><!-- 类型 --><spring:message code="empsubject.eduRm"/></th>
				<th rowspan="2"><!-- 类型 --><spring:message code="hr.viewTraining.title.INSTITUTION_NAME"/></th>
				<th colspan="3"><!-- 类型 --><spring:message code="liang.hr.viewTraining.title.TRAINING_TIME"/></th>
				<th colspan="4"><!-- 类型 --><spring:message code="edu.viewTrainEducation.FEIYONGGUANLI.a"/></th>
				<th rowspan="2"><!-- 类型 --><spring:message code="edu.trainCostMANAGER.QITAFEIYONG.a"/></th>
				<th rowspan="2"><!-- 类型 -->TOTAL FEES</th>
				<th rowspan="2"><!-- 类型 -->NOTE</th>
			</tr>
			
			<tr>
			<th ><spring:message code="ess.infoApply.title.applyTime"/></th>
			<th ><spring:message code="ess.infoApply.title.endTime"/></th>
			<th ><spring:message code="ess.infoApply.withoutWork_days"/></th>
			<th >Unit(VND/USD)</th>
			<th >Training Fee/Đơn giá</th>
			<th >Trainee/Q'Ty/Số lượng</th>
			<th >Amount/ Thành tiền</th>
			</tr>
		</thead>
			<c:forEach items="${getRegisterForTrainingList}" var="a" varStatus="i">
				<tr target="sid" rel="${personInfo.PERSON_ID}">
					<td>${i.count}</td>
					<td style="text-align: center">
					         <input name="CPNY_ID" id="CPNY_ID" type="hidden" value="${LoginUser.cpnyId}"/>
					         <c:if test="${a.AFFIRM_FLAG eq ''}">
						    	<input type="checkbox" id="c1" name="c1" value="${a.APPLY_NO}" />
						    </c:if>
					    </td>
                <td style="text-align: center" ><span style="color: blue">${a.AFFIRM_FLAG_NAME}</span></td>
					<td>${a.TRAINING_CONTENT}</td>
					<td>${a.TRAINING_PURPOSE}</td>
					<td>${a.TRAINING_TYPE_NAME}</td>
					<td>${a.TRAINING_UNIT}</td>
					<td>${a.TRAINING_LOCATION}</td>
					<td>${a.START_DATE}</td>
					<td>${a.END_DATE}</td>
					<td>${a.TRAIN_FEE}</td>
					<td>${a.TRAIN_UNIT}</td>
					<td>${a.TRAIN_TRAINEE}</td>
					<td>${a.TRAIN_PRICE}</td>
					<td>${a.TRAIN_AMOUNT}</td>
					<td>${a.TRAIN_FEES_OTHER}</td>
					<td>${a.TRAIN_FEES_TOTAL}</td>
					<td>${a.REMARK}</td>
				</tr>
			</c:forEach>			
	</table>
</div>
