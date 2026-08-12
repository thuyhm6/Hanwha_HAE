<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
function submitAffirmPro(flag){
	var isHtml = $("#isHtml_leave").val();
	$("#AFFIRM_FLAG",$.pdialog.getCurrent()).val(flag);
  	var $form = $("#viewApprovaledLeave_form");
alertMsg.confirm("<spring:message code='hrm.alert.empinfo.Perform_operation'/>",
	  	{okCall:function(){
		  	$.ajax({
		  		type: 'POST',
		  		url:$form.attr("action"),
		  		data:$form.serializeArray(),
		  		dataType:"json",
		  		cache: false,
		  		success: function(){
		  			if(isHtml == 'main'){
		  				$.pdialog.closeCurrent();
		  			}else{
		  				$.pdialog.closeCurrent();
		  				navTabSearch($("#viewApprovaledLeave_form"));
		  			}
		  		} ,
		  		error: DWZ.ajaxError
		  	});
		}});
	}
</script>
<c:if test="${empty currentAffirmor}">
	<div class="formBar">

		<ul>
			<c:if test="${leaveApplyInfo.AFFIRM_FLAG eq '14014308'}">
			<li>
				<div class="button">
					<div class="buttonContent">
						<button type="button" onclick="printDialog()">
							<!--打印--><spring:message code="ess.infoApply.print" />
						</button>
					</div>
				</div>
			</li></c:if>
			<li>
				<div class="button">
					<div class="buttonContent">
						<button type="button" class="close">
							<!--关闭--><spring:message code="ess.infoApply.close" />
						</button>
					</div>
				</div>
			</li>
		</ul>
	</div>
