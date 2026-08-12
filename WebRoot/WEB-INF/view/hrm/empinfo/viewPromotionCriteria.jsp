<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
$(function() {
	var aa = $("#localname").val();
	var bb = $("#localempid").val();
	var cc = $("#localpostgradenoname").val();
	var dd = $("#localpostgradeotherinf").val();
	var ff = $("#localcenter").val();
	var gg = $("#localempofficename").val();
	if (gg != "" && typeof (gg) != "undefined") {
		$('#titlenameFAMILY').html(
				aa + " / " + bb + " / " + cc + "(" + dd + ") / " + ff + " / "
						+ gg);
	}

	var dataSearch = '${dataSearch}';
	if ('${lowerDepart}' == 'Y') {
		$('#lowerDepart_' + dataSearch).attr('checked', 'checked');
		$('#lowerDepart_' + dataSearch).attr('value', 'Y');
	}
	if ('${MAIN_LIAISON_OFFICE}' == 'Y') {
		$('#mainLianluo').attr('checked', 'checked');
	}
	if ('${FINAL_DEGREE_WHETHER}' == 'Y') {
		$('#FINAL_DEGREE_WHETHER').attr('value', 'Y');
		$('#FINAL_DEGREE_WHETHER').attr('checked', 'checked');
	}
});

function chaxunFAMILY(aa) {
	$('#viewPromotionCriteria').submit();
}
function chooseLowerFAMILY(aa) {
	var che = $('#lowerDepart_' + aa).prop('checked');
	if (che == true) {
		$('#lowerDepart_' + aa).attr('value', 'Y');
	} else {
		$('#lowerDepart_' + aa).attr('value', 'N');
	}
}
function shanchuFAMILY() {
	$('#titlenameFAMILY').html('');
	$('#PERSON_IDFAMILY').attr('value', '');
	$('#LOCAL_TITLEFAMILY').attr('value', '');
}

$("#hr3603_table",navTab.getCurrentPanel()).dataTable({"bPaginate": true,    //分页
    "bAutoWidth":false,//表格宽度自动变化
    "bProcessing":true,
    "lengthMenu": [[50,80,100,200,500,1000], [50,80,100,200,500,1000]],
	"bLengthChange": true,  //按多少条记录显示下拉框
	"iDisplayLength": 50, //默认每页显示的记录数
	"bFilter": true,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
 	"searching": true,//本地搜索
	"bSort": true,   //排序功能
	"bInfo": true,   //显示datatables的信息（底部的页数，条目数信息）
	"bScrollInfinite":true,
	"fixedColumns":{leftColumns: 3},
     "orderClasses": false,
     "order":[],//初始化不用自动排序
     "scrollY": $(document.body).height() - 390,
     "scrollX": true,
     "scrollCollapse": false,
     "deferRender":true,
     //"scroller":true,
    "oLanguage": {//多语言配置
		"sProcessing": "<spring:message code='hem.alert.empinfo.Is_loading' />",//正在加载中......
		"sZeroRecords": "<spring:message code='hem.alert.empinfo.not_find_relevant_data' />",//查询不到相关数据！
		"sEmptyTable": "<spring:message code='hrm.alert.empinfo.No_data_in_table' />",//表中无数据存在！
	 	"sSearch": "<spring:message code='hrm.alert.contractInfo.Rapid_screening' />",//快速筛选
		"sLengthMenu": "<spring:message code='hrm.alert.contractInfo.Record_page' />",//每页 _MENU_ 条记录
		"sInfo": "<spring:message code='hrm.alert.contractInfo.START_END_TOTAL' />",//从 _START_ 到 _END_ /共 _TOTAL_ 条数据
		"sInfoFiltered": "(<spring:message code='hrm.alert.contractInfo.Record_filter' />)",//从 _MAX_ 条记录过滤
		"oPaginate": {
   	 		"sPrevious": "<spring:message code='hrm.alert.contractInfo.Previous_page' />",//上一页
    		"sNext": "<spring:message code='hrm.alert.contractInfo.NEXT_PAGE' />"//下一页
        }
    },
    "sDom":'<"top"r<"clear">fBl>t<"bottom"ip<"clear">>',
    "buttons": [
          ] 
});

function changeFAMILYINFOR(no, status, id, aid) {
	var idvalue = $('#' + id).val();
	var idhref = '/hrm/empinfo/searchTanchu?PARENT_CODE_NO=' + no
			+ '&firstFlag=N&status=' + status + '&nameid=' + id
			+ '&typeFlag=Y&idvalue=' + idvalue;
	$('#' + aid).attr('href', idhref);
}

