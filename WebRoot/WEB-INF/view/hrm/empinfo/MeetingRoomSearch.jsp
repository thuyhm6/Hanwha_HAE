<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript"> 
$(document).ready(function(){
	$("#viewMeetingRoomForm_search",navTab.getCurrentPanel()).click(function(){
		$("#viewMeetingRoomForm",navTab.getCurrentPanel()).submit();
	});
	$("#seach_KEY",navTab.getCurrentPanel()).keydown(function(e) {
        if ( e.keyCode == 13) {
       	 	var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       		$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewMeetingRoom&seach_KEY='+name);
       		$('.btnLook',navTab.getCurrentPanel()).click();
        }
    });
	$(".btnLook",navTab.getCurrentPanel()).click(function(e) {
       	 var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       	$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewMeetingRoom&seach_KEY='+name);
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

function f_delete_viewMeetingRoom(callback) {
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

			jsonData += ' "ROOM_NO": "' + obj.value + '",';
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
			url: '/hrm/empinfo/deleteMeetingRoomInfo',
			data: [{ name: 'jsonData', value: jsonData }],
			dataType:"json",
			cache: false,
			success: callback || DWZ.ajaxDone,
			error: DWZ.ajaxError
		});	
	}
}

</script>
<c:if test="${POSITION_NO eq '80000013' || POSITION_NO eq '14014038' || POSITION_NO eq '14014043' 
           || POSITION_NO eq '14014041' || POSITION_NO eq '14016403' || POSITION_NO eq '14016404'
           || POSITION_NO eq '14014042' || POSITION_NO eq '14014040' || EMPID eq '45180146' || EMPID eq '45200033'}">
<div class="pageHeader">
	<form id="viewMeetingRoomForm" onsubmit="return navTabSearch(this);" action="/hrm/empinfo/MeetingRoomSearch" method="post">
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
						<input type="hidden" name="seach_SYS_TYPE" id="seach_SYS_TYPE" value="${SYS_TYPE}"/>
						<div style="float:left"><a class="btnLook" href="" lookupGroup="person"></a></div>
					</td>
					<td colspan="3">
						<c:if test="${not empty personInfo}">
							<span style="margin-left: 50px;" >${personInfo.LOCAL_NAME }&nbsp/&nbsp${personInfo.EMPID }&nbsp/&nbsp${personInfo.POST_GRADE_NO_NAME}&nbsp/&nbsp${personInfo.EMP_OFFICE_NAME }</span>
						</c:if>
					</td>
					<td><!-- 日期  --><spring:message code="ga.meetingRoom.DAY"/> </td>
					<td>
						<input type="text" id="seach_START_DATE" name="seach_START_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${START_DATE}"/>~
						<input type="text" id="seach_END_DATE" name="seach_END_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${END_DATE}"/>
					</td>
					<td><!-- Level of importance --><spring:message code="ga.meetingRoom.levelOfImportance"/></td>
					<td class="td_type">
						<ait:SelectSyCodeByCpnyID name="LEVEL_IMPORTANCE" parentNo="14015488" limit="all" />
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
				<a class="buttonActive" id="viewMeetingRoomForm_search" href="#"><span><!-- 查询 --><spring:message code="hrm.empinfo.QUERY"/></span></a> 
			</li>	
			<li>
				<a class="buttonActive" href="/hrm/empinfo/addMeetingRoomView" target="dialog" mask="true" width="750" height="700" rel="addMeetingRoomView"><span><!-- 添加 --><spring:message code="ess.empInfo.insert"/></span></a>
			</li>
			<li>
				<a class="buttonActive" href="/hrm/empinfo/updateMeetingRoomView?ROOM_NO={ROOM_NO}" target="dialog" mask="true" width="750" height="700" ><span><!-- 修改 --><spring:message code="ess.empInfo.modify"/></span></a>
			</li>
			<li>
				<a class="buttonActive" href="#" onclick="javascript:f_delete_viewMeetingRoom(navTabAjaxDoneWithForm);"><span><!-- 删除 --><spring:message code="ess.empInfo.Delete"/></span></a>
			</li>
	</ul>
</div>
	<div class="user_table" style="font:bold 12px/20px arial,sans-serif;">Total:${fn:length(MeetingRoomSearch)}</div>
	<table class="list" width="100%">
		<thead>
			<tr>
				<th width="1%" align="center" >No.</th>
				<th width="1%" align="center" ><input type="checkbox" class="checkboxCtrl" group="c1"></th>
				<th width="3%"><!-- 工号 --><spring:message code="ga.meetingRoom.DAY"/></th>
				<th width="3%"><!-- 工号 --><spring:message code="ga.meetingRoom.DATE"/></th>
				<th width="5%"><!-- 工号 --><spring:message code="public.title.empId"/>(<spring:message code="ga.meetingRoom.CHAIRED_THE_MEETING"/>)</th>
				<th width="5%"><!-- 姓名 --><spring:message code="public.title.name"/>(<spring:message code="ga.meetingRoom.CHAIRED_THE_MEETING"/>)</th>
				<th width="5%"><!-- 姓名 --><spring:message code="hrm.empinfo.PARTICIPANTS"/></th>
				<th width="12%"><!-- 类型 --><spring:message code="hrm.contract.content"/></th>
				<%-- <th width="12%"><!-- 类型 --><spring:message code="ar.viewararmonthcalculate.title.jisuanjieguo"/></th> --%>
				<th width="5%"><!-- Level of importance --><spring:message code="ga.meetingRoom.levelOfImportance"/></th>
				<th width="3%"><!-- 工号 --><spring:message code="ar.monthwork.title.Attendanceday"/></th>
				<th width="3%"><!-- Create by --><spring:message code="inct.salesman.createBy"/></th>
				<th width="3%"><!-- Create date --><spring:message code="inct.salesman.createTime"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${MeetingRoomSearch}" var="list" varStatus="i">
				<tr target="ROOM_NO" rel="${list.ROOM_NO}">
					<td>${i.count}</td>
					<td>
						  <input type="checkbox" name="c1" value="${list.ROOM_NO}">
					</td>
					<td>${list.ROOM_DATE}</td>
					<td>${list.ROOM_FROM_TIME}-${list.ROOM_TO_TIME}</td>
					<td>${list.EMPID}</td>
					<td>${list.LOCAL_NAME}</td>
					<td>${list.EMPLOYEE_LIST}</td>
					<td style="text-align: left">${list.REMARK}</td>
					<%-- <td>${list.RESULT_ROOM}</td> --%>
					<td>${list.LEVEL_IMPORTANCE_NAME}</td>
					<td>${list.ROOM_END_DATE}</td>
					<td>${list.CREATED_BY_ID} / ${list.CREATED_BY_NAME}</td>
					<td>${list.CREATE_DATE}</td>
				</tr>
			</c:forEach>			
		</tbody>
	</table>
</div>
</c:if>
<c:if test="${POSITION_NO eq null}">
	You do not have permission to access this page
</c:if>
