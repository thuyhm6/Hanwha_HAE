<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript"> 
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

			jsonData += ' "RECORD_NO": "' + obj.value + '",';
			jsonData += ' "CPNY_ID": "' + defaultCpny + '"';
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
			url: '/ar/attendanceMintenance/deleteArCardRecordInfo',
			data: [{ name: 'jsonData', value: jsonData }],
			dataType:"json",
			cache: false,
			success: callback || DWZ.ajaxDone,
			error: DWZ.ajaxError
		});	
	}
}

function exportArCardRecordExcel(obj){

	var condition = document.viewarcardrecord.seach_condition.value;;
	var deptNO = document.viewarcardrecord.seach_deptNO.value;;
	var STIME = document.viewarcardrecord.seach_STIME.value;;
	var RTIME = document.viewarcardrecord.seach_RTIME.value;;
	var DoorType = document.viewarcardrecord.seach_DoorType.value;;
	var RecordSource = document.viewarcardrecord.seach_RecordSource.value;;

	document.getElementById("exportArCardRecordExcel").href="/pa/excelExport/exportArCardRecordExcel?condition="+condition
				+"&deptNO="+deptNO+"&STIME="+STIME+"&RTIME="+RTIME+"&DoorType="+DoorType+"&RecordSource="+RecordSource;
	document.getElementById("exportArCardRecordExcel").click();

}
function insertMacRecordListLGE(form,callback,flag){
    var $form=null;
	if($('#'+form).length>0)
		$form=$('#'+form);
	else
 		$form = $(form);
	
	if (!$form.valid()) {
		return false;
	}
    var STIME = document.viewarcardrecord.seach_STIME.value;
	var RTIME = document.viewarcardrecord.seach_RTIME.value;
	var EMPID = document.viewarcardrecord.seach_condition.value;
    $form.attr("action","/ar/attendanceMintenance/insertMacRecordListLGE?STIME="+STIME+"&RTIME="+RTIME+"&EMPID="+EMPID);
    $.ajax({
		type: form.method || 'POST',
		url:$form.attr("action"),
		data:$form.serializeArray(),
		dataType:"json",
		cache: false,
		success: function(data){ //请求成功后处理函数。
			if(data.statusCode=="200"){
				navTabSearch("searchLeaveApplyAffirmForm");
				alertMsg.correct(data.message);
			}else{
				if(data.result=="2"){
					alertMsg.info(data.message);
				}else{
					alertMsg.error(data.message);
				}
			}   
   	 	}  ,
		error: DWZ.ajaxError
	});
}

</script>
<a id="importExcel_ar0104"  href="#" target="navTab" mask="true"><span style="display:none;">刷卡维护数据导入结果</span></a>
<div class="pageHeader">
	<form id="viewarcardrecord" name="viewarcardrecord" onsubmit="return navTabSearch(this);" action="/ar/attendanceMintenance/viewArCardRecordForSelf" method="post" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td><!-- 开始日期 --><spring:message code="ar.viewcycleparameter.title.kaishiriqi"/></td>
					<td>
						<input type="text" id="seach_STIME" name="seach_STIME" value="${STIME}" class="date required"
										yearstart="-20" yearend="20" readonly="true" />
										<a class="inputDateButton"><spring:message code="public.title.choose"/><!-- 选择 --></a>
					</td>
					<td><!-- 结束日期 --><spring:message code="ar.viewcycleparameter.title.jieshuriqi"/></td>
					<td>
						<input type="text" id="seach_RTIME" name="seach_RTIME" value="${RTIME}" class="date required"
										yearstart="-20" yearend="20" readonly="true" />
										<a class="inputDateButton"><spring:message code="public.title.choose"/><!-- 选择 --></a>
					</td>
				</tr>
			</table>
			<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><!-- 检索 --><spring:message code="public.title.search"/></button></div></div></li>
			</ul>
			</div>
			 
		</div>
	</form>	
</div>
<div class="pageContent">
	
	<table class="table" width="100%" layoutH="180">
		<thead>
			<tr>
				<th width="6%"><!-- 工号 --><spring:message code="public.title.empId"/></th>
				<th width="6%"><!-- 姓名 --><spring:message code="public.title.name"/></th>
				<th width="12%"><!-- 部门 --><spring:message code="public.title.deptName"/></th>
				<th width="15%"><!-- 时间 --><spring:message code="ar.viewarcardrecord.title.shijian"/></th>
				<th width="4%">星期</th>
				<th width="6%"><!-- 类型 --><spring:message code="ar.viewarcardrecord.title.leixing"/></th>
				<th width="5%"><!-- 数据来源 --><spring:message code="ar.viewarcardrecord.title.shujulaiyuan"/></th>
				<th width="38%"><!-- 备注 --><spring:message code="ar.viewarcardrecord.title.beizhu"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${getArCardRecordList}" var="list" varStatus="i">
			
				<tr target="RECORD_NO" rel="${list.RECORD_NO}">
					<td  >${list.EMPID}</td>
					<td  >${list.LOCAL_NAME}</td>
					<td  >${list.DEPTNAME}</td>
					<td  >${list.R_TIME}</td>
					<td  >${list.ATT_WEEK}</td>
					<td>${list.DOOR_TYPE}</td>
					<td>
						<c:if test="${list.INSERT_BY eq 'M'}"><!-- 自动 --><spring:message code="ar.viewarcardrecord.title.zidong"/></c:if>
						<c:if test="${list.INSERT_BY eq 'H'}"><!-- 手动 --><spring:message code="ar.viewarcardrecord.title.shoudong"/></c:if>
						<c:if test="${list.INSERT_BY eq 'APPLY'}">申请</c:if>
					</td>
					<td  >${list.REMARK}</td>
				</tr>
			</c:forEach>			
			<input type="hidden" id="defaultCpny" name="defaultCpny" value="${defaultCpny}" />
		</tbody>
	</table>
	<c:set value="/ar/attendanceMintenance/viewArCardRecordForSelf" var="pageUrl"/>
	<%@ include file="/WEB-INF/view/inc/initPagination.jsp"%>
</div>