</c:if>
<div class="pageContent" sysLong='printDiv' layoutH="50" style="text-align:left;">
	<div style="font:bold 14px/20px arial,sans-serif;text-align:center;width:100%;padding-top:20px;padding-bottom:20px;">${viewAffirmList[0].TITLE}</div>
	<form id="viewApprovaledLeave_form" method="post" action="/ess/infoApply/executeAffirm" class="pageForm required-validate">
		<div style="padding-left:20px;padding-right:20px;">
						<table class="user_table" width="100%" border="0">
							<tr>
								<td class="td_title" style="text-align:right;width:20%;"><!--标题 --><spring:message code="ess.title.Title" /></td>
								<td class="td_type" style="text-align:left;width:80%;">${viewAffirmList[0].TITLE}</td>
							</tr>
							<tr>
								<td class="td_title" style="text-align:right;width:20%;"><!--申请者 --><spring:message code="ess.viewApply.title.applyName" /></td>
								<td class="td_type" style="text-align:left;width:80%;">${viewAffirmList[0].APPLY_PERSON_INFO}</td>
							</tr>
						</table>
						<br></br>
						<table class="user_table"  width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="td_title" style="text-align: center;width:5%;">
									<!-- No. --><spring:message code="pa.salary.canShu.xianSHiShunXu" />
								</td>
								<td class="td_title" style="text-align: center;width:10%;">
									<!--区分--><spring:message code="display.emp.ben.or.benhs67" />
								</td>
								<td class="td_title" style="text-align: center;width:10%;">
									<!-- 决裁情况 --><spring:message code="hrm.contractInfo.APPROVAL_SITUATION" />
								</td>
								<td class="td_title" style="text-align: center;width:10%;">
									<!--姓名--><spring:message code="ess.infoApply.NAME" />
								</td>
								<td class="td_title" style="text-align: center;width:25%;">
									<!--批注--><spring:message code="ess.infoApply.comment" />
								</td>
								<td class="td_title" style="text-align: center;width:20%;">
									<!--决裁时间--><spring:message code="hrm.contractInfo.APPROVAL_TIME" />
								</td>
								<td class="td_title" style="text-align: center;width:20%;">
									<!--部门--><spring:message code="ess.infoApply.DEPT_NAME" />
								</td>
							</tr>
								<c:forEach items="${viewAffirmList}" var="affirmor" varStatus="i">			
									<tr>
										<td class="td_type" style="text-align: center">${i.count}</td>
										<td class="td_type" style="text-align: center">
										    <c:if test="${affirmor.AFFIRM_TYPE eq '1'}"><!--审核--><spring:message code="ess.viewAttendanceEx.SHENHE.b" /></c:if>
											<c:if test="${affirmor.AFFIRM_TYPE eq '2'}"><!--协议--><spring:message code="ess.viewAttendanceEx.XIEYI.b" /></c:if>
											<c:if test="${affirmor.AFFIRM_TYPE eq '3'}"><!--通告--><spring:message code="ess.viewAttendanceEx.TONGGAO.b" /></c:if>
											<c:if test="${affirmor.AFFIRM_TYPE eq '4'}"><!--企案--><spring:message code="ess.viewAttendanceEx.QIAN.b" /></c:if>
											</td>
										<td class="td_type" style="text-align: center">
										<c:choose>
											   <c:when test="${affirmor.AFFIRM_TYPE eq '3'}">  
	                                                   <!-- 已通告--><spring:message code="ess.viewAttendanceEx.YITONGGAO.b" />
											   </c:when>
											   <c:when test="${affirmor.AFFIRM_TYPE eq '4'}">  
											        <c:if test="${affirmor.AFFIRM_FLAG eq '2'}">
	                                                    <!-- 取消--><spring:message code="public.title.cancle" />
	                                                </c:if>
	                                                <c:if test="${affirmor.AFFIRM_FLAG ne '2'}">
	                                                    <!-- 提交--><spring:message code="public.title.submit" />
	                                                </c:if>  
											   </c:when>
											   <c:otherwise> 
											        <c:if test="${affirmor.AFFIRM_FLAG eq '0'}">
	                                                    <!--未审批--><spring:message code="ess.affirmApply.title.remark.weishenpi" />
	                                                </c:if>
	                                                <c:if test="${affirmor.AFFIRM_FLAG eq '1'}">
	                                                    <!-- 已通过--><spring:message code="ess.affirmApply.title.remark.yitongguo" />
	                                                </c:if>
	                                                <c:if test="${affirmor.AFFIRM_FLAG ne '1' && affirmor.AFFIRM_FLAG ne '0'}">
	                                                    <!--已否决--><spring:message code="ess.affirmApply.title.remark.yifoujue" />
	                                                </c:if>
											   </c:otherwise>
											</c:choose>
										</td>
										<td class="td_type" style="text-align: center">${affirmor.AFFIRM_NAME}</td>
										<td class="td_type" style="text-align: center">
											<c:if test="${currentAffirmor.SEQ eq affirmor.SEQ}">
												<input id="AFFIRM_FLAG" name="AFFIRM_FLAG" type="hidden" value="" />
												<input id="APPLY_NO" name="APPLY_NO" type="hidden" value="${affirmor.APPLY_NO }" />
												<input id="APPLY_FLAG" name="APPLY_FLAG" type="hidden" value="${affirmor.APPLY_FLAG }" />
												<input id="APPLY_TYPE" name="APPLY_TYPE" type="hidden" value="${affirmor.APPLY_TYPE }" />
												<input id="AFFIRM_LEVEL" name="AFFIRM_LEVEL" type="hidden" value="${affirmor.AFFIRM_LEVEL}" />
												<input id="AFFIRM_CONTENT" name="AFFIRM_CONTENT" type="text" value="" size="20"/>
											</c:if>
											<c:if test="${currentAffirmor.SEQ ne affirmor.SEQ}">
												${affirmor.AFFIRM_CONTENT}
											</c:if>
										</td>
										<td class="td_type" style="text-align: center">${affirmor.UPDATE_DATE}</td>
										<td class="td_type" style="text-align: center">${affirmor.DEPTNAME}</td>
									</tr>			
								</c:forEach>
						</table>
						<c:if test="${viewAffirmList[0].APPLY_TYPE eq '81006456'}">
							<table  class="user_table" width="100%">
								<tr>
									<td style="text-align:center;" width="10%" class="td_title"><!-- 申请用车日期 -->Subject/ Nội dung khóa đào tạo</td>
									<td style="text-align:center;" width="5%" class="td_title"><!-- 预计结束时间 -->Style/ loại hình đào tạo</td>
									<td style="text-align:center;" width="5%" class="td_title"><!-- 乘坐人数 -->Start date</td>
									<td style="text-align:center;" width="5%" class="td_title"><!-- 行程 -->End date</td>
									<td style="text-align:center;" width="5%" class="td_title"><!-- 备注 -->Duration/(Số ngày)</td>
								</tr>
								<c:forEach items="${trainingApply}" var="item" varStatus="i">
									<tr>
										<td style="text-align:center;" class="td_title" >${item.TRAINING_CONTENT}</td>
										<td style="text-align:center;" class="td_title">${item.TRAINING_TYPE_NAME}</td>
										<td style="text-align:center;" class="td_title">${item.START_DATE}</td>
										<td style="text-align:center;" class="td_title">${item.END_DATE}</td>
										<td style="text-align:center;" class="td_title">${item.TRAIN_FEE}</td>
									</tr>
								</c:forEach>
							</table>
						</c:if>
		</div>
		<c:if test="${not empty currentAffirmor}">
		<div class="formBar">
			<ul>
				<li>
					<div class="button">
						<div class="buttonContent"><!-- 通过 -->
							<button type="button" onclick="submitAffirmPro(1)">
								<!--通过--><spring:message code="ess.infoApply.adopt" />
							</button>
						</div>
					</div>
				</li>
				<li>
					<div class="button">
						<div class="buttonContent"><!-- 否决 -->
							<button type="button" onclick="submitAffirmPro(2)">
								<!--否决--><spring:message code="ess.infoApply.veto" />
							</button>
						</div>
					</div>
				</li>
				<li>
					<div class="button">
						<div class="buttonContent">
							<button type="button" class="close">
								<!--关闭--><spring:message code="ess.infoApply.close" />
							</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
		</c:if>
	</form>
	<br></br>
	
	<br></br>
</div> 
<input type="hidden" value="${isHtml}" id="isHtml_leave">
</div>