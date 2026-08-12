<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript">

   //删除数据，可进行批量的删除或者单一的删除

</script>
<div class="pageContent">
	<form id="addSendSMS" name="addSendSMS" method="post" action="/sys/notice/addSendSMSInfo" 
			class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent nowrap" layoutH="56">
			<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="user_table margin_b">
				<tr>
					<td class="td_title"><spring:message code="liang.hr.viewPersonalInfo.title.PHONE_NUMBER"/><!-- 手机号码 --></br>
						</td>
					<td class="td_type"><input type="text" id="PHONE_NUMBER" name="PHONE_NUMBER" value=""  class="required" size="50"/>
					</td>
				</tr>
				<tr>
					<td class="td_title" style="width:122px"><spring:message code="ess.title.notecontent"/><!-- 公告内容 --></td>
					<td class="td_type">
						<textarea style="width:400px;height:200px" name="MESSAGE"
						 class="editor" tools="Cut,Copy,Paste,|,Fullscreen"></textarea>
					</td>
				</tr>
				<tr>
					<td class="td_title" style="width:122px"><spring:message code="ess.title.faburiqi"/><!-- 发布日期 --></td>
					<td class="td_type">
			            <input type="text" name="FROM_DATE" id="FROM_DATE" value="" class="Wdate" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy HH:mm:ss',lang:'en'})" />
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><!-- 提交 --><spring:message code="public.title.submit"/></button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close"><!-- 取消 --><spring:message code="public.title.cancle"/></button></div></div></li>
			</ul>
		</div>
	</form>
</div>
