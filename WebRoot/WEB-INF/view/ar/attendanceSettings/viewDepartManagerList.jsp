<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script>
$(document).ready(function(){
	//查询
	$("#viewDepartManagerList_Serch",navTab.getCurrentPanel()).click(function(){
		$("#viewDepartManagerListForm",navTab.getCurrentPanel()).submit();
	});
});

$(document).ready(function(){
	//保存
	$("#viewDepartManagerList_save",navTab.getCurrentPanel()).click(function(){	
		//获取页面的值
		var jsonData = '[';
		$("input[name='LOCK_ATTEN_FLAG']",navTab.getCurrentPanel()).each(function(i, obj){
			if (jsonData.length > 1) {
				jsonData += ',{';
			} else {
				jsonData += '{';
			}
			var LOCK_ATTEN_FLAG = 0;
			var LOCK_ATTEN_EX_FLAG = 0;
			var LOCK_OT_FLAG = 0;
			var LOCK_OT_LIMIT_FLAG = 0;
			var AFFIRM_FLAG = 0;
			if(obj.checked){
				LOCK_ATTEN_FLAG = 1;
			}
			if($("#LOCK_OT_FLAG_" + i ).attr("checked") == "checked" ){
				LOCK_OT_FLAG = 1;
			}
			if($("#LOCK_ATTEN_EX_FLAG_" + i ).attr("checked") == "checked" ){
				LOCK_ATTEN_EX_FLAG = 1;
			}
			//if($("#LOCK_OT_LIMIT_FLAG_" + i ).attr("checked") == "checked" ){
				//LOCK_OT_LIMIT_FLAG = 1;
			//}
			//if($("#AFFIRM_FLAG_" + i ).attr("checked") == "checked" ){
				//AFFIRM_FLAG = 1;
			//}
			
			jsonData += ' "SEQ": "' + $("#viewDepartManagerList_SEQ_" + i,navTab.getCurrentPanel()).val() + '" ,';
			jsonData += ' "LOCK_ATTEN_FLAG": "' + LOCK_ATTEN_FLAG + '" ,';
			jsonData += ' "LOCK_OT_FLAG": "' + LOCK_OT_FLAG + '" ,';
			jsonData += ' "LOCK_ATTEN_EX_FLAG": "' + LOCK_ATTEN_EX_FLAG + '" ,';
			jsonData += ' "adminID": "' + '${LoginUser.adminID}' + '" ,';
			jsonData += ' "adminIP": "' + '${LoginUser.adminIP}' + '" ';
			jsonData += '}';
 		});
		jsonData += ']';
		if (jsonData.length == 2) {
			alertMsg.info("<spring:message code='ess.message.NO_NEED_TO_SAVE_DATA'/>"); //没有需要保存的数据
			return;
		}
		alertMsg.confirm("<spring:message code='ess.message.confirm_sava'/>",//确定要保存吗？
	  		  	{okCall:function(){
			  	$.ajax({
	  				type: 'POST',
					url: '/ar/attendanceSettings/addDepartManagerInfo',
					data: [{ name: 'jsonData', value: jsonData }],
	  				dataType:"json",
	  				cache: false,
	  				success: navTabAjaxDoneWithForm,
	  				error: DWZ.ajaxError
	  			});
	  	}});
	});
});

