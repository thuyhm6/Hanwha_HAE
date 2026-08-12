<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">

//判断工资是否开放
function getSalaryDispark() {

	var viewPaM = $("#viewPaMonthPersonInfoEssList_pay").attr("value");
	var PERSON_ID = viewPaM.split(',')[0];
	var PAY_SCHEDULE_NO = viewPaM.split(',')[1];
	var PA_OPEN_FLAG = viewPaM.split(',')[2];
	var PAY_DATE = viewPaM.split(',')[3];
	//alertMsg.info(PAY_DATE);

	if (PAY_DATE <= getNowFormatDate()) {

		if (PA_OPEN_FLAG == "1") {
			$("#viewarmonthpersoninfo").attr(
					"action",
					"/pa/salary/viewPaMonthPersonInfoEssList?PERSON_ID="
							+ PERSON_ID + "&PAY_SCHEDULE_NO=" + PAY_SCHEDULE_NO
							+ "&PAY_DATE=" + PAY_DATE);
			$("#viewarmonthpersoninfo").submit();
		} else {
			alertMsg.info("<spring:message code='liang.pa.salary.title.salary_NotDispark' />");//工资还未开放!

		}
	} else {
		alertMsg.info("<spring:message code='liang.pa.salary.title.salary_NotDispark' />");//工资未开放!

	}
}

function getNowFormatDate() {
	var date = new Date();
	var seperator1 = "-";
	var seperator2 = ":";
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var strDate = date.getDate();
	if (month >= 1 && month <= 9) {
		month = "0" + month;
	}
	if (strDate >= 0 && strDate <= 9) {
		strDate = "0" + strDate;
	}
	var currentdate = year + seperator1 + month + seperator1 + strDate + "";
	return currentdate;
}

$(function() {

	if ($("#display_PAY_SCHEDULE_NO").attr("value") == null
			|| $("#display_PAY_SCHEDULE_NO").attr("value") == "") {

		$("#viewPaMonthPersonInfoEssList_pageContent").css("display", "none");
	}
});
</script>
<div class="pageHeader">
	<form id="viewarmonthpersoninfo" onsubmit="return  navTabSearch(this)"
		name="viewarmonthpersoninfo"
		action="/pa/salary/viewPaMonthPersonInfoEssList?pageNum=1&numPerPage=0"
		method="post">
		<div class="searchBar">
			<input type="hidden" value="${CurrentOperator}" id="CurrentOperator">
			<table class="searchContent">
				<tr>
					<td>
					<!--工资支付计划--><spring:message code="ess.empInfo.pay_plan" />
					</td>
					<input type="hidden" value="${PAY_SCHEDULE_NO}"
						id="display_PAY_SCHEDULE_NO" />
					<td>

						<select id="viewPaMonthPersonInfoEssList_pay"
							onchange="getSalaryDispark();">
							<c:forEach items="${paPayScheduleNoByPersonId}" var="item">
								<option
									value="${item.PERSON_ID},${item.PAY_SCHEDULE_NO},${item.PA_OPEN_FLAG},${item.PAY_DATE}"
									<c:if test="${item.PAY_SCHEDULE_NO eq PAY_SCHEDULE_NO}">selected</c:if>>
									${item.SALARY_DISTIN}--${item.PAY_DATE}

								</option>
							</c:forEach>
						</select>

					</td>
					<td>
						<div class="subBar">
							<ul>
								<li>
									<div class="buttonActive">
										<div class="buttonContent">
											<button type="button" onclick="getSalaryDispark();">
												<!-- 查询 -->
												<div><spring:message code="button.search"  /></div>
											</button>
										</div>
									</div>
								</li>
								<li>
									<div class="buttonActive">
										<div class="buttonContent">
											<button type="button"  onclick="print()">
												<!-- 打印 -->
												<div><spring:message code="rp.report.title.print"  /></div>
											</button>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>