function changeZhijiFAMILYINFOR(status, id, aid) {
	var idvalue = $('#' + id).val();
	var parentnoFAMILYINFOR = $('#POST_FAMILY_FAMILYINFOR').val();
	var idhref = '/hrm/empinfo/searchTanchu?PARENT_CODE_NO='
			+ parentnoFAMILYINFOR + '&firstFlag=N&status=' + status
			+ '&nameid=' + id + '&typeFlag=Y&idvalue=' + idvalue;
	$('#' + aid).attr('href', idhref);
}

function deleteFamilyInfoView() {
	var FAMILY_NO="";
	var flag=false;
	$("input[name='ACTIVITY']",navTab.getCurrentPanel()).each(function(){
		if($(this).attr("checked") == "checked"){
			FAMILY_NO = FAMILY_NO  + $(this).val() + ",";
			flag = true;
		}
	});
	return false;
}
</script>
<form id="viewPromotionCriteria" method="post" action="/hrm/empinfo/viewPromotionCriteria" class="pageForm required-validate" onsubmit="return navTabSearch(this);">
		
		<input type="hidden" id="PERSON_IDFAMILY" name="PERSON_ID"
				value="${PERSON_ID }">
			<input type="hidden" id="LOCAL_TITLEFAMILY" name="LOCAL_TITLE"
				value="${LOCAL_TITLE }">
			<input type="hidden" id="dataSearch" name="dataSearch" value="family">
			<input type="hidden" id="FLAG" name="FLAG" value="1">
<div class="pageHeader">
<div class="searchBar" >
	<table class="searchContent">

		<tr>
			<td><!-- 社号/姓名 --><spring:message code="hrm.empinfo.nameAndEmpid"/></td>
			<td>
				<div style="float: left"><input type="text" name="KEY" id="KEY" value="${KEY}"/></div>
			</td>
			<td><spring:message code="hr.viewPersonalInfo.title.DEPTNAME" /></td>
			<td>
			    <ait:deptTreeMulti id="DEPTNO_Multi" name="DEPT_NAME" limit="ar" selectedNm="${DEPT_NAME}" selected="${DEPTNO_Multi}"></ait:deptTreeMulti>
			</td>
			<td><!-- 职群  --><spring:message code="ess.empInfo.zhiqun"/></td>
			<td>
				<ait:SelectSyCodeByCpnyID id="POST_FAMILY" name="POST_FAMILY" parentNo="14015812" selected="${POST_FAMILY}" limit="ALL"/>
			</td>
				
		</tr>
		
	</table>
	<input type="hidden" id="localname" value="${personinfo.LOCAL_NAME }">
	<input type="hidden" id="localempid" value="${personinfo.EMPID }">
	<input type="hidden" id="localpostgradenoname"
		value="${personinfo.POST_GRADE_NO_NAME_TITLE }">
	<input type="hidden" id="localpostgradeotherinf"
		value="${personinfo.POST_GRADE_OTHERINF }">
	<input type="hidden" id="localcenter"
		value="${personinfo.COST_CENTER_TITLE }">
	<input type="hidden" id="localempofficename"
		value="${personinfo.EMP_OFFICE_NAME_TITLE }">
	<input type="hidden" id="beginSearch" value="family">
