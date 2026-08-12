<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script>

    function f_delShiftInfo(obj){
    	$("#"+obj+"").remove();
    }
    
    
      function delectApplyInfo(){
    	    // 确定提交删除申请吗？
    	   if(window.confirm('<spring:message code="ess.empInfo.sure_submit_application_deletion" />')){
    		   $("input[name=APPLY_TYPE]").val("3");
    	 /* $("#viewEmergencyAddressInfo").submit(); */
    	 	
    	}
    }
     
       function validateCallInfo(form, callback) {
	
		var $form = $("#deleteEmergencyAddressInfo");
		
		if (!$form.valid()) {
			return false;
		}
		
		$.ajax({
			type: form.method || 'POST',
			url:$form.attr("action"),
			data:$form.serializeArray(),
			dataType:"json",
			cache: false,
			success: callback || DWZ.ajaxDone,
			error: DWZ.ajaxError
		});
		
		return false;
	}
    
    function validateCallbackViewFamilyInfo(form, callback) {
	
		var $form = $("#viewEmergencyAddressInfo");
		
		if (!$form.valid()) {
			return false;
		}

		$.ajax({
			type: form.method || 'POST',
			url:$form.attr("action"),
			data:$form.serializeArray(),
			dataType:"json",
			cache: false,
			success: callback || DWZ.ajaxDone,
			error: DWZ.ajaxError
		});
		
		return false;
	}
 
	
    
</script>

<!-- <div class="pageContent"> -->
<div style="background-color: #fff;">
	<!-- 紧急联系地址   hr_emergency_address  没有更换名字 -->

	<form id="viewEmergencyAddressInfo" method="post" action="/ess/empinfo/addEmergencyAddressInfo" class="pageForm required-validate"
		onsubmit="return validateCallbackViewFamilyInfo(this, dialogAjaxDone);">
	
		<div class="pageFormContent" layoutH="56">
			<c:forEach items="${EmergencyAddressList}" var="item">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="user_table margin_b">
			<input type="hidden" name="UPDATE_EMERGENCY_NO" value='${item.EMERGENCY_NO}'/>
			<input type="hidden" name="APPLY_TYPE" value='${2}'/>
				
				<tr>
					<td width="15%" class="td_title" >
						<spring:message code="inct.salesman.classify"/><!-- 信息区分 -->
					</td>
					<td width="35%" class="td_type" colspan='3'>
						<ait:SelectSyCodeByCpnyID name="INFOR_DIS_CODE" id="INFOR_DIS_CODE" parentNo="14014361"
							cnpyID="${defaultCpny}" selected="${personInfo.INFOR_DIS_CODE}" limit="all" />
	                </td>
				</tr>
				<tr>
					<td width="15%" class="td_title" >
						<spring:message code="ar.viewcycle.title.kaishiri"/><!-- 开始日期 --></th>
					</td>
	                <td class="td_type"  width="25%" >
						<input name="START_DATE"  id="START_DATE" type="text" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${personInfo.START_DATE}" />
					</td>
	                <td width="15%" class="td_title" >
						<spring:message code="ar.viewcycle.title.jieshuri"/><!-- 结束日期 -->
					</td>
	                <td class="td_type"  width="25%" >
						<input name="END_DATE"  id="END_DATE" type="text" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${personInfo.END_DATE}" />
					</td>
			   </tr>
				<tr>
					<td width="15%" class="td_title">
						<spring:message code="hrm.contract.content"/><!-- 内容 -->
					</td>
					<td width="35%" class="td_type" colspan="3">
						<textarea name="SPECIAL_CONTENT"  id="SPECIAL_CONTENT" style="width:500px;height:80px">${personInfo.SPECIAL_CONTENT}</textarea>
					</td>
				</tr>

			</table>
			
			</c:forEach>


			<div id="createTable" width="100%"></div>

			<input type="hidden" name="count" id="count" value="1">
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="submit">
								<%-- <spring:message code="public.title.submit" /> --%>
								<!-- 保存 -->
								<!--修改--><spring:message code="ess.empInfo.modify" />
								</button>
						</div>
					</div>
				</li>
				<li>
				<div class="buttonActive">
					<div class="buttonContent">
						<%-- <a type="button" class="close" onclick="javascript:delectApplyInfo()" >
							<span><spring:message code="public.title.delete"/></span></a> --%>
							<a  onclick="javascript:delectApplyInfo()">
								<button><spring:message code="public.title.delete"/></button>
								<!-- 删除 -->
							</a>
					</div>
				</div>
			</li>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="button" class="close">
								<spring:message code="public.title.cancle" />
								<!-- 取消 -->
							</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</form>
<!-- </div> --></div>
