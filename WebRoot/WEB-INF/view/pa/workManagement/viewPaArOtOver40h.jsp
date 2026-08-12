<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
$(document).ready(function(){
      $("#viewPaArOtOver40h_Serch",navTab.getCurrentPanel()).click(function(){
			$("#viewPaArOtOver40h",navTab.getCurrentPanel()).submit();
	   });
	$(".orderList",navTab.getCurrentPanel()).dataTable({
		"bPaginate": true,    //分页
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
	     "scrollX": $(document.body).width() - 30,
	     "scrollCollapse": false,
	     "deferRender":true,
	        "columnDefs": [//自定义排序类型
		                     { "orderable": false, "targets":false }
	                     ],
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

function excelimport_pa302(){
	$("#importExcelDialog_pa302").attr('href','/pa/excelImport/importExcelData?importFunName=/importApplyOt');
	$("#importExcelDialog_pa302").click();
}
</script>
<div class="panel"><h1><!--加班搜索--><spring:message code="ar.viewSearchApplyOtInfoList.JIABANSOUSUO.b" /></h1>
</div>
<a id="importExcelDialog_pa302"  href="#" target="dialog" mask="true"></a>
<a id="excelimport_pa302" href="#" target="navTab" mask="true"><span style="display:none;"><!-- 导入结果 --><spring:message code="ess.title.DAORUJIEGUO" /></span></a>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="/pa/workManagement/viewPaArOtOver40h?firstFlag=N" method="post"
		id="viewPaArOtOver40h" name="viewPaArOtOver40h">
		<div class="searchBar">
				<table class="searchContent">
				<tr>
					<td><!-- 社号/姓名 --><spring:message code="hrm.empinfo.nameAndEmpid"/></td>
					<td>
						<div style="float:left"><input type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"/></div>
					</td>
					<td><spring:message code="hr.viewPersonalInfo.title.DEPTNAME" /></td>
					<td>
						<ait:deptList name="seach_DEPTNO" cpnyId="${defaultCpny}" limit="ar" id="viewPa1301_seachDept"/>
						<ait:deptTreeIcon name="seach_DEPTNO" cpnyId="${defaultCpny}" limit="ar" id="viewPa1301_seachDept" selected="${DEPTNO}"/>
					</td>
					<td><!-- 日期  --><spring:message code="pa.salary.title.date"/> </td>
					<td>
						<input type="text" id="seach_START_DATE" name="seach_START_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy/MM/dd',lang:'en'})" value="${START_DATE}"/>~
						<input type="text" id="seach_END_DATE" name="seach_END_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy/MM/dd',lang:'en'})" value="${END_DATE}"/>
					</td>
				    <td><!--加班时长--><spring:message code="ess.infoApply.overtime_hours"/>(>=) </td>
					<td>
					     <input type="text" id="seach_OT_LENGTH" name="seach_OT_LENGTH" size="10" value="${OT_LENGTH }" />
					</td>
				   </tr>
			</table>
		</div>
	</form>
</div>

<div class="pageContent" >
<div class="formBar">
	<ul class="toolBar">
	<li><a class="buttonActive" id="viewPaArOtOver40h_Serch" href="#"><span><!-- 查询 --><spring:message code="hrm.empinfo.QUERY"/></span></a></li>
	<%-- <li><a class="buttonActive" href="/pa/excelExport/downloadExcelOtApply?file=OtApply_add" ><span><!--模板下载--><spring:message code="ess.message.template_download" /></span></a></li>
	<li><a class="buttonActive" onclick="excelimport_pa302()"><span><!--Excel导入--><spring:message code="ess.infoApply.EXCEL_IN" /></span></a></li> --%>
	<li>
		<a class="buttonActive" onclick="downloadExcel('viewPaArOtOver40h','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=298&CPNY=${LoginUser.cpnyId}','/pa/workManagement/viewPaArOtOver40h?firstFlag=N')"><span>
		<!-- 导出到Excel --><spring:message code="org.title.exportLOtImportExcel"/></span></a>
	</li>
	 </ul>
</div>
 <input type="hidden" id="nullOTTSTOAffirmListCnt" value="${otCoordListCnt}">
		<table class="orderList" width=100%">   
			<thead>
				<tr>
					<th><!--NO--> NO </th>
					<th><!-- 社号 --><spring:message code="ess.infoApply.EMPID"/></th>
					<th><!-- 姓名 --><spring:message code="org.title.LOCAL_NAME"/></th>
					<th><!-- 部门名 --><spring:message code="ess.infoApply.DEPT_NAME"/></th>
					<th><!-- 职级 --><spring:message code="sys.postManage.title.postGrade"/></th>
					<th><!-- 班组 --><spring:message code="hr.viewPersonalInfo.title.banzu"/>	</th>
					<th><!-- 加班日期 --><spring:message code="ess.infoApply.title.overtimeTime"/></th>
					<th><!-- 星期 --><spring:message code="ess.infoApply.week"/></th>
					<th><!-- 考勤 --><spring:message code="ar.viewArNavigationPage.KAOQIN.b"/></th>
					<th><!-- 工作时间 --><spring:message code="ess.infoApply.working_hours"/></th>
					<th><!-- 进门 --><spring:message code="ar.viewarcardrecord.title.jinmen"/></th>
					<th><!-- 出门 --><spring:message code="ar.viewarcardrecord.title.chumen"/></th>
					<th><!-- 开始时间--><spring:message code="ess.infoApply.title.startTime"/></th>
					<th><!-- 结束时间--><spring:message code="ess.infoApply.title.endTime"/></th>
					<th><!-- 加班时长--><spring:message code="ess.infoApply.overtime_hours"/></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${otCoordList}" var="CoordOtApply" varStatus="i">	
					<tr target="sid" rel="">
					    <td style="text-align: center">${i.count}</td>
					    <td style="text-align: center">${CoordOtApply.EMPID}</td>
					    <td style="text-align: center">${CoordOtApply.LOCAL_NAME}</td>
						<td style="text-align: center">${CoordOtApply.DEPT_NAME}</td>
						<td style="text-align: center">${CoordOtApply.POST_GRADE_NAME}</td>
						<td style="text-align: center">${CoordOtApply.SHIFT_GROUP}</td>
						<td style="text-align: center">${CoordOtApply.AR_DATE_STR}</td>
						<td style="text-align: center"><c:if test="${CoordOtApply.IWEEK eq 1}"><!-- 星期日--><spring:message code="ar.week.XINGQIRI.b"/></c:if>
							<c:if test="${CoordOtApply.IWEEK eq 2}"><!-- 星期一--><spring:message code="ar.week.XINGQIYI.b"/></c:if>
							<c:if test="${CoordOtApply.IWEEK eq 3}"><!-- 星期二--><spring:message code="ar.week.XINGQIER.b"/></c:if>
							<c:if test="${CoordOtApply.IWEEK eq 4}"><!-- 星期三--><spring:message code="ar.week.XINGQISAN.b"/></c:if>
							<c:if test="${CoordOtApply.IWEEK eq 5}"><!-- 星期四--><spring:message code="ar.week.XINGQISI.b"/></c:if>
							<c:if test="${CoordOtApply.IWEEK eq 6}"><!-- 星期五--><spring:message code="ar.week.XINGQIWU.b"/></c:if>
							<c:if test="${CoordOtApply.IWEEK eq 7}"><!-- 星期六--><spring:message code="ar.week.XINGQILIU.b"/></c:if></td>
						<td style="text-align: center">${CoordOtApply.ITEM_NAME}</td>
						<td style="text-align: center">${CoordOtApply.SHIFT_START_TIME}-${CoordOtApply.SHIFT_END_TIME}</td>
						<td style="text-align: center">${CoordOtApply.INDOOR_TIME}</td>
						<td style="text-align: center">${CoordOtApply.OUTDOOR_TIME}</td>
						<td style="text-align: center">${CoordOtApply.FROM_TIME}</td>
						<td style="text-align: center">${CoordOtApply.TO_TIME}</td>
						<td style="text-align: center">${CoordOtApply.QUANTITY}<!-- 小时--><spring:message code="ar.viewsummaryparameteritem.title.hour"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</div>