</div>
</div>
<!-- 家庭搜索 -->
<div id="family" style="width: 99%;margin-left:auto;margin-right:auto;"
	>
	
		<div class="formBar">

			<ul class="toolBar">
				<li>
					<a class="buttonActive" onclick="chaxunFAMILY('family')" href="#">
					<span><spring:message code="button.search" /><!--查询--></span>
					</a>
				</li>
				
				<li>
					<a class="buttonActive" href="/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=42">
						<span><spring:message code="hrm.empinfo.EXPORT" /><!--导出到EXECL--></span>
					</a>
				</li>
				<li><a class="buttonActive" 
		onclick="downloadExcel('viewPromotionCriteria','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=42&CPNY=${LoginUser.cpnyId}','/hrm/empinfo/viewPromotionCriteria?firstFlag=N')"><span>
		<spring:message code="hrm.empinfo.EXPORT" /><!--导出到EXECL--></span></a>
				</li>
			</ul>
		</div>
		<table class="orderList" id="hr3603_table" width="3000px" cellpadding="2" cellspacing="1">
			<thead>
		   <tr>
				<th rowspan=4 >No</th>
				<th rowspan=4  >Emp ID</th>
				<th rowspan=4 width="140px" >Name</th>
				<th rowspan=4  >Team</th>
				<th rowspan=4  >Dept</th>
				<th rowspan=4 width="60px"  >Status</th>
				<th colspan=10  >Position</th>
				<th colspan=3  >Old company</th>
				<th colspan=4  >HAE</th>
				<th rowspan=4  >Total experience</th>
				<th rowspan=4  >Promotion day</th>
				<!-- <th rowspan=4  width="140px" >Rewarded</th> -->
				<!-- <th rowspan=4  width="140px" >Discipline</th> -->
				<th colspan=6 rowspan=2  >EVALUATION RESULTS</th>
				<th rowspan=4  >Rewarded</th>
				<th rowspan=4  >Discipline</th>
				<th colspan=3 rowspan=2  >FINAL RESULT</th>
				</tr>
			<tr>
				<th colspan=2   >2017</th>
				<th colspan=2   >2018</th>
				<th colspan=2   >2019</th>
				<th colspan=2   >2020</th>
				<th colspan=2   >2021</th>
				<th rowspan=3  >Experience</th>
				<th rowspan=3  >Total time record</th>
				<th rowspan=3  >Promotion Standard data<br></th>
				<th rowspan=3  >Entry date</th>
				<th rowspan=3  >Unpaid leave</th>
				<th rowspan=3 width="80px" >Total time record</th>
				<th rowspan=3  >Actually working time</th>
				</tr>
			<tr>
				<th rowspan=2  >Position</th>
				<th rowspan=2  >Level</th>
				<th rowspan=2  >Position</th>
				<th rowspan=2  >Level</th>
				<th rowspan=2  >Position</th>
				<th rowspan=2  >Level</th>
				<th rowspan=2  >Position</th>
				<th rowspan=2  >Level</th>
				<th rowspan=2  >Position</th>
				<th rowspan=2  >Level</th>
				<th colspan=2   >2018</th>
				<th colspan=2   >2019</th>
				<th colspan=2   >2020</th>
				<th rowspan=2  >01/03/2021</th>
				<th rowspan=2  >Promotion base date</th>
				<th rowspan=2  >Difference from reference (years)</th>
			</tr>
			<tr>
				<th  >Achievement</th>
				<th  >1st Achievement</th>
				<th  >1st Achievement</th>
				<th  >2nd Achievement</th>
				<th  >1st Achievement</th>
				<th  >2nd Achievement</th>
			</tr>
				
			</thead>
			<c:forEach items="${viewPromotionCriteria }" var="a" varStatus="i">
				<tr>
					<td class="td_type">${i.count }</td>
					<td class="td_type">${a.EMPID }</td>
					<td class="td_type">${a.LOCAL_NAME }</td>
					<td class="td_type">${a.TEAM }</td>
					<td class="td_type">${a.DEPT }</td>
					<td class="td_type">${a.EMP_OFFICE_NAME }</td>
					<td class="td_type">${a.POST_GRADE_NO_2017 }</td>
					<td class="td_type">${a.PAY_STEP_NO_2017 }</td>
					<td class="td_type">${a.POST_GRADE_NO_2018 }</td>
					<td class="td_type">${a.PAY_STEP_NO_2018 }</td>
					<td class="td_type">${a.POST_GRADE_NO_2019 }</td>
					<td class="td_type">${a.PAY_STEP_NO_2019 }</td>
					<td class="td_type">${a.POST_GRADE_NO_2020 }</td>
					<td class="td_type">${a.PAY_STEP_NO_2020 }</td>
					<td class="td_type">${a.POST_GRADE_NO_2021 }</td>
					<td class="td_type">${a.PAY_STEP_NO_2021 }</td>
					<td class="td_type">${a.EXPERIENCE }</td>
					<td class="td_type">${a.TOTAL_TIME_RECORD }</td>
					<td class="td_type">${a.DETAIL_HR_DIFF }</td>
					<td class="td_type">${a.ENTRY_DATE }</td>
					<td class="td_type">${a.UNPAID_LEAVE }</td>
					<td class="td_type">${a.TOTAL_TIME }</td>
					<td class="td_type">${a.ACTUALLY_WORKING_TIME }</td>
					<%-- <td class="td_type">${a.POSITION_EXPERIENCE }</td> --%>
					<td class="td_type">${a.TOTAL_EXPERIENCE }</td>
					<td class="td_type">${a.START_TIME_MAX }</td>
					<%-- <td class="td_type">${a.HR_REWARD_TYPE }</td> --%>
					<%-- <td class="td_type">${a.PUNISH_CODE }</td> --%>
					<td class="td_type">${a.P_EVS_2018 }</td>
					<td class="td_type">${a.A_EVS_2018 }</td>
					<td class="td_type">${a.P_EVS_2019 }</td>
					<td class="td_type">${a.A_EVS_2019 }</td>
					<td class="td_type">${a.P_EVS_2020 }</td>
					<td class="td_type">${a.A_EVS_2020 }</td>
					<td class="td_type">${a.HR_REWARD_TYPE }</td>
					<td class="td_type">${a.PUNISH_CODE }</td>
					<td class="td_type">${a.BASE_DATE_DIFF }</td>
					<td class="td_type">${a.PROMOTION }</td>
					<td class="td_type">${a.PROMOTION - a.BASE_DATE_DIFF }</td>
				</tr>
			
				
			</c:forEach>
		</table>
		</div>
	</form>