<c:if test="${personInfo.PAY_DATE ne null }">
	<div class="pageContent" id="viewPaMonthPersonInfoEssList_pageContent"
		sysLong='printDiv'
		style="width: 850px; padding-left: 10px; text-align: left;overflow: hidden;" >
	    <div style="height: 1240px;">
		<table width="100%">
			<tr height="100px">
				<td width="25%">
				<c:if test="${LoginUser.cpnyId eq 'HTSV'}">
				  <img src='/resources/images/logo.png'>
				</c:if>
				<c:if test="${LoginUser.cpnyId eq 'HAE'}">
				  <img src='/resources/images/logo.jpg'>
				</c:if>
				</td>
				<td style="font-size: 20px; text-align: center;"
					td_title" width="40%">
					PHIẾU LƯƠNG<br></br>${personInfo.PAY_DATE}</td>
				<td width="25%"></td>
			</tr>
		</table>
		<h2 class="thisPageStyle_pa0131">
			<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
			I/&nbsp;&nbsp;<!--基本事项--><spring:message code="ess.empInfo.basic_matters" />
		</h2>


		<table class="user_table" width="100%">
			<tr>
				<td class="td_title"
					style="text-align: center;">
					<!--姓名 --><spring:message code="ess.infoApply.NAME" />
					</td>
				<td class="td_type" style="text-align: center;">${personInfo.LOCAL_NAME}</td>
				<td class="td_title" style="text-align: center;"><!--工号 --><spring:message code="ess.infoApply.EMP_ID" /></td>
				<td class="td_type" style="text-align: center;">${personInfo.EMPID}</td>
				<td class="td_title" style="text-align: center;"><!--部门 --><spring:message code="ess.infoApply.DEPT" /></td>
				<td class="td_type" style="text-align: center;">${personInfo.DEPT_NAME}</td>
				<td class="td_title" style="text-align: center;"><!--员工类型 --><spring:message code="ess.infoApply.employee_type" /></td>
				<td class="td_type" style="text-align: center;">${personInfo.EMP_TYPE_NAME}</td>
			</tr>
			<tr>
				<td class="td_title" style="text-align: center;"><!--职群 --><spring:message code="ess.empInfo.zhiqun" /></td>
				<td class="td_type" style="text-align: center;">${personInfo.POST_FAMILY_NAME}</td>
				<td class="td_title" style="text-align: center;"><!--职级 --><spring:message code="ess.infoApply.Rank" /></td>
				<td class="td_type" style="text-align: center;">${personInfo.POST_GRADE_NAME}</td>
				<td class="td_title" style="text-align: center;"><!--职责--><spring:message code="ess.trans.title.dutyName" /></td>
				<td class="td_type" style="text-align: center;">${personInfo.POSITION_NAME}</td>
				<td class="td_title" style="text-align: center;"><!--员工状态 --><spring:message code="ess.empInfo.employee_status" /></td>
				<td class="td_type" style="text-align: center;">${personInfo.EMP_OFFICE_NAME}</td>
			</tr>
		</table>
		<c:if test="${PAY_SCHEDULE_NO eq '136' || PAY_SCHEDULE_NO eq '151' || PAY_SCHEDULE_NO eq '163' || PAY_SCHEDULE_NO eq '179'}">
		<br> 
		<h2 class="thisPageStyle_pa0131">
			<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
			II/&nbsp;&nbsp;<!--合同信息--><spring:message code="pa.payStub.CONTRACT_INFO" /></h2>
		<table class="user_table" width="100%">
			<tr>
				<td class="td_title" style="text-align: center;" width="13%"><!--项目--><spring:message code="ess.empInfo.project" /></td>
				<td class="td_title" style="text-align: center;" width="13%"><!--金额--><spring:message code="ess.empInfo.amount_of_money" /></td>
			</tr>
			<c:forEach items="${payStubList}" var="item">
				<c:if test="${item.ITEM_TYPE eq 4}">
						<tr>
							<c:if test="${item.ITEM_NO eq 570067}">
							<td class="td_type" style="text-align: center;">${item.ITEM_NAME}</td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
							</c:if>
							
						</tr>
				</c:if>
			</c:forEach>
		</table>
		<div style="width: 100%; float: left; position: relative; top: 5px; margin-bottom: 10px;">
			<table class="user_table"
				style="position: relative; bottom: 5px; height: 30px" width="100%">
				<tr>
					<td class="td_type" style="text-align: center;font-weight: bold;" width="50%">
						<!--基本工资＋所有津贴--><spring:message code="pa.payStub.JIBENGONGZI_JIA_JINTIE.b" />
					</td>
					<td class="td_type" style="text-align: right;font-weight: bold;" width="50%"><c:set value="${0}" var="countAll4" />
						<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_TYPE eq 4}">
							<c:if test="${item.ITEM_NO eq 570067}">
							<c:set value="${item.ITEM_VALUE +countAll4}" var="countAll4" />
							</c:if>
						</c:if>
						</c:forEach>
						<fmt:formatNumber value="${countAll4}" pattern="#,##0" />
					</td>
				</tr>
			</table>
		</div>
		<br> 
		<h2 class="thisPageStyle_pa0131">
			III/&nbsp;&nbsp;<!--合同信息--><spring:message code="ess.empInfo.salary_detail" /></h2>
		<table class="user_table" width="100%" >
				<tr>
					<td class="td_type" width="30%" style="text-align: center;font-weight: bold;" colspan="2"><!--项目--><spring:message code="ess.empInfo.project" /></td>
					<c:if test="${PAY_SCHEDULE_NO eq '163' || PAY_SCHEDULE_NO eq '179'}">
						<td class="td_type" width="25%" style="text-align: center" > Số ngày được tính thưởng Tết trong năm </td>
						<td class="td_type" width="25%" style="text-align: center" > Số ngày tiêu chuẩn trong năm </td>
					</c:if>
					<c:if test="${PAY_SCHEDULE_NO ne '163' && PAY_SCHEDULE_NO ne '179'}">
						<td class="td_type" width="25%" style="text-align: center" > Số tháng được tính thưởng Tết trong năm </td>
					</c:if>
					<td class="td_type" width="20%" style="text-align: center"><!--金额--><spring:message code="ess.empInfo.amount_of_money" /></td>
				</tr>
				<tr>
					<td class="td_title" width="30%" colspan="2" style="text-align: center">Thưởng Tết (1)</td>
					<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 500001}">
						<td class="td_type" width="25%" style="text-align: right" >${item.ITEM_VALUE}</td>
						</c:if>
					</c:forEach>
					<c:if test="${PAY_SCHEDULE_NO eq '163' || PAY_SCHEDULE_NO eq '179'}">
						<c:forEach items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_NO eq 500002}">
							<td class="td_type" width="25%" style="text-align: right" >${item.ITEM_VALUE}</td>
							</c:if>
						</c:forEach>
					</c:if>
					<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570049}">
						<td class="td_type" width="20%" style="text-align: right" ><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0"/></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td class="td_title" width="70%" colspan="4" style="text-align: center">Thưởng Tết (2)</td>
					<td class="td_type" width="30%" style="text-align: right" width="25%">500,000</td>
				</tr>
				<tr>
					<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570051}">
						<td class="td_title" width="20%"  colspan="4" style="text-align: center">${item.ITEM_NAME}  (3)</td>
						</c:if>
					</c:forEach>
					<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570051}">
						<td class="td_type" width="20%" style="text-align: right" ><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0"/></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td class="td_title" width="60%"  colspan="4" style="text-align: center;font-weight: bold;" >Thưởng Tết thực lĩnh (1 + 2 - 3)</td>
					<%-- <c:if test="${PAY_SCHEDULE_NO eq '163'}">
						<td class="td_type" width="15%" style="text-align: right" ></td>
					</c:if> --%>
					<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570054}">
						<td class="td_type" width="25%" style="text-align: right;font-weight: bold;" width="25%"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0"/></td>
						</c:if>
					</c:forEach>
				</tr>
				
			</table>
			<br>
			
		</c:if>
		<c:if test="${PAY_SCHEDULE_NO ne '136' && PAY_SCHEDULE_NO ne '151' && PAY_SCHEDULE_NO ne '163' && PAY_SCHEDULE_NO ne '179'}">
		<c:if test="${LoginUser.cpnyId eq 'HAE'}">
			<br>
			<h2 class="thisPageStyle_pa0131">
				<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
				II/&nbsp;&nbsp;<!--年假信息--><spring:message code="ess.infoApply.year_leave_information" /></h2>
			<table class="user_table" width="100%">
				<tr>
					<td class="td_title" style="text-align: center;" width="13%">
						<!--年假总数--><spring:message code="ess.infoApply.sum_year_leave_days" />
					</td>
					<td class="td_title" style="text-align: center;" width="13%">
						<!--已使用--><spring:message code="ess.infoApply.already_used" />
					</td>
				    <td class="td_title" style="text-align: center;" width="13%">
						<!--年假剩余--><spring:message code="ess.infoApply.nianjiashengyu" />
					</td>
				</tr>
				<c:forEach items="${paEmpVacInfo}" var="item">
					<tr>
						<td style="text-align: center;" class="td_type">
							${item.TOT_VAC_CNT + item.LAST_YEAR_VAC + item.ADD_VAC}
						</td>
						<td style="text-align: center;" class="td_type">
							${item.USE_VAC + item.USE_VAC_CNT + item.AFFIRM_USE_VAC}
						</td>
						<td style="text-align: center;" class="td_type">
							${item.LAST_YEAR_VAC + item.TOT_VAC_CNT + item.ADD_VAC - item.USE_VAC - item.AFFIRM_USE_VAC - item.USE_VAC_CNT}
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<br>
		<h2 class="thisPageStyle_pa0131">
			<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
			III/&nbsp;&nbsp; <!--帐号--><spring:message code="ess.empInfo.account_number" />
		</h2>
		<table class="user_table" width="100%">
			<%-- <tr>
				<td class="td_title" style="text-align: center;" width="13%">
				<!--银行--><spring:message code="ess.empInfo.bank" />
				</td>

				<td class="td_title" style="text-align: center;" width="13%">
					<!--帐号--><spring:message code="ess.empInfo.account_number" />
				</td>


			</tr> --%>
			<c:forEach items="${paEmpAccount}" var="item">
				<tr>
					<td style="text-align: center;" class="td_type">
						${item.ACCOUNT_TYPE }</td>
					<td style="text-align: center;" class="td_type">
						${item.ACCOUNT_NO } </td> </tr> </c:forEach> 
		</table>
		<br>
		<h2 class="thisPageStyle_pa0131">
			<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
			IV/&nbsp;&nbsp;<!--标准项目--><spring:message code="pa.viewSalaryCodeList.BIAOZHUNXIANGMU.b" /></h2>
		<table class="user_table" width="100%">
			<tr>
				<td class="td_title" style="text-align: center;" width="13%">
					<!--项目--><spring:message code="ess.empInfo.project" /></td>
				<td class="td_title" style="text-align: center;" width="13%">
					<!--金额--><spring:message code="ess.empInfo.amount_of_money" /></td>
			</tr>
			<c:forEach items="${payStubList}" var="item">
				<c:if test="${item.ITEM_TYPE eq 4}">
						<tr>
							<td class="td_type" style="text-align: center;">${item.ITEM_NAME}</td>
							<c:if test="${item.ITEM_NO eq 540000 && personInfo.EMP_TYPE_CODE eq 10416}">
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE / 0.8}" pattern="#,##0" /></td>
							</c:if>
							<c:if test="${item.ITEM_NO eq 540000 && personInfo.EMP_TYPE_CODE ne 10416}">
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
							</c:if>
							<c:if test="${item.ITEM_NO ne 540000}">
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
							</c:if>
						</tr>
				</c:if>
			</c:forEach>
		</table>
		<div style="width: 100%; float: left; position: relative; top: 5px; margin-bottom: 10px;">
			<table class="user_table"
				style="position: relative; bottom: 5px; height: 30px" width="100%">
				<tr>
					<td class="td_type" style="text-align: center;" width="50%">
						<!--基本工资＋所有津贴--><spring:message code="pa.payStub.JIBENGONGZI_JIA_JINTIE.b" />
					</td>
					<td class="td_type" style="text-align: right" width="50%"><c:set value="${0}" var="countAll4" />
						<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_TYPE eq 4}">
							<c:if test="${item.ITEM_NO eq 540000 && personInfo.EMP_TYPE_CODE eq 10416}">
							<c:set value="${item.ITEM_VALUE / 0.8 +countAll4}" var="countAll4" />
							</c:if>
							<c:if test="${item.ITEM_NO eq 540000 && personInfo.EMP_TYPE_CODE ne 10416}">
							<c:set value="${item.ITEM_VALUE+countAll4}" var="countAll4" />
							</c:if>
							<c:if test="${item.ITEM_NO ne 540000}">
							<c:set value="${item.ITEM_VALUE+countAll4}" var="countAll4" />
							</c:if>
						</c:if>
						</c:forEach>
						<fmt:formatNumber value="${countAll4}" pattern="#,##0" />
					</td>
				</tr>
			</table>
		</div>
		<br> 
		<div style="width: 100%; "> <h2	class="thisPageStyle_pa0131"> 
		<!-- style="background-image:url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg');background-repeat: no-repeat" -->
		V/&nbsp;&nbsp;<!-- 出勤明细 --><spring:message code="ess.empInfo.attendance_detail" /></h2> </div> 
		<%-- <div style="width: 33%; float: left;"> <h2 class="thisPageStyle_pa0131"
		style="background-image:
		url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg');
		background-repeat: no-repeat">&nbsp;&nbsp;<!-- 工资明细--><spring:message code="ess.empInfo.salary_detail" /></h2> 
		</div> 
		<div style="width: 33%; float: left;"> <h2 class="thisPageStyle_pa0131"
		style="background-image:
		url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg');
		background-repeat: no-repeat">&nbsp;&nbsp;<!-- 扣除明细  --><spring:message code="ess.empInfo.deduction_detail" /></h2> 
		</div> --%>
		<c:set var="dataSize" value="0"></c:set>
		<c:set var="maxHeightData" value="0"></c:set>
		<c:forEach items="${payStubList}" var="item" varStatus="i">
			<c:if test="${item.ITEM_TYPE eq 1}">
				<c:set var="dataSize" value="${dataSize + 1 }"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="maxHeightData" value="${dataSize }">
		</c:set>
		<c:set var="dataSize" value="0"></c:set>
		<c:forEach items="${payStubList}" var="item" varStatus="i">
			<c:if test="${item.ITEM_TYPE eq 2}">
				<c:set var="dataSize" value="${dataSize + 1 }"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="maxHeightData" value="${dataSize }">
        </c:set>
        <c:set var="dataSize" value="0"></c:set>
        <c:forEach items="${payStubList}" var="item" varStatus="i">
            <c:if test="${item.ITEM_TYPE eq 5 }">
                <c:set var="dataSize" value="${dataSize + 1 }"></c:set>
            </c:if>
        </c:forEach>
		<c:if test="${dataSize > maxHeightData }">
			<c:set var="maxHeightData" value="${dataSize }"></c:set>
		</c:if>
		<c:set var="dataSize" value="0"></c:set>
		<c:forEach items="${payStubList}" var="item" varStatus="i">
			<c:if test="${item.ITEM_TYPE eq 3}">
				<c:set var="dataSize" value="${dataSize + 1 }"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="maxHeightData" value="${dataSize }">
        </c:set>
        <c:set var="dataSize" value="0"></c:set>
        <c:forEach items="${payStubList}" var="item" varStatus="i">
            <c:if test="${item.ITEM_TYPE eq 7 }">
                <c:set var="dataSize" value="${dataSize + 1 }"></c:set>
            </c:if>
        </c:forEach>
		<c:if test="${dataSize > maxHeightData }">
			<c:set var="maxHeightData" value="${dataSize }"></c:set>
		</c:if>
		<div style="width: 100%;  height: ${maxHeightData*40+50}px; border: 1px solid #DBDBD8; left: 2px;"> <!-- 津贴明细 -->
			<table class="user_table" width="100%" style = "border-left:hidden; border-right:hidden;">
				<tr>
					<td class="td_type" width="60%" style="text-align: center;font-weight: bold;" colspan="2"><!--应出勤天数--><spring:message code="ess.infoApply.yingchuqintianshu" /></td>
						<c:forEach items="${payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 500002}">
						<td class="td_type" width="15%" style="text-align: center" width="25%">${item.ITEM_VALUE} <spring:message code="ar.viewsummaryparameteritem.title.day" /></td>
						<td class="td_type" width="25%" style="text-align: center" width="25%">${item.ITEM_VALUE * 8} <spring:message code="ar.viewsummaryparameteritem.title.hour" /></td>
						</c:if>
						</c:forEach>
				</tr>
				<tr>
					<td class="td_title" width="60%" colspan="2" style="text-align: center;font-weight: bold;"><!--考勤项目--><spring:message code="ess.empInfo.attendance_item" /></td>
					<td class="td_title" width="15%" style="text-align: center;font-weight: bold;"><!--时数--><spring:message code="pa.payStub.HOURS" /></td>
					<td class="td_title" width="25%" style="text-align: center;font-weight: bold;"><!--钱--><spring:message code="pa.detailItemCountInfo.SHIJIQUFEN.b" /></td>
				</tr>
				<tr>
					<td class="td_type" style="text-align: center;font-weight: bold;"width="10%">A</td>
					<td class="td_type" style="text-align: left;font-weight: bold;"width="50%"><spring:message code="ess.title.HUIZONGGONGSHI" /></td>
					<td class="td_type" style="text-align: right;font-weight: bold;" width="15%">${personInfo.PROBATION_DAYS*8 + personInfo.REGULAR_DAYS*8}</td>
					<td class="td_type" style="text-align: right;font-weight: bold;" width="25%"><fmt:formatNumber value="${personInfo.BASIC_SALARY}" pattern="#,##0" /></td>
				</tr>
			</table>
			<table class="user_table" width="75.16%" style = "border-left:hidden; float: left">
				<tr>
					<td class="td_type" width="13.34%" style="text-align: center;font-weight: bold;">B</td>
					<td class="td_type" width="66.66%" style="text-align: left;font-weight: bold;"><!--加班时数--><spring:message code="ess.infoApply.jiabanshishu" /></td>
					<td class="td_type" style="text-align: right;font-weight: bold;"width="19.8%"><c:set value="${0}" var="countAll9" /> <c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 5}">
								<c:set value="${item.ITEM_VALUE+countAll9}" var="countAll9" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAll9}" pattern="#,##0" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 5}">
						<tr>
							<td class="td_type" style="text-align: center;"></td>
							<td class="td_type" style="text-align: left;">${item.ITEM_NAME}</td>
							<td class="td_type" style="text-align: right;">${item.ITEM_VALUE}</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<table class="user_table" width="24.8%" style = "border-left:hidden; border-right:hidden;float: left">
				<tr>
					<td class="td_type" style="text-align: right;font-weight: bold;"width="15%"><c:set value="${0}" var="countAl20" /> <c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 6}">
								<c:set value="${item.ITEM_VALUE+countAl20}" var="countAl20" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl20}" pattern="#,##0" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 6}">
						<tr>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<table class="user_table" width="75.16%" style = "border-left:hidden; float: left">
				<tr>
					<td class="td_type" width="13.34%" style="text-align: center;font-weight: bold;">C</td>
					<td class="td_type" width="66.66%" style="text-align: left;font-weight: bold;"><!--夜班时数--><spring:message code="pa.payStub.NIGHT_WORK_HOURS" /></td>
					<td class="td_type" style="text-align: right;font-weight: bold;"width="19.8%"><c:set value="${0}" var="countAl21" /> <c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 1 && (item.ITEM_NO eq 500128 || item.ITEM_NO eq 500129)}">
								<c:set value="${item.ITEM_VALUE+countAl21}" var="countAl21" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl21}"  /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 1 && (item.ITEM_NO eq 500128 || item.ITEM_NO eq 500129)}">
						<tr>
							<td class="td_type" style="text-align: center;"></td>
							<td class="td_type" style="text-align: left;">${item.ITEM_NAME}</td>
							<td class="td_type" style="text-align: right;">${item.ITEM_VALUE}</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<table class="user_table" width="24.8%" style = "border-left:hidden; border-right:hidden;float: left">
				<tr>
					<td class="td_type" style="text-align: right;font-weight: bold;"width="15%"><c:set value="${0}" var="countAl22" /> <c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 2 && (item.ITEM_NO eq 570101 || item.ITEM_NO eq 570102)}">
								<c:set value="${item.ITEM_VALUE+countAl22}" var="countAl22" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl22}" pattern="#,##0" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 2 && (item.ITEM_NO eq 570101 || item.ITEM_NO eq 570102)}">
						<tr>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<table class="user_table" width="100%" style = "border-left:hidden; float: left">
				<tr>
					<td class="td_type" width="10%" style="text-align: center;font-weight: bold;">D</td>
					<td class="td_type" width="50.14%" style="text-align: left;font-weight: bold;"><!--总福利--><spring:message code="pa.payStub.ALLOWANCE_TOTAL" /></td>
					<td class="td_type" width="14.86%" style="text-align: center;font-weight: bold;"></td>
					<td class="td_type" style="text-align: right;font-weight: bold;"width="25%"><c:set value="${0}" var="countAl23" /> <c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 2 && (item.ITEM_NO eq 570001 || item.ITEM_NO eq 570003 || item.ITEM_NO eq 90000484 || item.ITEM_NO eq 90000516 
							|| item.ITEM_NO eq 570005 || item.ITEM_NO eq 570096 || item.ITEM_NO eq 570008 || item.ITEM_NO eq 540094 || item.ITEM_NO eq 540014
							|| item.ITEM_NO eq 570097 || item.ITEM_NO eq 570095 || item.ITEM_NO eq 570100 || item.ITEM_NO eq 90000477 || item.ITEM_NO eq 90000539
							|| item.ITEM_NO eq 90000546|| item.ITEM_NO eq 90000552 || item.ITEM_NO eq 570004)}">
								<c:set value="${item.ITEM_VALUE+countAl23}" var="countAl23" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl23}" pattern="#,##0" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 2 && (item.ITEM_NO eq 570001 || item.ITEM_NO eq 570003 || item.ITEM_NO eq 90000484 || item.ITEM_NO eq 90000516 
							|| item.ITEM_NO eq 570005 || item.ITEM_NO eq 570096 || item.ITEM_NO eq 570008 || item.ITEM_NO eq 540094 || item.ITEM_NO eq 540014
							|| item.ITEM_NO eq 570097 || item.ITEM_NO eq 570095 || item.ITEM_NO eq 570100 || item.ITEM_NO eq 90000477 || item.ITEM_NO eq 90000539
							|| item.ITEM_NO eq 90000546|| item.ITEM_NO eq 90000552 || item.ITEM_NO eq 570004)}">
						<tr>
							<td class="td_type" style="text-align: center;"></td>
							<td class="td_type" style="text-align: left;">${item.ITEM_NAME}</td>
							<td class="td_type" style="text-align: right;"><c:if test="${item.ITEM_NO eq 570100 }">${personInfo.WORMEN_HOURS/60}</c:if>
							<c:if test="${item.ITEM_NO eq 570004 }">${personInfo.LONG_ATTENDANCE_MONTHS}</c:if></td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
		<div style="width: 100%; border: 1px solid #DBDBD8;">
			<table class="user_table" style="border:hidden;" width="100%">
				<tr>
					<td class="td_type" width="10%" style="text-align: center;font-weight: bold;">E</td>
					<td class="td_type" width="65%" style="text-align: left;font-weight: bold;">
					<!--总工资--><spring:message code="hrm.approve.AMOUNT" /> A+B+C+D+ <spring:message code="pa.paSummary.P_CONDOLENCES.b" /> + G <spring:message code="sys.basic.title.ifAny" /> </td>
					<td class="td_type" style="text-align: right;font-weight: bold;">
						<c:set value="${0}" var="countAll2" /> <c:set value="${0}" var="countAll22" /> 
						<c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<%-- <c:if test="${item.ITEM_TYPE eq 2 and item.ITEM_NO ne 570036  and item.ITEM_NO ne 570049 and item.ITEM_NO ne 570050 and item.ITEM_NO ne 570054 and item.ITEM_NO ne 570039}"> --%>
							<c:if test="${item.ITEM_TYPE eq 2 and item.ITEM_NO eq 570049 }">
								<c:set value="${item.ITEM_VALUE+countAll2}" var="countAll2" />
							</c:if>
							<c:if test="${item.ITEM_TYPE eq 7 }">
								<c:set value="${item.ITEM_VALUE+countAll22}" var="countAll22" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAll2 + countAll22}" pattern="#,##0" /></td>
				</tr>
			</table>
		</div>
		<div style="width: 100%; border: 1px solid #DBDBD8;">
			<table class="user_table" style="border:hidden;" width="100%">
				<tr>
					<td class="td_type" width="10%" style="text-align: center;font-weight: bold;">F</td>
					<td class="td_type" width="65%" style="text-align: left;font-weight: bold;"><!--总扣除--><spring:message code="pa.payStub.DEDUCT_TOTAL" /></td>
					<td class="td_type" style="text-align: right;font-weight: bold;"><c:set value="${0}" var="countAll3" /> <c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 3 || item.ITEM_TYPE eq 7}">
								<c:set value="${item.ITEM_VALUE+countAll3}" var="countAll3" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAll3}" pattern="#,##0" /></td>
				</tr>
			</table>
			<table class="user_table" width="100%" style = "border:hidden; float: left">
				<c:set var="A" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 7 }">
                        <tr>
                            <td class="td_type" style="text-align: center;" width="10%"></td> 
                            <td class="td_type" style="text-align: left;" width="50.14%">${item.ITEM_NAME}</td>
                            <td class="td_type" style="text-align: right;" width="14.86%">${item.ITEM_PARAM}</td>
                            <td class="td_type" style="text-align: right;" width="25%"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
                        </tr>
                    </c:if>
				</c:forEach>
			</table>
		</div>
		<div
			style="width: 100%; height: ${maxHeightData*22+50}px; border: 1px solid #DBDBD8"><!-- 社会保险 -->
			<table class="user_table" width="100%" ">
				<c:set var="C" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 3}">
						<tr><td class="td_type" style="text-align: center;" width="10%"></td>
						<td class="td_type" style="text-align: left;" width="65%">
							<c:forEach items="${insuranceRateList}" var="rate" varStatus="j">
								<c:choose>
								    <c:when test="${item.ITEM_NO eq '570057' and rate.PARAM_ITEM_NO eq '540065'}">
								        ${item.ITEM_NAME} ${rate.ITEM_VALUE}
								    </c:when>
								    <c:when test="${item.ITEM_NO eq '570058' and rate.PARAM_ITEM_NO eq '540066'}">
								        ${item.ITEM_NAME} ${rate.ITEM_VALUE}
								    </c:when>
								    <c:when test="${item.ITEM_NO eq '570059' and rate.PARAM_ITEM_NO eq '540067'}">
								        ${item.ITEM_NAME} ${rate.ITEM_VALUE}
								    </c:when>
								    <c:when test="${item.ITEM_NO eq '570061' and rate.PARAM_ITEM_NO eq '540068'}">
								        ${item.ITEM_NAME} ${rate.ITEM_VALUE}
								    </c:when>
								    <c:when test="${item.ITEM_NO eq '570062' and rate.PARAM_ITEM_NO eq '540069'}">
								        ${item.ITEM_NAME} ${rate.ITEM_VALUE}
								    </c:when>
								    <c:when test="${item.ITEM_NO eq '570063' and rate.PARAM_ITEM_NO eq '540070'}">
								        ${item.ITEM_NAME} ${rate.ITEM_VALUE}
								    </c:when>
								    <c:when test="${j.last and item.ITEM_NO ne '570057' and item.ITEM_NO ne '570058' and item.ITEM_NO ne '570059' and item.ITEM_NO ne '570061' and item.ITEM_NO ne '570062' and item.ITEM_NO ne '570063'}">
								        ${item.ITEM_NAME}
								    </c:when>
								</c:choose>
						    </c:forEach>
						    </td>
							<td class="td_type" style="text-align: right;" width="25%"><fmt:formatNumber
									value="${item.ITEM_VALUE}" pattern="#,##0" /></td>

						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
		<div style="width: 100%; float: left; position: relative; top: 35px;">
		<table class="user_table" style="position: relative; bottom: 5px;" width="100%">
				<c:set var="A" value="${0}" />
				<c:forEach items="${payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_NO eq 540016 || item.ITEM_NO eq 540015 }">
						<tr>
							<td class="td_type" style="text-align: center;font-weight: bold;" width="10%">G</td>
							<td class="td_type" style="text-align: left;font-weight: bold;" width="50%">${item.REMARK}</td>
							<td class="td_type" style="text-align: right;" width="15%"></td>
							<td class="td_type" style="text-align: right;font-weight: bold;" width="25%"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<table class="user_table"
				style="position: relative; bottom: 5px; height: 30px" width="100%">
				<tr>
					<td class="td_type" style="text-align: center;font-weight: bold;" width="10%">H</td>
					<td style="text-align: center;" width="65%"><!--实际支付额 -->
					<c:if test="${PAY_SCHEDULE_NO eq '137'}"><spring:message code="ess.empInfo.actual_payment_amount" /> (E - F (Không bao gồm Lương nghỉ phép năm))</c:if>
					<c:if test="${PAY_SCHEDULE_NO ne '137'}"><spring:message code="ess.empInfo.actual_payment_amount" /> (E - F )</c:if>
					</td>
					<td style="text-align: right" width="25%"><fmt:formatNumber
							value="${personInfo.REAL_WAGES}" pattern="#,##0" /> &nbsp;</td>
				</tr>
			</table>
		</div>
		<div style="width: 100%; float: left; top: 30px;margin-top:40px;">
		
		<h2 class="thisPageStyle_pa0131"
				style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat">
				&nbsp;&nbsp;<!--其他福利--><spring:message code="pa.paSummary.P_CONDOLENCES.b" /></h2>
			<table class="user_table" width="100%" style=" bottom: 10px;">
				<tr>
					<td class="td_title" style="text-align: center;" width="50%">
						<!--备注--><spring:message code="hrm.empinfo.REMARK" /></td>
					<td class="td_title" style="text-align: center;" width="50%">
						<!--金额--><spring:message code="ess.empInfo.amount_of_money" /></td>
				</tr>
				<tr>
				<c:forEach items="${payStubList}" var="item">
						
							<c:if test="${item.ITEM_NO eq 540012}">
							<td class="td_type" style="text-align: center;"> Lương nghỉ phép năm (${item.ITEM_VALUE} Ngày)</td>
							</c:if>
							<c:if test="${item.ITEM_NO eq 570039}">
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
							</c:if>
				</c:forEach>
				</tr>
				<c:forEach items="${paInputItemList}" var="item">
						<tr>
							<td class="td_type" style="text-align: center;">${item.REMARK}</td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.RETURN_VALUE}" pattern="#,##0" /></td>
						</tr>
				</c:forEach>
			</table>
		</div>
		</c:if>
		<!-- <div style="position:absolute;left:0px;bottom:2px;"><span style="font-size:14px">※ Mọi thắc mắc liên quan đến nội dung trên phiếu lương, vui lòng liên hệ phòng Nhân sự trước ngày 25 hàng tháng!</span></div> -->
		</div>
</c:if>