function departManager(flag){
	var start = $("#seach_START_DATE",navTab.getCurrentPanel()).val();
	var end = $("#seach_END_DATE",navTab.getCurrentPanel()).val();
	var deptno = $("input[name='seach_DEPTNO']",navTab.getCurrentPanel()).val();
	var SON_FLAG = 0;
	if($("#seach_SON_FLAG",navTab.getCurrentPanel()).attr("checked") == "checked" ){
		SON_FLAG = 1;
	}
	if( start == ''){
		alertMsg.info("<spring:message code='alert.message.please_select_begin_time.b'/>"); //请选择开始时间
		return false;
	}
	if( end == ''){
		alertMsg.info("<spring:message code='alert.message.please_select_end_time.b'/>");//请选择结束时间
		return false;
	}
	if( deptno == ''){
		alertMsg.info("<spring:message code='alert.trans.message.selectDept'/>");//请选择部门
		return false;
	}
	var msg = "<spring:message code='alert.message.ERROR.b'/>"; //错误
	if(flag == 0){
		msg = "<spring:message code='alert.message.confirm_all_open.b'/>"; //确定要统一开放吗？
	}else{
		msg = "<spring:message code='alert.message.confirm_all_locked.b'/>"; //确定要统一锁定吗？
	}
	alertMsg.confirm(msg,
  		  	{okCall:function(){
		  	$.ajax({
  				type: 'POST',
				url: '/ar/attendanceSettings/addDepartManagerUnifyInfo',
				data: { DEPTNO: deptno, START_DATE: start, END_DATE:end, FLAG : flag, SON_FLAG:SON_FLAG},
  				dataType:"json",
  				cache: false,
  				success: navTabAjaxDoneWithForm,
  				error: DWZ.ajaxError
  			});
  	}});
}
$(function(){
    $('#dePtManageTree').treeTable();
});
</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="/ar/attendanceSettings/viewDepartManagerList" method="post" id="viewDepartManagerListForm">
	<div class="searchBar" >
		<table class="searchContent">
			<tr>
				<td><!--日期--><spring:message code="ess.infoApply.date"/></td>
				<td><input id="seach_LOCK_DATE" type="text" name="seach_LOCK_DATE"  class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${LOCK_DATE}"/>
					</td>
				<td><!-- 部门 --><spring:message code="public.title.deptName"/></td>
				<td>
					<ait:deptList name="seach_DEPTNO" limit="ar" id="viewDepartManagerList_seachDept"/>
					<ait:deptTreeIcon name="seach_DEPTNO" limit="ar" id="viewDepartManagerList_seachDept" selected="${DEPTNO}"/>
					<input type="checkbox" id="seach_SON_FLAG" name="seach_SON_FLAG" value="1" <c:if test="${SON_FLAG eq '1' }">checked="checked"</c:if>>
				</td>
			</tr>
		</table>
	</div>
	</form>
</div>

<div class="formBar">
    <ul class="toolBar">
		<li><a class="buttonActive" id="viewDepartManagerList_Serch" href="#"><span><!--查询--><spring:message code="button.search"/></span></a></li>
		<li><a class="buttonActive" id="viewDepartManagerList_save"><span><!--保存--><spring:message code="button.sys.affirm.save"/></span></a></li>
		<li><a class="delete" href="/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=45"><span><!--导出到EXECL --><spring:message code="ess.infoApply.export_to_Excel"/></span></a></li>
	</ul>
</div>


<div class="pageHeader">
<div class="searchBar" >
	<form onsubmit="return navTabSearch(this);" action="/ar/attendanceSettings/viewDepartManagerList" method="post" id="deptManageFlagModifyForm">
		<table class="searchContent">
			<tr>
				<td><!--期间--><spring:message code="ess.infoApply.Period"/></td>
				<td>
					<input type="text" id="seach_START_DATE" name="seach_START_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${START_DATE }"/>~
					<input type="text" id="seach_END_DATE" name="seach_END_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${END_DATE }"/>
				</td>
			</tr>
		</table>
			<div class="subBar">
				<ul>
					<li>
						<a class="buttonActive" onclick="departManager(0)" href="#">
							<span><!--统一开放--><spring:message code="ar.viewDepartManagerList.TONGYIKAIFANG.b"/></span>
						</a>
					</li>
					<li>
						<a class="buttonActive" onclick="departManager(1)" href="#">
							<span><!--统一结束--><spring:message code="ar.viewDepartManagerList.TONGYIJIESHU.b"/></span>
						</a>
					</li>
				</ul>
			</div>
	</form>
	</div>
