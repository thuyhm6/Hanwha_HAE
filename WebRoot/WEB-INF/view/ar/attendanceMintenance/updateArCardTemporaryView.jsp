<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<div class="pageContent">
	<form id="addarcardtemporaryinfoview" method="post" action="/ar/attendanceMintenance/updateArCardTemporaryInfo" class="pageForm required-validate" onsubmit="return validateCallback(this,dialogAjaxDoneWithForm);">
		
		<input type="hidden" id="RECORD_NO" name="RECORD_NO" value="${arCardTemporaryInfo.RECORD_NO}"/>
		<input type="hidden" id="PERSON_ID" name="PERSON_ID" value="${arCardTemporaryInfo.PERSON_ID}"/>
		
		<div class="pageFormContent nowrap" layoutH="56">
			
			<dl>
				<dt><!-- 工号 --><spring:message code="hr.viewPersonalInfo.title.EMPID"/></dt>
				<dd>
					${arCardTemporaryInfo.EMPID}
				</dd>
			</dl>
			<dl>
				<dt><!-- 姓名 --><spring:message code="public.title.name"/></dt>
				<dd>
					${arCardTemporaryInfo.LOCAL_NAME}
				</dd>
			</dl>
			<dl>
				<dt><!-- 工号 --><spring:message code="hrm.empinfo.ACCOUNT_NO.Z"/></dt>
				<dd>
				${arCardTemporaryInfo.CARD_NO}
					
				</dd>
			</dl>
			<dl>
				<dt><!-- 类型 --><spring:message code="ar.viewarcardrecord.title.leixing"/></dt>
				<dd>
					<select id="ACTIVITY" name="ACTIVITY">
						<option value="1" <c:if test="${arCardTemporaryInfo.ACTIVITY eq '1'}">selected</c:if>><spring:message code="empsubject.useY"/></option>
						<option value="0" <c:if test="${arCardTemporaryInfo.ACTIVITY eq '0'}">selected</c:if>><spring:message code="empsubject.useN"/></option>
					</select>
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
