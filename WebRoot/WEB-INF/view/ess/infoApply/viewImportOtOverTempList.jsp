<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<div class="pageHeader">
	<form id="viewArDetailDataExcelImportResult" name="viewArDetailDataExcelImportResult"
			action="/ess/infoApply/viewImportOtOverTempList" 
			onsubmit="return navTabSearch(this);"
			method="post" >
	<div class="searchBar" >
		<table class="searchContent">
			<tr>
				<td>
					<spring:message code="inct.salesman.excel.totalCnt"/><!-- 总行数-->
				</td>
				<td>
					${totalCnt}
					<iframe id='callbackframe' name='callbackframe' src='about:blank' style='display:none'></iframe>
				</td>
				<td>
					<spring:message code="inct.salesman.excel.errCnt"/><!-- 出错行数-->
				</td>
				<td>							
					${errCnt}
				</td>
				<td>
					<spring:message code="pa.salary.canShu.chuCuoYuFou"/><!-- 出错与否-->
				</td>
				<td>							
					<select name="seach_RESULT_FLAG" id="seach_RESULT_FLAG">
							<option value="" <c:if test="${RESULT_FLAG eq '' }">selected</c:if>><!--全部--><spring:message code="org.title.ALL"/></option>
							<option value="E" <c:if test="${RESULT_FLAG eq 'E' }">selected</c:if>><!--是--><spring:message code="org.title.YES"/></option>
							<option value="N" <c:if test="${RESULT_FLAG eq 'N' }">selected</c:if>><!--否--><spring:message code="ar.viewcycle.content.no"/></option>
					</select>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="submit">
								<spring:message code="public.title.search"/><!-- 检索 -->
							</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent" width = "1800px">
	<div class="formBar">
		<ul>			
			<%-- <li>
				<a class="buttonActive" onclick="excelimport_ess3403();">
					<span><spring:message code="ar.addempshift.title.excelimport"/><!-- EXCEL导入 --></span>
				</a></li> --%>
			<li>
				<a class="buttonActive" target="ajaxTodo" callback="navTabAjaxDoneRefreshCurrentPage" 
					href="/ess/infoApply/submitImportExcelOtOverData" title="<spring:message code="org.title.IS_SUBMIT"/>"><span>
				<spring:message code="public.title.submit"/><!--提交--></span></a>
			</li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="220" nowrapTD="false">
		<thead>
			<tr>
				<th>Line<!--excel行号--></th>
				<th><!--姓名--><spring:message code="ess.infoApply.NAME"/></th>
				<th><!--工号--><spring:message code="ess.infoApply.EMPID"/></th>
				<th><!--部门--><spring:message code="ess.infoApply.DEPT"/></th>
				<th><!--加班日期--><spring:message code="ess.infoApply.title.overtimeTime"/></th>
				<th><!--开始日期--><spring:message code="public.title.startDate" /></th>
				<th><!--开始时间--><spring:message code="ess.infoApply.title.startTime"/></th>
				<th><!--结束日期--><spring:message code="public.title.endDate" /></th>
				<th><!--结束时间--><spring:message code="ess.infoApply.title.endTime"/></th>
				<th><!--跨天--><spring:message code="ess.title.KUATIAN"/></th>
				<th><!--吃饭与否--><spring:message code="ess.viewSSTOtApplyInfo.DEDUCT_MEAL_TIME_YN.b"/></th>
				<th><!-- 用车--><spring:message code="ess.title.USE_CAR"/></th>
				<th><!-- 用车--><spring:message code="ess.title.NAME_CAR"/></th>
				<th><!-- 用车--><spring:message code="ess.title.ADDRESS_CAR"/></th>
				<!--<th>调休</th>
				<th>特殊</th>-->
				<th><!--时长--><spring:message code="ess.infoApply.duration"/></th>
				<th><!--原因--><spring:message code="ess.infoApply.Reason"/></th>
				<th><!-- 审批者1 --><spring:message code="sys.affirm.title.affirmPerson"/> 1</th>
				<th><!-- 审批者2 --><spring:message code="sys.affirm.title.affirmPerson"/> 2</th>
				<th><!-- 审批者3 --><spring:message code="sys.affirm.title.affirmPerson"/> 3</th>
				<th><!-- 审批者4 --><spring:message code="sys.affirm.title.affirmPerson"/> 4</th>
				<%-- <th><!--审批状态--><spring:message code="ess.infoApply.approval_status"/></th> --%>
				<th><spring:message code="inct.salesman.validateMessage"/><!--验证结果--></th>
				<%-- <th><!--上传人--><spring:message code="org.title.UPLOAD_BY"/></th>
				<th><!--上传时间--><spring:message code="org.title.UPLOAD_DATE"/></th>	 --%>		
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${otTempList}" var="item" varStatus="i">			
				<tr>
					<td class='td_center'>${item.LINE_ID}</td>
					<td class='td_center'>${item.APPLY_NAME}</td>
					<td class='td_center'>${item.EMPID}</td>
					<td class='td_center'>${item.DEPTNAME}</td>
					<td class='td_center'>${item.APPLY_OT_DATE}</td>
					<td class='td_center'>${item.OT_FROM_DATE}</td>
					<td class='td_center'>${item.OT_FROM_TIME}</td>
					<td class='td_center'>${item.OT_TO_DATE}</td>
					<td class='td_center'>${item.OT_TO_TIME}</td>
					<td class='td_center'>${item.OFFSET_YN}</td>
					<td class='td_center'>${item.DEDUCT_YN}</td>
					<td class='td_center'>${item.USECAR_YN}</td>
					<td class='td_center'>${item.CAR_ADDRESS_NAME}</td>
					<td class='td_center'>${item.CAR_ADDRESS_DETAIL_NAME}</td>
					<!--<td class='td_center'>${item.SPECIAL_YN}</td>-->
					<td class='td_center'>${item.OT_APPLY_HOUR}</td>
					<td class='td_center'>${item.APPLY_OT_REMARK}</td>
					<td class='td_center'>${item.AFFIRMOR_ID_1}<br>${item.AFFIRMOR_NAME_1 }</td>
					<td class='td_center'>${item.AFFIRMOR_ID_2}<br>${item.AFFIRMOR_NAME_2 }</td>
					<td class='td_center'>${item.AFFIRMOR_ID_3}<br>${item.AFFIRMOR_NAME_3 }</td>
					<td class='td_center'>${item.AFFIRMOR_ID_4}<br>${item.AFFIRMOR_NAME_4 }</td>
					<%-- <td class='td_center'>${item.AFFIRM_FLAG_NAME}</td> --%>
					<td style="text-align:left">${item.UPLOAD_ERROR_MSG}</td>
					<%-- <td class='td_center'>${item.UPLOAD_BY}</td>
					<td class='td_center'>${item.UPLOAD_DATE}</td> --%>
				</tr>			
			</c:forEach>			
		</tbody>
	</table>
</div>