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
       		$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewArCardRecord&seach_KEY='+name);
       		$('.btnLook',navTab.getCurrentPanel()).click();
        }
    });
	$(".btnLook",navTab.getCurrentPanel()).click(function(e) {
       	 var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       	$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewArCardRecord&seach_KEY='+name);
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

			jsonData += ' "RECORD_NO": "' + obj.value + '",';
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
			url: '/ar/attendanceMintenance/deleteArCardRecordInfo',
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
	<form id="viewarcardtemporaryForm" onsubmit="return navTabSearch(this);" action="/ar/attendanceMintenance/viewArCardTemporary?firstFlag=N" method="post">
		<input type="hidden" name='CPNY' value="${LoginUser.cpnyId }"/>
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td><!-- 社号/姓名 --><spring:message code="hrm.empinfo.nameAndEmpid"/></td>
					<td>
						<div style="float:left">
							<input type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"/>
						</div>
						<input type="hidden" name="seach_EMPID" id="seach_EMPID" value="${personInfo.EMPID}"/>
						<div style="float:left"><a class="btnLook" href="" lookupGroup="person"></a></div>
					</td>
					<td colspan="3">
						<c:if test="${not empty personInfo}">
							<span style="margin-left: 50px;" >${personInfo.LOCAL_NAME }&nbsp/&nbsp${personInfo.EMPID }&nbsp/&nbsp${personInfo.POST_GRADE_NO_NAME}&nbsp/&nbsp${personInfo.EMP_OFFICE_NAME }</span>
						</c:if>
					</td>
					<td><!-- 类型 --><spring:message code="ar.viewarcardrecord.title.leixing"/></td>
					<td>
						<select id="ACTIVITY" name="ACTIVITY">
						<option value=""  <c:if test="${ACTIVITY eq ''}">selected</c:if>>All</option>
						<option value="1" <c:if test="${ACTIVITY eq '1'}">selected</c:if>><spring:message code="empsubject.useY"/></option>
						<option value="0" <c:if test="${ACTIVITY eq '0'}">selected</c:if>><spring:message code="empsubject.useN"/></option>
					</select>
					</td>
				</tr>
				<tr>
				   
					
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
				<a class="buttonActive" href="/ar/attendanceMintenance/addArCardTemporaryInfoView" target="dialog" mask="true" width="750" height="300" rel="addArCardTemporaryInfoView"><span><!-- 添加 --><spring:message code="ess.empInfo.insert"/></span></a>
			</li>
			<li>
				<a class="buttonActive" href="/ar/attendanceMintenance/updateArCardTemporaryView?RECORD_NO={RECORD_NO}" target="dialog" mask="true" width="750" height="300" ><span><!-- 修改 --><spring:message code="ess.empInfo.modify"/></span></a>
			</li>
	</ul>
</div>
	<div class="user_table" style="font:bold 12px/20px arial,sans-serif;">Total:${fn:length(getArCardTemporaryList)}</div>
	<table class="list" width="99%">
		<thead>
			<tr>
				<th width="2%" align="center" >No.</th>
				<th width="1%" align="center" ><input type="checkbox" class="checkboxCtrl" group="c1"></th>
				<th width="10%"><!-- 工号 --><spring:message code="hrm.empinfo.ACCOUNT_NO.Z"/></th>
				<th width="10%"><!-- 工号 --><spring:message code="public.title.empId"/></th>
				<th width="10%"><!-- 姓名 --><spring:message code="public.title.name"/></th>
				<th width="6%"><!-- 类型 --><spring:message code="ar.viewcycle.title.huoyuezhuangtai"/></th>
				<th width="6%"><!-- 类型 --><spring:message code="org.title.UPDATED_IP"/></th>
				<th width="6%"><!-- 类型 --><spring:message code="org.title.UPDATE_DATE"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${getArCardTemporaryList}" var="list" varStatus="i">
				<tr target="RECORD_NO" rel="${list.RECORD_NO}">
					<td>${i.count}</td>
					<td>
						<c:if test="${list.INSERT_BY eq 'Manualy'}">
						  <input type="checkbox" name="c1" value="${list.RECORD_NO }">
						</c:if>
					</td>
					<td>${list.CARD_NO}</td>
					<td>${list.EMPID}</td>
					<td>${list.LOCAL_NAME}</td>
					<td>
						<c:choose>
							<c:when test="${list.ACTIVITY == '1'}"><spring:message code="empsubject.useY"/></c:when>
							<c:when test="${list.ACTIVITY == '0'}"><spring:message code="empsubject.useN"/></c:when>
						</c:choose>
					</td>
					<td>${list.CREATED_BY} - ${list.CREATED_NAME}</td>
					<td>${list.CREATE_DATE}</td>
				</tr>
			</c:forEach>			
		</tbody>
	</table>
</div>
