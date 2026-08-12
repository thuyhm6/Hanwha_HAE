<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<div class="pageContent">
	<form method="post" action="/pa/workManagement/updatePaPayScheduleInfo" class="pageForm required-validate" onsubmit="return validateCallback(this,dialogAjaxDoneWithForm);">
		<div class="pageFormContent nowrap">
			
			<dl>
				<dt><!-- 支付日期 --> <spring:message code="display.pa.ecc.paydate" /></dt>
				<dd>
					<input id="PAY_DATE" type="text" name="PAY_DATE" class="Wdate required" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en'})" value="${paPayScheduleInfo.PAY_DATE }" readonly="true" />
					<input name="PAY_SCHEDULE_NO" type="hidden" value="${paPayScheduleInfo.PAY_SCHEDULE_NO }"/>
				</dd>
			</dl>
			<dl>
				<dt><!-- 工资区分 --> <spring:message code="pa.viewPaPaySchedule.GONGZIQUFEN.C" /></dt>
				<dd>
					<ait:SelectSyCodeByCpnyID name="SALARY_DISTIN_NO" parentNo="14013797"
							cnpyID="${LoginUser.cpnyId}"  selected="${paPayScheduleInfo.SALARY_DISTIN_NO }"/>
				</dd>
			</dl>
			<!-- 2018/11/02 HAE 要求发令开始日期(HR_START_DATE)=考勤取值开始日期(AR_START_DATE)，发令结束日期(HR_END_DATE)=考勤取值结束日期(AR_END_DATE) -->
			<%-- <dl>
				<dt><!--发令开始日期 --> <spring:message code="pa.viewPaPaySchedule.FALINGKAISHIRIQI.C" /></dt>
				<dd>
					<input id="HR_START_DATE" type="text" name="HR_START_DATE" class="Wdate required" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en'})"  readonly="true" value="${paPayScheduleInfo.HR_START_DATE }"/>
				</dd>
			</dl>
			<dl>
				<dt><!-- 发令结束日期 --> <spring:message code="pa.viewPaPaySchedule.FALINGJIESHURIQI.C" /></dt>
				<dd>
					<input id="HR_END_DATE" type="text" name="HR_END_DATE" class="Wdate required" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en'})" readonly="true" value="${paPayScheduleInfo.HR_END_DATE }"/>
				</dd>
			</dl> --%>
			<dl>
				<dt><!-- 考勤取值开始日期--> <spring:message code="pa.viewPaPaySchedule.KAIQINKAISHIRIQI.C" /></dt>
				<dd>
					<input id="AR_START_DATE" type="text" name="AR_START_DATE" class="Wdate required" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en'})" readonly="true" value="${paPayScheduleInfo.AR_START_DATE }"/>
				</dd>
			</dl>
			<dl>
				<dt><!--考勤取值结束日期--> <spring:message code="pa.viewPaPaySchedule.KAIQINJIESHURIQI.C" /></dt>
				<dd>
					<input id="AR_END_DATE" type="text" name="AR_END_DATE" class="Wdate required" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en'})" readonly="true" value="${paPayScheduleInfo.AR_END_DATE }"/>
				</dd>
			</dl>
			<dl>
				<dt><!-- 开放日期 --> <spring:message code="pa.viewPaPaySchedule.KAIFANGRIQI.C" /></dt>
				<dd>
					<input id="PA_OPEN_DATE" type="text" name="PA_OPEN_DATE"  class="Wdate required" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en'})" readonly="true" value="${paPayScheduleInfo.PA_OPEN_DATE }"/>
				</dd>
			</dl>
			<dl>
				<dt><!-- 传票日期--> <spring:message code="pa.viewPaPaySchedule.CHUANPIAORIQI.C" /></dt>
				<dd>
					<input id="PA_TRANS_DATE" type="text" name="PA_TRANS_DATE" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en'})" readonly="true" value="${paPayScheduleInfo.PA_TRANS_DATE }"/>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><!-- 提交 --><spring:message code="public.title.submit"/></button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close"><!-- 取消 --><spring:message code="public.title.cancle"/></button></div></div></li>
			</ul>
		</div>
	</form>
</div>
