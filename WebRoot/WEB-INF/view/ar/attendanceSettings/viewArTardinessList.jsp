<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script>
$(document).ready(function(){
	//查询
	$("#viewArTardinessList_Serch",navTab.getCurrentPanel()).click(function(){
		$("#viewArTardinessListForm",navTab.getCurrentPanel()).submit();
	});
	
	$("#seach_KEY",navTab.getCurrentPanel()).keydown(function(e) {
        if ( e.keyCode == 13) {
       	 	var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       	 	var YEAR=encodeURI(encodeURI($('#seach_YEAR',navTab.getCurrentPanel()).val()));
       		$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewArTardinessList&seach_KEY='+name+'&seach_YEAR='+YEAR);
       		$('.btnLook',navTab.getCurrentPanel()).click();
        }
    });
	$(".btnLook",navTab.getCurrentPanel()).click(function(e) {
      	 var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
      	 var YEAR=encodeURI(encodeURI($('#seach_YEAR',navTab.getCurrentPanel()).val()));
      	$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewArTardinessList&seach_KEY='+name+'&seach_YEAR='+YEAR);
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
	     "scrollY": $(document.body).height() - 310,
	     "scrollX": $(document.body).width(),
	     "scrollCollapse": false,
	     "deferRender":true,
	        
	    "fixedColumns":{leftColumns: 3},
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
	
	$('.orderList',navTab.getCurrentPanel()).on( 'draw.dt', function () {
		initEditFun_ar0232();
	});

	initEditFun_ar0232();
	
	//年假生成


function changeModifyFlag(obj,index){
	$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
}
function initEditFun_ar0232(){
	$('.orderList tbody tr td:[sysLog="text"]',navTab.getCurrentPanel()).editable({type:'text',
		onblur:function(val,settings){
			var index = $(this).attr("sysIndex");
			var type = $(this).attr("sysType");
	        $(this).html(val);
			this.editing = false;
			$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
		}
	});
}
});

function changeURL_ar1112(name,PERSON_ID,monthYear) {
	var KEY = "1";
	var href = "/ess/viewDept/viewArPersonalSingleList?ITEM_NO=" + name
			+ "&AR_SUPERVISIOR_INFO=${LoginUser.personId}" + "&monthYear=" + monthYear 
			+ "&PERSON_ID=" + PERSON_ID + "&KEY="
			+ KEY;
    //个人考勤现况
	$.pdialog.open(href,"ar0402", "<spring:message code='pa.salary.title.fullInfo'/>", {width:1200,height:400,mask:true});
}
</script>
<div class="pageHeader">
<form id="viewArTardinessListForm" onsubmit="return navTabSearch(this);" action="/ar/attendanceSettings/viewArTardinessList" method="post">
<div class="searchBar">
<table class="searchContent">
	<tr>
		<td><!-- 社号/姓名 --><spring:message code="ess.infoApply.NAME_EMPID" /></td> 	
		<td>
			<div style="float:left"><input type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"/></div>
			<div style="float:left"><a class="btnLook" href="" lookupGroup="person"></a></div>
		</td>
		<td colspan="3">
			<c:if test="${not empty personInfo}">
			<span style="margin-left: 50px;" >${personInfo.LOCAL_NAME }&nbsp/&nbsp${personInfo.EMPID }&nbsp/&nbsp${personInfo.POST_GRADE_NO_NAME}&nbsp/&nbsp${personInfo.EMP_OFFICE_NAME }</span>
			</c:if>
		</td>
	</tr>
	<tr>
		<td><!-- 年份 --><spring:message code="pa.payear.title.payear" /></td>
		<td>
			<ait:date yearName="seach_YEAR"  yearSelected="${YEAR}"  yearPlus="10"/>
		</td>
		
		<!--<td> 基准日 <spring:message code="ess.title.JIZHUNRI" /></td>
		<td>
			<input type="text" id="seach_YEAR" name="seach_YEAR" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy/MM/dd'})" value="${YEAR}"/>
		</td>-->
		
		<td ><!-- 部门 --><spring:message code="org.title.dept" /></td>
		<td>
			<ait:deptList name="seach_DEPTNO" limit="hr" id="viewArTardinessList_seachDept"/>
			<ait:deptTreeIcon name="seach_DEPTNO" limit="hr" id="viewArTardinessList_seachDept" selected="${DEPTNO}"/>
			<input type="checkbox" name="seach_SON_FLAG" value="1" <c:if test="${SON_FLAG eq '1' }">checked="checked"</c:if>>
		</td>
		<td><!-- 任职状态 --><spring:message code="ess.infoApply.renzhizhuangtai" /></td>
		<td>
		 <ait:SelectSyCodeByCpnyID id="seach_EMP_OFFICE" name="seach_EMP_OFFICE" parentNo="15118" selected="${EMP_OFFICE}"  limit="all"/>
		</td>
		
	</tr>
</table>
</div>
</form>
</div>
<div class="formBar">
	<ul class="toolBar">
		<li><a class="buttonActive" id="viewArTardinessList_Serch" href="#"><span><!-- 查询 --><spring:message code="ess.infoApply.SELECT" /></span></a></li>
		<li><a class="buttonActive"  onclick="downloadExcel('viewArTardinessListForm','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=360','/ar/attendanceSettings/viewArTardinessList')">
		<span><!-- 导出到Excel --><spring:message code="ess.infoApply.export_to_Excel" /></span></a></li>
	</ul>
</div>
<div class="pageContent">
				<div class="pageContent">
				<table class="orderList" width="2000px">
					<thead>
							<tr >
								<th rowspan="2" ><spring:message code="hrm.contract.NO" /></th>
								<th rowspan="2"  ><!-- 姓名 --><spring:message code="hr.empinfo.empid" /></th>
								<th rowspan="2" ><spring:message code="ess.infoApply.NAME" /></th>
								<th rowspan="2" ><spring:message code="ga.viewOtMeal.DeptnameEating" /></th>
								<th rowspan="2" ><spring:message code="hr.viewPersonalInfo.title.DATE_LEFT" /></th>
								<th colspan="3" ><spring:message code="liang.hr.viewWorkInfo.title.zongji" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.January" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.February" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.March" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.April" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.May" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.June" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.July" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.August" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.September" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.October" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.November" /></th>
								<th colspan="3" ><spring:message code="hrm.empinfo.December" /></th>
							 </tr>
							 <tr >
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.LATE_ARRIVE_MINUTES.b" /></th>
								<th><spring:message code="ess.viewArPersonalYearList.EARLY_LEAVE_MINUTES.b" /></th>
								<th><spring:message code="ar.monthwork.title.kuanggong" /></th>
							 </tr>
					</thead>
					<tbody>
						<c:forEach items="${viewArTardinessList}" var="item" varStatus="i">
							<tr>
								<td >${i.count}</td>
								<td >${item.EMPID}</td>
								<td >${item.LOCAL_NAME}</td>
								<td >${item.DEPTNAME}</td>
								<td >${item.DATE_LEFT}</td>
								<td style="text-align: center;" > ${item.TOTAL_LATE_ARRIVE_COUNT}</td>
								<td style="text-align: center;" > ${item.TOTAL_EARLY_LEAVE_COUNT}</td>
								<td style="text-align: center;"> ${item.TOTAL_UNPAID_LEAVE_COUNT}</td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}01");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_1}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}01");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_1}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}01");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_1}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}02");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_2}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}02");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_2}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}02");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_2}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}03");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_3}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}03");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_3}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}03");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_3}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}04");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_4}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}04");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_4}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}04");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_4}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}05");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_5}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}05");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_5}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}05");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_5}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}06");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_6}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}06");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_6}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}06");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_6}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}07");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_7}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}07");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_7}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}07");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_7}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}08");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_8}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}08");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_8}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}08");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_8}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}09");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_9}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}09");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_9}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}09");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_9}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}10");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_10}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}10");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_10}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}10");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_10}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}11");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_11}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}11");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_11}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}11");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_11}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141441","${item.PERSON_ID}","${YEAR}12");'>
						<span style="color: blue">${item.LATE_ARRIVE_COUNT_12}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141442","${item.PERSON_ID}","${YEAR}12");'>
						<span style="color: blue">${item.EARLY_LEAVE_COUNT_12}</span></td>
								<td style="text-align: center; cursor: pointer;" id="codeChange" onclick='javascript:changeURL_ar1112("141443,14015448","${item.PERSON_ID}","${YEAR}12");'>
						<span style="color: blue">${item.UNPAID_LEAVE_UNRAESON_COUNT_12}</span></td>
							</tr>	
							</c:forEach>					
					</tbody>
				</table>
		</div>
	