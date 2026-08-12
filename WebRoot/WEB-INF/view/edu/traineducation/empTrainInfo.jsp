<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage="" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
$(document).ready(function(){
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
	     "scrollY": $(document.body).height() - 270,
	     "scrollX": true,
	     "scrollCollapse": false,
	     "deferRender":true,
	     //"scroller":true,
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
        "buttons": [
              ] 
	});
});

function changeURL_ess3211(obj){
	var href = "/edu/traineducation/empTrainInfoWithSubject?EMPID=" + obj.id;
	$.pdialog.open(href,"ess3211", obj.title, {width:800,height:500,mask:true});//明细查看
}

</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);"
		action="/edu/traineducation/empTrainInfo" method="post" id="empTrainInfo" name="empTrainInfo">
		<input type="hidden" name='CODE_NO' /> <input type="hidden"
			name='ADMIN_ID' value="${LoginUser.adminID }" /> <input type="hidden"
			name="defaultRoleGroupName" value="${defaultRoleGroupName }">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<!-- 部门： --> <spring:message code="ess.infoApply.DEPT" />
					</td>
					<td><ait:deptList name="DEPT_NO" cpnyId="${defaultCpny}"
							id="empTrainInfo_seachDept" limit="super" /> <ait:deptTreeIcon	name="DEPT_NO" cpnyId="${defaultCpny}" limit="super"
							id="empTrainInfo_seachDept" selected="${DEPTNO}" />
					</td>
					<td><spring:message
							code="hr.viewContractByInsert.title.EMPIDANDLOCALNAME" />
						<!-- 社号/姓名 --></td>
					<td><input type="text" name="seach_KEY" value="${KEY}" /></td>

					<td class="text"><spring:message
							code="hrm.empinfo.EMP_OFFICE_NAME" /> <!-- 员工状态 --></td>
					<td class="td_type"><ait:SelectSyCodeByCpnyID
							name="EMP_OFFICE" id="EMP_OFFICE" parentNo="15118" selected="${EMP_OFFICE}" limit="all" /></td>

					
				</tr>
				<tr>
						<td><spring:message code="edu.studentEvaluate.SUBJECT_NO.a"/> <!--主题号--></td>
						<td><select name="EMP_SUBJECT_NO" id="EMP_SUBJECT_NO">
								<option value=""><spring:message code="hr.viewCondSql.title.QINGXUANZE" /><!--请选择--></option>
								<c:forEach items="${eduSubject}" var="result">
									<option value="${result.SUBJECT_NO}" name="${result.SUBJECT_NO}">${result.SUBJECT_NO}</option>
								</c:forEach>
						</select></td>
					
					
				</tr>
			</table>
			<div class="subBar" style="padding-top: 15px">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">
									<!-- 查询 -->
									<spring:message code="ess.infoApply.SELECT" />
								</button>
							</div>
						</div>
					</li>

				</ul>
			</div>
		</div>
	</form>
</div>

<div class="pageContent">
	<form name="empTrainInfo" id="empTrainInfo" method="post" action="empTrainInfo" onsubmit="return delLeaveApplyCallback(this, navTabAjaxDone);"
		target="dialog">
		<table class="orderList" border="1" width="99%" nowrapTD="false">
			<thead>
				<tr>
					<th>NO</th>
					<th><!--社号 --> <spring:message code="ess.infoApply.EMPID" /></th>
					<th><!--姓名 --> <spring:message code="ess.infoApply.NAME" /></th>
					<%-- <th><!--现住址 --> <spring:message code="hr.viewCondSql.title.XIANZHUZHIYOUBIAN" /></th>
					<th><!--入职日期--> <spring:message code="org.title.DATE_STARTED" /></th> --%>
					<th><!--部门--> <spring:message code="ess.infoApply.DEPT" /></th>
					<th><!--部门长 --> <spring:message code="org.title.MINISTER" /></th>
					<th><!--职级 --> <spring:message code="org.title.POST_GRADE_NAME" /></th>
					<th><!--职责 --> <spring:message code="hrm.contract.POSITION_NO" /></th>
					<th><!--主要业务 --> <spring:message code="hrm.empinfo.MAIN_BUSINESS_NAME" /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${empTrainInfo}" var="personList" varStatus="i">
					<tr target="sid" rel="">
						<td style="text-align: center">${i.count}</td>
						<td style="text-align: center">${personList.EMPID_ID}</td>
						<td style="text-align: center;"  title="${personList.LOCAL_NAME}" id="${personList.EMPID_ID}"
							onclick='javascript:changeURL_ess3211(this);'>
							<span style="color: blue">${personList.LOCAL_NAME}</span>
						</td>
						<%-- <td style="text-align: center">${personList.ADDRESS}</td>
						<td style="text-align: center">${personList.DATE_STARTED}</td> --%>
						<td style="text-align: center">${personList.DEPTNAME}</td>
						<td style="text-align: center">${personList.MANAGER_EMP_NAME}</td>
						<td style="text-align: center">${personList.POST_GRADE_NO}</td>
						<td style="text-align: center">${personList.POSITION_NAME}</td>
						<td style="text-align: center">${personList.MAIN_BUSINESS}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
	
</div>