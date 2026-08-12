<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">

function magnifier_payStub(flag) {

	var name = encodeURI(encodeURI($("#seach_KEY", navTab.getCurrentPanel())
			.val()));
	var scheduleNo = $('#PAY_SCHEDULE_NO', navTab.getCurrentPanel())
			.val();
	var refreshUrl = '/pa/workManagement/payStub?PAY_SCHEDULE_NO=' + scheduleNo;
	var refreshMenuCode = 'pa0131';
	//工资条
	var refreshMenuName = encodeURI(encodeURI('<spring:message code="pa.viewPaMain.GONGZITIAO.C" />'));
	//$('#searchPop',navTab.getCurrent())
	$("#magnifiers_payStub", navTab.getCurrentPanel())
			.attr(
					'href',
					'/pa/workManagement/viewEmpForPopList?pageNum=1&numPerPage=10&limit=all&seach_KEY='
							+ name
							+ '&refreshUrl='
							+ refreshUrl
							+ '&refreshMenuCode='
							+ refreshMenuCode
							+ '&refreshMenuName=' + refreshMenuName);
	if (flag == 'onkeyup')
		$("#magnifiers_payStub", navTab.getCurrentPanel()).click();
}

function sendPayStubEmail(form,callback){
	var $form=null;
	if($('#'+form).length>0){
		$form=$('#'+form);}
	else{
 		$form = $(form);
 	}
	if (!$form.valid()) {
		return false;
	}

    $form.attr("action","/pa/workManagement/sendPayStubEmail");

    alertMsg.confirm ('<spring:message code="pa.payStub.CONFIRM_SEND_EMAIL.b" />',{ //确定发送工资单吗？
        okCall:function(){
	    	$.ajax({
				type: form.method || 'POST',
				url:$form.attr("action"),
				data:$form.serializeArray(),
				dataType:"json",
				cache: false,
				success: function(data) {
							if(data.statusCode == "200"){
								alertMsg.correct(data.message);
								$form.attr("action","/pa/workManagement/payStub");
								return false;
							}else if(data.statusCode == "201"){
								alertMsg.warn(data.message);
								$form.attr("action","/pa/workManagement/payStub");
								return false;
							}else if(data.statusCode == "300"){
								alertMsg.error(data.message);
								$form.attr("action","/pa/workManagement/payStub");
								return false;
							}
						 },	
				error: DWZ.ajaxError
			});
         }});
	return false;
}

function printData() {

	$("#viewPaMonthPersonInfoEssList_pageContent").jqprint( {
		debug : false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
		importCSS : true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
		printContainer : true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
		operaSupport : true
	//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
	});

}

