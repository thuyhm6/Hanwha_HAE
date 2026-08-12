<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript"> 
$(document).ready(function(){
	$("#updateAttendanceStatus_search",navTab.getCurrentPanel()).click(function(){
		$("#updateAttendanceStatusForm",navTab.getCurrentPanel()).submit();
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

	$(".list",navTab.getCurrentPanel()).dataTable({"bPaginate": true,    //关闭分页
		"bAutoWidth":false,//表格宽度自动变化
	    "bProcessing":true,
	    "lengthMenu": [[50,100,200, 500], [50,100,200, 500]],
		"bLengthChange": true,  //按多少条记录显示下拉框
		"iDisplayLength": 50, //默认每页显示的记录数
		"bFilter": true,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
	 	"searching": true,//本地搜索
		"bSort": true,   //排序功能
		"bInfo": true,   //显示datatables的信息（底部的页数，条目数信息）
		"bScrollInfinite":true,
	     "orderClasses": false,
	     "order":[],//初始化不用自动排序
	     "scrollY": $(document.body).height() - 300,
	     "scrollX": false,
	     "scrollCollapse": false,
	     "deferRender":true,
	     "fixedColumns":false,
	    "oLanguage": {//多语言配置
			//正在加载中......
	    	"sProcessing": "<spring:message code='ess.message.loading' />",
	        //查询不到相关数据！
	        "sZeroRecords": "<spring:message code='ess.message.NOT_FOUND_DATA' />",
	        //表中无数据存在！
	        "sEmptyTable": "<spring:message code='ess.message.NOT_FOUND_DATA_FROM_TABLE' />",
	        //快速筛选
	        "sSearch": "<spring:message code='ess.message.rapid_screening' />",
	        //每页 _MENU_ 条记录
	        "sLengthMenu": "<spring:message code='ess.message.page_of_lines' />",
	        //从 _START_ 到 _END_ /共 _TOTAL_ 条数据
	        "sInfo": "<spring:message code='ess.message.sum_begin_to_end' />",
	        //(从 _MAX_ 条记录过滤)
	        "sInfoFiltered": "<spring:message code='ess.message.filter_from_max' />",
	        "oPaginate": {
	            //上一页
	            "sPrevious": "<spring:message code='ess.message.previous_page' />",
	            //下一页
	            "sNext": "<spring:message code='ess.message.next_page' />"
	        }
	    },
	    "sDom":'<"top"r<"clear">fBl>t<"bottom"ip<"clear">>',
	    "buttons": [] 
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
	if (confirm ("<spring:message code='button.delete.sure'/>")){	
		$.ajax({
			type: 'POST',
			url: '/ar/attendanceMintenance/deleteAttendanceStatusInfo',
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
	<form id="updateAttendanceStatusForm" onsubmit="return navTabSearch(this);" action="/ar/attendanceMintenance/updateAttendanceStatus?firstFlag=N" method="post">
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
					<td><!-- 日期  --><spring:message code="pa.salary.title.date"/> </td>
					<td>
						<input type="text" id="seach_START_DATE" name="seach_START_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${START_DATE}"/>~
						<input type="text" id="seach_END_DATE" name="seach_END_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${END_DATE}"/>
					</td>
					<td><!-- 分类  --><spring:message code="inct.salesman.classify"/></td>
					<td>
						<ait:SelectSyCodeByCpnyID name="seach_TYPE_ATTENDANCE" parentNo="21" selected="${TYPE_ATTENDANCE}" limit="ALL"/>
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
				<a class="buttonActive" id="updateAttendanceStatus_search" href="#"><span><!-- 查询 --><spring:message code="hrm.empinfo.QUERY"/></span></a> 
			</li>	
			<li>
				<a class="buttonActive" href="#" onclick="javascript:f_delete_viewarcardrecord(navTabAjaxDoneWithForm);"><span><!-- 删除 --><spring:message code="ess.empInfo.Delete"/></span></a>
			</li>
			<li><a class="buttonActive" href="/pa/excelExport/downloadExcelAttendanceApply?file=attendance_Type" ><span><!--模板下载--><spring:message code="ess.message.template_download" /></span></a></li>
			<li>
				<a class="buttonActive" onclick="downloadExcel('updateAttendanceStatusForm','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=25&CPNY=${LoginUser.cpnyId}','/ar/attendanceMintenance/updateAttendanceStatus?firstFlag=N')"><span>
		<!-- 导出到Excel --><spring:message code="org.title.exportLOtImportExcel"/></span></a>
			</li>
			<li>
				<a class="buttonActive" href="/pa/excelImport/importExcelData?importFunName=/importAttendanceHAE&REGISTER_SEQ=${SEQ}" target="dialog" mask="true">
					<span><spring:message code="ar.addempshift.title.excelimport" /><!-- EXCEL导入 --></span>
				</a>
			</li>
	</ul>
</div>
	<div class="user_table" style="font:bold 12px/20px arial,sans-serif;">Total:${fn:length(getAttendanceStatus)}</div>
	<table class="list" width="99%">
		<thead>
			<tr>
				<th width="2%" align="center" >No.</th>
				<th width="1%" align="center" ><input type="checkbox" class="checkboxCtrl" group="c1"></th>
				<th width="5%"><!-- 工号 --><spring:message code="public.title.empId"/></th>
				<th width="10%"><!-- 姓名 --><spring:message code="public.title.name"/></th>
				<th width="6%"><!-- 类型 --><spring:message code="ar.viewcycle.title.kaishiri"/></th>
				<th width="6%"><!-- 类型 --><spring:message code="edu.planManager.JIHUAJIESHUSHIJIAN.a"/></th>
				<th width="6%"><!-- 类型 --><spring:message code="ar.viewarcardrecord.title.leixing"/> <spring:message code="ess.infoApply.check_work"/></th>
				<th width="10%"><!-- 备注 --><spring:message code="inct.salesman.remark"/>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${getAttendanceStatus}" var="list" varStatus="i">
				<tr target="RECORD_NO" rel="${list.RECORD_NO}">
					<td>${i.count}</td>
					<td>
						  <input type="checkbox" name="c1" value="${list.RECORD_NO }">
					</td>
					<td>${list.EMPID}</td>
					<td>${list.LOCAL_NAME}</td>
					<td>${list.START_DATE}</td>
					<td>${list.END_DATE}</td>
					<td>${list.TYPE_ATTENDANCE_NAME}</td>
					<td>${list.REMARK}</td>
				</tr>
			</c:forEach>			
		</tbody>
	</table>
</div>