</div>
<div class="pageContent">
    <div class="user_table" style="font:bold 12px/20px arial,sans-serif;">Total:${viewDepartManagerListCnt}</div>
	<table class="list" width="100%" layoutH="206" id="dePtManageTree">
		<thead>
			<tr>
				<!-- orderField 与sql 的orderBy对应  orderDirection 为相反配置 class 控制图片-->
				<th width="100"><!-- 部门 --><spring:message code="public.title.deptName"/></th>
				<th width="80"><!--日期--><spring:message code="ess.infoApply.date"/></th>
				<th width="80"><!--考勤--><spring:message code="ess.attendance.state"/>&nbsp;<input type="checkbox" class="checkboxCtrl" group="LOCK_ATTEN_FLAG"/></th>
				<th width="80" ><!--加班--><spring:message code="ess.attendance.ot"/>&nbsp;<input type="checkbox" class="checkboxCtrl"  group="LOCK_OT_FLAG"/></th>
				<th width="80"><!--考勤异常--><spring:message code="ess.title.attendance_anomaly"/>&nbsp;<input type="checkbox" class="checkboxCtrl" group="LOCK_ATTEN_EX_FLAG"/></th>
				<!--<th width="80" >部门长审批<spring:message code="ar.viewDepartManagerList.BUMENZHANGSHENPI.b"/>&nbsp;<input type="checkbox" class="checkboxCtrl"  group="AFFIRM_FLAG"/></th>-->
				<%-- 
				<th width="80" >加班上限&nbsp;<input type="checkbox" class="checkboxCtrl"  group="LOCK_OT_LIMIT_FLAG"/></th>
				--%>
				<th width="80" ><!--变更者--><spring:message code="hrm.empinfo.UPDATED_BY"/></th>
				<th width="80" ><!--变更时间--><spring:message code="hrm.empinfo.UPDATE_DATE"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${viewDepartManagerList}" var="item" varStatus="i">
			 
 				<tr id="${item.DEPTNO}" <c:if test="${item.DEPTNO ne DEPTNO and item.PARENT_DEPT_NO ne '0'}">pid="${item.PARENT_DEPT_NO}"</c:if>> 
					
					<td>${item.DEPTNAME}
					<input type="hidden" id="viewDepartManagerList_SEQ_${i.index}" name="SEQ" value="${item.MANAGE_NO}"></td>
					<td style="text-align:center">${item.LOCK_DATE}</td>
					<td style="text-align:center">
					 	<input type="checkbox" name="LOCK_ATTEN_FLAG" value="1"
										<c:if test="${item.LOCK_ATTEN_FLAG==1 }">checked</c:if>/>
					 </td>
					 
					 <td style="text-align:center">
					 	<input type="checkbox" id="LOCK_OT_FLAG_${i.index }" name="LOCK_OT_FLAG" value="1"
										<c:if test="${item.LOCK_OT_FLAG==1 }">checked</c:if>/>
					 </td>
					 
					 <td style="text-align:center">
					 	<input type="checkbox" name="LOCK_ATTEN_EX_FLAG" value="1" id="LOCK_ATTEN_EX_FLAG_${i.index }"
										<c:if test="${item.LOCK_ATTEN_EX_FLAG==1 }">checked</c:if>/>
					 </td>
					 
					 <%--<td style="text-align:center">
					 	<input type="checkbox" id="AFFIRM_FLAG_${i.index }" name="AFFIRM_FLAG" value="1"
										<c:if test="${item.AFFIRM_FLAG==1 }">checked</c:if>/>
					 </td>
					  
					 <td style="text-align:center">
					 	<input type="checkbox" id="LOCK_OT_LIMIT_FLAG_${i.index }" name="LOCK_OT_LIMIT_FLAG" value="1"
										<c:if test="${item.LOCK_OT_LIMIT_FLAG==1 }">checked</c:if>/>
					 </td>
					 --%>
					<td style="text-align:center">${item.UPDATED_BY}</td>
					<td style="text-align:center">${item.UPDATE_DATE}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