</script>
<div class="pageContent">
	<form class="j-ajax" onsubmit="return  navTabSearch(this)"
		action="/pa/workManagement/payStub" method="post"
		id="payStubSearchForm" name="payStub">
		<div class="searchBar">
			<table class="searchContent">
				<input type="hidden" id="currentIndex" name="currentIndex" />
				<tr>
					<td>
						<!-- 工号/姓名： --> <spring:message
							code="hr.viewContractByInsert.title.EMPIDANDLOCALNAME" />
					</td>
					<td><input type="text" name="seach_KEY" id="seach_KEY"
						value="${KEY}"
						onkeydown="javascript:if(event.keyCode == 13)magnifier_payStub('onkeyup');" />

						<input type="hidden" id='dwz.person.personid' name="PERSON_ID" value="${PERSON_ID}"></td>
					<td class="td_type"><a class="btnLook" id="magnifiers_payStub"
						onclick="magnifier_payStub()" href="" lookupGroup="person"> </a> 
						<!--<span style="margin-left: 50px;" id="title_payStub">${empInfoShow}</span>-->
					</td>
					<td><!--部门--><spring:message code="public.title.deptName" /></td>
					<td>
					 	<ait:deptTreeMulti id="seach_DEPTNO_Multi" name="seach_DEPT_NAME" limit="pa" level2="" selectedNm="${DEPT_NAME}" selected="${DEPTNO_Multi}"></ait:deptTreeMulti>
					</td>
					<td><!--支付计划--><spring:message code="ess.empInfo.pay_plan" /></td>
					<td>
					<select id="PAY_SCHEDULE_NO" name="PAY_SCHEDULE_NO">
							<c:forEach items="${paPayScheduleList}" var="paySchedule" varStatus="i">
								<c:choose>
									<c:when test="${PAY_SCHEDULE_NO == paySchedule.PAY_SCHEDULE_NO }">
										<option value="${paySchedule.PAY_SCHEDULE_NO }" selected="selected">${paySchedule.PAY_DATE } ${paySchedule.SALARY_DISTIN }</option>
									</c:when>
									<c:otherwise>
										<option value="${paySchedule.PAY_SCHEDULE_NO }" >${paySchedule.PAY_DATE } ${paySchedule.SALARY_DISTIN }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent" align="center">
								<button type="submit"
									onkeydown="javascript:if(event.keyCode == 13)return false;">
									<spring:message code="public.title.search" />
								</button>
							</div>
						</div>
					</li>
					
					<li>
						<div class="buttonActive">
							<div class="buttonContent" align="center">
								<button type="button" onclick="printData()">
									<!--印刷--><spring:message code="hrm.approve.PRINTING" />
								</button>
							</div>
						</div>
					</li>
					
					<%-- <li>
						<div class="buttonActive">
							<div class="buttonContent" align="center">
								<button type="button" onclick="sendPayStubEmail('payStubSearchForm',navTabAjaxDone)">
									<!--发送Email--><spring:message code="pa.payStub.SEND_EMAIL.b" />
								</button>
							</div>
						</div>
					</li> --%>
				</ul>
			</div>

		</div>
		</form>


	<div class="pageContent" id="viewPaMonthPersonInfoEssList_pageContent"
		sysLong='printDiv'
		style="width: 850px; padding-left: 10px; text-align: left;overflow: hidden;" >
		<c:if test="${empty payInfolist}">
			<div style="height: 1254px;">
			</div>
		</c:if>
		<c:forEach items="${payInfolist}" var="pay">
		<c:if test="${pay.personInfo.REAL_WAGES ne null }">
		<div style="height: 1254px;position:relative;">
		<table width="100%" style="height: 40px;">
			<tr >
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
					PHIẾU LƯƠNG<br></br>${pay.personInfo.PAY_DATE}</td>
				<td width="25%"></td>
			</tr>
		</table>
		<br />
		<h2 class="thisPageStyle_pa0131">
			<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
			I/&nbsp;&nbsp;<!--基本事项--><spring:message code="ess.empInfo.basic_matters" /></h2>
		<table class="user_table" width="100%">
			<tr>
				<td class="td_title" width="13%"><!--style="border: 1px; border-color: black !important;"-->
					<!--姓名--><spring:message code="org.title.LOCAL_NAME" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.LOCAL_NAME}</td>
				<td class="td_title" ><!--工号--><spring:message code="ess.infoApply.EMP_ID" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.EMPID}</td>
				<td class="td_title"><!--部门--><spring:message code="ess.infoApply.DEPT" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.DEPT_NAME}</td>
				<td class="td_title"><!--员工类型--><spring:message code="hrm.empinfo.EMP_TYPE_CODE_NAME" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.EMP_TYPE_NAME}</td>
			</tr>
			<tr>
				<td class="td_title"><!--职群--><spring:message code="hrm.empinfo.POST_FAMILY" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.POST_FAMILY_NAME}</td>
				<td class="td_title"><!--职级--><spring:message code="sys.postManage.title.postGrade" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.POST_GRADE_NAME}</td>
				<td class="td_title"><!--职责--><spring:message code="ess.trans.title.dutyName" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.POSITION_NAME}</td>
				<td class="td_title"><!--在职状态--><spring:message code="org.title.OFFICE_NAME" /></td>
				<td class="td_type" style="text-align: center;">${pay.personInfo.EMP_OFFICE_NAME}</td>
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
			<c:forEach items="${pay.payStubList}" var="item">
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
						<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
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
					<td class="td_title" width="30%" colspan="2" >Thưởng Tết (1)</td>
					<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 500001}">
						<td class="td_type" width="25%" style="text-align: right" >${item.ITEM_VALUE}</td>
						</c:if>
					</c:forEach>
					<c:if test="${PAY_SCHEDULE_NO eq '163' || PAY_SCHEDULE_NO eq '179'}">
						<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_NO eq 500002}">
							<td class="td_type" width="25%" style="text-align: right" >${item.ITEM_VALUE}</td>
							</c:if>
						</c:forEach>
					</c:if>
					<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570049}">
						<td class="td_type" width="20%" style="text-align: right" ><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0"/></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td class="td_title" width="70%" colspan="4">Thưởng Tết (2)</td>
					
					<td class="td_type" width="30%" style="text-align: right" width="25%" >500,000</td>
				</tr>
				<tr>
					<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570051}">
						<td class="td_title" width="20%"  colspan="4">${item.ITEM_NAME}  (3)</td>
						</c:if>
					</c:forEach>
					<!-- <td class="td_title" width="35%" colspan="2" ></td> -->
					<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570051}">
						<td class="td_type" width="20%" style="text-align: right" ><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0"/></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<td class="td_title" width="60%"  colspan="4" style="text-align: center;font-weight: bold;" >Thưởng Tết thực lĩnh (1 + 2 - 3)</td>
					<%-- <c:if test="${PAY_SCHEDULE_NO eq '163' || PAY_SCHEDULE_NO eq '179'}">
						<td class="td_type" width="15%" style="text-align: right" ></td>
					</c:if> --%>
					<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 570054}">
						<td class="td_type" width="25%" style="text-align: right;font-weight: bold;" width="25%"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0"/></td>
						</c:if>
					</c:forEach>
				</tr>
			</table>
			
		</c:if>
		<c:if test="${PAY_SCHEDULE_NO ne '136' && PAY_SCHEDULE_NO ne '151' && PAY_SCHEDULE_NO ne '163' && PAY_SCHEDULE_NO ne '179'}">
		<c:if test="${LoginUser.cpnyId eq 'HAE'}">
			<br>
			<h2 class="thisPageStyle_pa0131">
				<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat"> -->
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
				<c:forEach items="${pay.paEmpVacInfo}" var="item">
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
			<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat"> -->
			III/&nbsp;&nbsp;<!--帐号--><spring:message code="hr.viewAccount.title.CARD_NO" /></h2>
		<table class="user_table" width="100%">
			<%-- <tr>
				<td class="td_title" style="text-align: center;" width="13%">
					<!--银行--><spring:message code="ess.empInfo.bank" /></td>
				<td class="td_title" style="text-align: center;" width="13%">
					<!--账户号--><spring:message code="ess.empInfo.account_number" /></td>
			</tr> --%>
			<c:forEach items="${pay.paEmpAccount}" var="item">
				<tr>
					<td style="text-align: center;" class="td_type">
						${item.ACCOUNT_TYPE }</td>

					<td style="text-align: center;" class="td_type">
						${item.ACCOUNT_NO }</td>
				</tr>
			</c:forEach>
		</table>
		<br>
		<h2 class="thisPageStyle_pa0131">
			<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
			IV/&nbsp;&nbsp;<!--合同信息--><spring:message code="pa.payStub.CONTRACT_INFO" /></h2>
		<table class="user_table" width="100%">
			<tr>
				<td class="td_title" style="text-align: center;" width="13%">
					<!--项目--><spring:message code="ess.empInfo.project" /></td>
				<td class="td_title" style="text-align: center;" width="13%">
					<!--金额--><spring:message code="ess.empInfo.amount_of_money" /></td>
			</tr>
			<c:forEach items="${pay.payStubList}" var="item">
				<c:if test="${item.ITEM_TYPE eq 4}">
						<tr>
							<td class="td_type" style="text-align: center;">${item.ITEM_NAME}</td>
							<c:if test="${item.ITEM_NO eq 540000 && pay.personInfo.EMP_TYPE_CODE eq 10416}">
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE / 0.8}" pattern="#,##0" /></td>
							</c:if>
							<c:if test="${item.ITEM_NO eq 540000 && pay.personInfo.EMP_TYPE_CODE ne 10416}">
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
					<td class="td_type" style="text-align: center;font-weight: bold;" width="50%">
						<!--基本工资＋所有津贴--><spring:message code="pa.payStub.JIBENGONGZI_JIA_JINTIE.b" />
					</td>
					<td class="td_type" style="text-align: right;font-weight: bold;" width="50%"><c:set value="${0}" var="countAll4" />
						<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_TYPE eq 4}">
							<c:if test="${item.ITEM_NO eq 540000 && pay.personInfo.EMP_TYPE_CODE eq 10416}">
							<c:set value="${item.ITEM_VALUE / 0.8 +countAll4}" var="countAll4" />
							</c:if>
							<c:if test="${item.ITEM_NO eq 540000 && pay.personInfo.EMP_TYPE_CODE ne 10416}">
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
		<div style="width: 100%; ">
			<h2 class="thisPageStyle_pa0131">
				<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
				V/&nbsp;&nbsp; <!--出勤明细--><spring:message code="ess.empInfo.attendance_detail" /></h2>
		</div>
		<%-- <div style="width: 33%; float: left;">
			<h2 class="thisPageStyle_pa0131"
				style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat">
				&nbsp;&nbsp;<!--工资明细--><spring:message code="ess.empInfo.salary_detail" /></h2>
		</div>
		<div style="width: 100%; ">
			<h2 class="thisPageStyle_pa0131"
				style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat">
				&nbsp;&nbsp; <!--扣除明细--><spring:message code="ess.empInfo.deduction_detail" /></h2>
		</div> --%>
		<c:set var="dataSize" value="0"></c:set>
		<c:set var="maxHeightData" value="0"></c:set>
		<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
			<c:if test="${item.ITEM_TYPE eq 1 }">
				<c:set var="dataSize" value="${dataSize + 1 }"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="maxHeightData" value="${dataSize }">
		</c:set>
		<c:set var="dataSize" value="0"></c:set>
		<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
			<c:if test="${item.ITEM_TYPE eq 2 }">
				<c:set var="dataSize" value="${dataSize + 1 }"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="maxHeightData" value="${dataSize }">
        </c:set>
        <c:set var="dataSize" value="0"></c:set>
        <c:forEach items="${pay.payStubList}" var="item" varStatus="i">
            <c:if test="${item.ITEM_TYPE eq 5 }">
                <c:set var="dataSize" value="${dataSize + 1 }"></c:set>
            </c:if>
        </c:forEach>
        <c:if test="${dataSize > maxHeightData }">
            <c:set var="maxHeightData" value="${dataSize }"></c:set>
        </c:if>
		<c:set var="dataSize" value="0"></c:set>
		<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
			<c:if test="${item.ITEM_TYPE eq 3 }">
				<c:set var="dataSize" value="${dataSize + 1 }"></c:set>
			</c:if>
		</c:forEach>
		<c:set var="maxHeightData" value="${dataSize }">
        </c:set>
        <c:set var="dataSize" value="0"></c:set>
        <c:forEach items="${pay.payStubList}" var="item" varStatus="i">
            <c:if test="${item.ITEM_TYPE eq 7 }">
                <c:set var="dataSize" value="${dataSize + 1 }"></c:set>
            </c:if>
        </c:forEach>
		<c:if test="${dataSize > maxHeightData }">
			<c:set var="maxHeightData" value="${dataSize }"></c:set>
		</c:if>
		<div style="width: 100%;  height: ${maxHeightData*38+50}px; border: 1px solid #DBDBD8; left: 2px;"> <!-- 津贴明细 -->
			<table class="user_table" width="100%" style = "border-left:hidden; border-right:hidden;">
				<tr>
					<td class="td_type" width="60%" style="text-align: center;font-weight: bold;" colspan="2"><!--应出勤天数--><spring:message code="ess.infoApply.yingchuqintianshu" /></td>
						<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
						<c:if test="${item.ITEM_NO eq 500002}">
						<td class="td_type" width="15%" style="text-align: center" width="25%">${item.ITEM_VALUE} <spring:message code="ar.viewsummaryparameteritem.title.day" /></td>
						<td class="td_type" width="25%" style="text-align: center" width="25%">${item.ITEM_VALUE * 8} <spring:message code="ar.viewsummaryparameteritem.title.hour" /></td>
						</c:if>
						</c:forEach>
				</tr>
				<tr>
					<td class="td_title" width="60%" colspan="2" style="font-weight: bold;"><!--考勤项目--><spring:message code="ess.empInfo.attendance_item" /></td>
					<td class="td_title" width="15%" style="font-weight: bold;"><!--时数--><spring:message code="pa.payStub.HOURS" /></td>
					<td class="td_title" width="25%" style="font-weight: bold;"><!--钱--><spring:message code="pa.detailItemCountInfo.SHIJIQUFEN.b" /></td>
				</tr>
				<tr>
					<td class="td_type" style="text-align: center;font-weight: bold;"width="10%">A</td>
					<td class="td_type" style="text-align: left;font-weight: bold;"width="50%"><spring:message code="ess.title.HUIZONGGONGSHI" /></td>
					<td class="td_type" style="text-align: right;font-weight: bold;" width="15%">${pay.personInfo.PROBATION_DAYS*8 + pay.personInfo.REGULAR_DAYS*8}</td>
					<td class="td_type" style="text-align: right;font-weight: bold;" width="25%"><fmt:formatNumber value="${pay.personInfo.BASIC_SALARY}" pattern="#,##0" /></td>
				</tr>
			</table>
			<table class="user_table" width="75.16%" style = "border-left:hidden; float: left">
				<tr>
					<td class="td_type" width="13.34%" style="text-align: center;font-weight: bold;">B</td>
					<td class="td_type" width="66.66%" style="text-align: left;font-weight: bold;"><!--加班时数--><spring:message code="ess.infoApply.jiabanshishu" /></td>
					<td class="td_type" style="text-align: right;font-weight: bold;"width="19.8%"><c:set value="${0}" var="countAll9" /> <c:forEach
							items="${pay.payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 5 && (item.ITEM_NO eq 500005 || item.ITEM_NO eq 500006 || item.ITEM_NO eq 500007 || item.ITEM_NO eq 500008
							|| item.ITEM_NO eq 500009 || item.ITEM_NO eq 500010 || item.ITEM_NO eq 500011 || item.ITEM_NO eq 500012 || item.ITEM_NO eq 500013 
							|| item.ITEM_NO eq 500014 || item.ITEM_NO eq 500036 || item.ITEM_NO eq 500037 || item.ITEM_NO eq 500038 || item.ITEM_NO eq 500039 
							|| item.ITEM_NO eq 500015 || item.ITEM_NO eq 500016 || item.ITEM_NO eq 500017 || item.ITEM_NO eq 500018 || item.ITEM_NO eq 90000528
							|| item.ITEM_NO eq 90000530 || item.ITEM_NO eq 90000529)}">
								<c:set value="${item.ITEM_VALUE+countAll9}" var="countAll9" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAll9}"  /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
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
							items="${pay.payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 6}">
								<c:set value="${item.ITEM_VALUE+countAl20}" var="countAl20" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl20}" pattern="#,##0" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
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
							items="${pay.payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 1 && (item.ITEM_NO eq 500128 || item.ITEM_NO eq 500129)}">
								<c:set value="${item.ITEM_VALUE+countAl21}" var="countAl21" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl21}" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
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
							items="${pay.payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 2 && (item.ITEM_NO eq 570101 || item.ITEM_NO eq 570102)}">
								<c:set value="${item.ITEM_VALUE+countAl22}" var="countAl22" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl22}" pattern="#,##0" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
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
							items="${pay.payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 2 && (item.ITEM_NO eq 570001 || item.ITEM_NO eq 570003 || item.ITEM_NO eq 90000477 || item.ITEM_NO eq 90000484
							|| item.ITEM_NO eq 570005 || item.ITEM_NO eq 570096 || item.ITEM_NO eq 570008 || item.ITEM_NO eq 540094 || item.ITEM_NO eq 90000516 
							|| item.ITEM_NO eq 570097 || item.ITEM_NO eq 570095 || item.ITEM_NO eq 570100 || item.ITEM_NO eq 570040 || item.ITEM_NO eq 540014 
							|| item.ITEM_NO eq 90000539 || item.ITEM_NO eq 90000546 || item.ITEM_NO eq 90000552 || item.ITEM_NO eq 570004)}">
								<c:set value="${item.ITEM_VALUE+countAl23}" var="countAl23" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAl23}" pattern="#,##0" /></td>
				</tr>
				<c:set var="A" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 2 && (item.ITEM_NO eq 570001 || item.ITEM_NO eq 570003 || item.ITEM_NO eq 90000477 || item.ITEM_NO eq 90000484
							|| item.ITEM_NO eq 570005 || item.ITEM_NO eq 570096 || item.ITEM_NO eq 570008 || item.ITEM_NO eq 540094 || item.ITEM_NO eq 90000516
							|| item.ITEM_NO eq 570097 || item.ITEM_NO eq 570095 || item.ITEM_NO eq 570100 || item.ITEM_NO eq 570040 || item.ITEM_NO eq 540014
							|| item.ITEM_NO eq 90000539 || item.ITEM_NO eq 90000546|| item.ITEM_NO eq 90000552 || item.ITEM_NO eq 570004)}">
						<tr>
							<td class="td_type" style="text-align: center;"></td>
							<td class="td_type" style="text-align: left;">${item.ITEM_NAME}</td>
							<td class="td_type" style="text-align: right;"><c:if test="${item.ITEM_NO eq 570100 }">${pay.personInfo.WORMEN_HOURS/60}</c:if>
							<c:if test="${item.ITEM_NO eq 570004 }">${pay.personInfo.LONG_ATTENDANCE_MONTHS}</c:if></td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
		<%-- <div
			style="width: 33%; float: left; height:
						${maxHeightData*25+50}px; border: 1px solid #DBDBD8">
			扣除明细
						
			<table class="user_table" width="100%" style = "border-left:hidden; border-right:hidden;">
				<tr>
					<td class="td_title" width="60%"><!--项目--><spring:message code="ess.empInfo.project" /></td>
					<td class="td_title"><!--金额--><spring:message code="ess.empInfo.amount_of_money" /></td>
				</tr>
				<c:set var="B" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 2}">
						<tr>
							<td class="td_type" style="text-align: center;">${item.ITEM_NAME}</td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber
									value="${item.ITEM_VALUE}" pattern="#,##0" /></td>

						</tr>
					</c:if>

				</c:forEach>

			</table>

		</div> --%>
		<div style="width: 100%; border: 1px solid #DBDBD8;">
			<table class="user_table" style = "border:hidden;"  width="100%">
				<tr>
					<td class="td_type" width="10%" style="text-align: center;font-weight: bold;">E</td>
					<td class="td_type" width="65%" style="text-align: left;font-weight: bold;">
					<!--总工资--><spring:message code="hrm.approve.AMOUNT" /> A+B+C+D + <spring:message code="pa.paSummary.P_CONDOLENCES.b" /> + G <spring:message code="sys.basic.title.ifAny" /> </td>
					<td class="td_type" width="25%" style="text-align: right;font-weight: bold;">
					<c:set value="${0}" var="countAll2" /> <c:set value="${0}" var="countAll22" /> 
						<c:forEach items="${pay.payStubList}" var="item" varStatus="i"> 
							<%-- <c:if test="${item.ITEM_TYPE eq 2 and item.ITEM_NO ne 570036 and item.ITEM_NO ne 570049 and item.ITEM_NO ne 570050 and item.ITEM_NO ne 570054 and item.ITEM_NO ne 570039}"> --%>
							<c:if test="${item.ITEM_TYPE eq 2 and item.ITEM_NO eq 570049 }">
								<c:set value="${item.ITEM_VALUE+countAll2}" var="countAll2" />
							</c:if>
							<c:if test="${item.ITEM_TYPE eq 7}">
								<c:set value="${item.ITEM_VALUE+countAll22}" var="countAll22" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAll2 + countAll22}" pattern="#,##0" /></td>
				</tr>
			</table>
		</div>
		<div style="width: 100%; border: 1px solid #DBDBD8;">
			<table class="user_table" style = "border:hidden;" width="100%">
				<tr>
					<td class="td_type" width="10%" style="text-align: center;font-weight: bold;">F</td>
					<td class="td_type" width="65%" style="text-align: left;font-weight: bold;"><!--总扣除--><spring:message code="pa.payStub.DEDUCT_TOTAL" /></td>
					<td class="td_type" width="25%" style="text-align: right;font-weight: bold;"><c:set value="${0}" var="countAll3" /> <c:forEach
							items="${pay.payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 3 || item.ITEM_TYPE eq 7}">
								<c:set value="${item.ITEM_VALUE+countAll3}" var="countAll3" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAll3}" pattern="#,##0" /></td>
				</tr>
			</table>
			<table class="user_table" width="100%" style = "border:hidden; float: left">
                <c:set var="A" value="${0}" />
                <c:forEach items="${pay.payStubList}" var="item" varStatus="i">
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
			style="width: 100%; height: ${maxHeightData*18+50}px; border: 1px solid #DBDBD8"><!-- 社会保险 -->
			<table class="user_table" width="100%" >
				<c:set var="C" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_TYPE eq 3}">
						<tr><td class="td_type" style="text-align: center;" width="10%"></td>
						<td class="td_type" style="text-align: left;" width="65%">
							<c:forEach items="${pay.insuranceRateList}" var="rate" varStatus="j">
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

		<%-- <div style="width: 33%; float: left;">
			<table class="user_table" style="position: relative;" width="100%" height="100%">
				<tr>
					<td class="td_type" width="70%">&nbsp</td>
					<td class="td_type"><c:set value="${0}" var="countAll1" /> <c:forEach
							items="${payStubList}" var="item" varStatus="i">
							<c:if test="${item.ITEM_TYPE eq 1}">
								<c:set value="${item.ITEM_VALUE+countAll1}" var="countAll1" />
							</c:if>
						</c:forEach> <fmt:formatNumber value="${countAll1}" pattern="#,##0" /></td>
				</tr>
			</table>
		</div> --%>
		
		
		<div style="width: 100%; float: left; position: relative; top: 35px">
			<table class="user_table" style="position: relative; bottom: 5px;" width="100%">
				<c:set var="A" value="${0}" />
				<c:forEach items="${pay.payStubList}" var="item" varStatus="i">
					<c:if test="${item.ITEM_NO eq 540016 || item.ITEM_NO eq 540015 }">
						<tr>
							<td class="td_type" style="text-align: center;font-weight: bold;" width="10%">G</td>
							<td class="td_type" style="text-align: center;font-weight: bold;" width="50%">${item.REMARK}</td>
							<td class="td_type" style="text-align: right;" width="15%"></td>
							<td class="td_type" style="text-align: right;font-weight: bold;" width="25%"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<table class="user_table" style=";margin-top:20px; position: relative; bottom: 5px; height: 30px" width="100%">
				<tr>
				    <td class="td_type" style="text-align: center;font-weight: bold;" width="10%">H</td>
					<td style="text-align: center;font-weight: bold;" width="65%"><!--实际支付额-->
					<c:if test="${PAY_SCHEDULE_NO eq '137'}"><spring:message code="ess.empInfo.actual_payment_amount" /> (E - F (Không bao gồm Lương nghỉ phép năm))</c:if>
					<c:if test="${PAY_SCHEDULE_NO ne '137'}"><spring:message code="ess.empInfo.actual_payment_amount" /> (E - F)</c:if>
					</td>
					<td style="text-align: right;font-weight: bold;" width="25%"><fmt:formatNumber
							value="${pay.personInfo.REAL_WAGES}" pattern="#,##0" /> &nbsp;</td>
				</tr>
			</table>
		</div>
		<div style="width: 100%; float: left; top: 30px;margin-top:40px;">
		
		<h2 class="thisPageStyle_pa0131">
				<!-- style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat" -->
				VI/&nbsp;&nbsp;<!--其他福利--><spring:message code="pa.paSummary.P_CONDOLENCES.b" /></h2>
			<table class="user_table" width="100%" style=" bottom: 10px;">
				<tr>
					<td class="td_title" style="text-align: center;" width="50%">
						<!--备注--><spring:message code="hrm.empinfo.REMARK" /></td>
					<td class="td_title" style="text-align: center;" width="50%">
						<!--金额--><spring:message code="ess.empInfo.amount_of_money" /></td>
				</tr>
				<%-- <c:forEach items="${pay.payStubList}" var="item">
					<c:set var="vacPay"></c:set>
						<c:if test="${item.ITEM_NO eq 540012}">
						<c:set var="vacPay"  value="${item.ITEM_VALUE}" /></c:if>
						<c:if test="${item.ITEM_NO eq 570039}">
						<tr>
							<td class="td_type" style="text-align: center;">${item.ITEM_NAME} (<c:out value = "${vacPay}"/>)</td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
						</tr>
					</c:if>
				</c:forEach> --%>
				<tr>
				<c:forEach items="${pay.payStubList}" var="item">
						
							<c:if test="${item.ITEM_NO eq 540012}">
							<td class="td_type" style="text-align: center;"> Lương nghỉ phép năm (${item.ITEM_VALUE} Ngày)</td>
							</c:if>
							<c:if test="${item.ITEM_NO eq 570039}">
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.ITEM_VALUE}" pattern="#,##0" /></td>
							</c:if>
				</c:forEach>
				</tr>
				<c:forEach items="${pay.paInputItemList}" var="item">
						<tr>
							<td class="td_type" style="text-align: center;">${item.REMARK}</td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.RETURN_VALUE}" pattern="#,##0" /></td>
						</tr>
				</c:forEach>
			</table>
		</div>
		<%--<div
			style="position: relative; width: 100%; float: left; height: 30px; top: 15px">

			<h2 class="thisPageStyle_pa0131"
				style="background-image: url('/resources/css/dwzUI/themes/partner/images/li_prent.jpg'); background-repeat: no-repeat">
				&nbsp;&nbsp;其他福利<spring:message code="pa.paSummary.P_CONDOLENCES.b" /></h2>
			<table class="user_table" width="100%">
				<tr>
					<td class="td_title" style="text-align: center;" width="50%">
						备注<spring:message code="hrm.empinfo.REMARK" /></td>
					<td class="td_title" style="text-align: center;" width="50%">
						金额<spring:message code="ess.empInfo.amount_of_money" /></td>
				</tr>
				<c:forEach items="${paInputItemList}" var="item">
						<tr>
							<td class="td_title" style="text-align: center;">${item.REMARK}</td>
							<td class="td_type" style="text-align: right;"><fmt:formatNumber value="${item.RETURN_VALUE}" pattern="#,##0" /></td>
						</tr>
				</c:forEach>
			</table>
		</div>
		<div style="width: 100%; float: left;">
			<table class="user_table"
				style="position: relative; bottom: 2px; height: 50px" width="100%">
				<tr>
					<td><c:if test="${LoginUser.cpnyId eq 'HAE'}">
							<c:if
								test="${paSpecialItem.INSURANCE_BASE ne null and   paSpecialItem.INSURANCE_BASE ne '0'}">
							&nbsp;&nbsp;社保基数：${paSpecialItem.INSURANCE_BASE}元
						</c:if>
							<c:if
								test="${paSpecialItem.CPF_BASE ne null and paSpecialItem.CPF_BASE ne '0'}">
							&nbsp;&nbsp;住房基数：${paSpecialItem.CPF_BASE} 元
							</c:if>
							<c:if
								test="${paSpecialItem.P_OTHER_TAX ne '0' and  paSpecialItem.P_OTHER_TAX ne null}">
							&nbsp;&nbsp;其他计税：${paSpecialItem.P_OTHER_TAX}元
							</c:if>
							<c:if
								test="${paSpecialItem.P_OTHER_FREE_TAX ne null and paSpecialItem.P_OTHER_FREE_TAX ne '0' }">
							&nbsp;&nbsp;其他免税：${paSpecialItem.P_OTHER_FREE_TAX}元
							</c:if>
						</c:if></td>
				</tr>
			</table>
		</div>--%>
		<!-- <div style="position:absolute;left:0px;bottom:2px;"><span style="font-size:14px">※ Mọi thắc mắc liên quan đến nội dung trên phiếu lương, vui lòng liên hệ phòng Nhân sự trước ngày 25 hàng tháng!</span></div> -->
		</c:if>
		</div>
		</c:if>
		</c:forEach>
	</div>
</div>