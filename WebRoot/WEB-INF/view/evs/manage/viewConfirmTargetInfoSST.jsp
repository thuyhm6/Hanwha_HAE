<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script>
$(document).ready(function(){
	var total = 0;
	var evsTotal = 0;
	$('#viewRegPersonalTarget_table tr td:[sysLog="ITEM_SCORE"]',$.pdialog.getCurrent()).each(function(i, obj){
		total += parseFloat($(obj).html());
		evsTotal += parseInt($(obj).html()) * parseInt($(obj).parent().find('td:[sysLog="EVS_SCORE"]').html());
	});
	$("#objectTargetSum",$.pdialog.getCurrent()).html(total);
	$("#objectTargetSumScore", $.pdialog.getCurrent()).html((evsTotal / 100).toFixed(1));
	
	var opTotal = 0;
	var opEvsTotal = 0;
	$('#viewRegOperationalTarget_table tr td:[sysLog="OP_ITEM_SCORE"]',$.pdialog.getCurrent()).each(function(i, obj){
		if($(obj).html() != ''){
			opTotal += parseInt($(obj).html());
			opEvsTotal += parseInt($(obj).html()) * parseInt($(obj).parent().find('td:[sysLog="OP_EVS_SCORE"]').html());
		}
	});
	$("#operationalTargetSum",$.pdialog.getCurrent()).html(opTotal);
	$("#operationalTargetSumScore", $.pdialog.getCurrent()).html((opEvsTotal / 100).toFixed(1));
});

function modifyObjectActivity(flag){
	var msg = "<spring:message code='hrm.approve.RETURN'/>";//退回
	if(flag == 1){
		msg = "<spring:message code='evs.viewConfirmTargetInfoSST.CHENGREN.a'/>";//承认
	}                  //确定要                             																				吗？
	alertMsg.confirm("<spring:message code='ess.viewMonthDetailConfirmList.QUEDINGYAO.a'/>" + msg + "<spring:message code='ess.viewMonthDetailConfirmList.MAO.a'/>",
  		{okCall:function(){
		  	$.ajax({
  				type: 'POST',
  				url: '/evs/manage/modifyObjectActivity',
  				data:[{name:'FLAG',value:flag},{name:'EVS_OBJECT_SEQ',value:'${viewEvsObjectInfo.SEQ}'}],
  				dataType:"json",
  				cache: false,
  				success: function(json){
		  			DWZ.ajaxDone(json);
		  			$.pdialog.closeCurrent();
		  		},
  				error: DWZ.ajaxError
  		});
  	}});
}
</script>
<div class="pageContent" layoutH="5">
	<div style="padding-left:10px;padding-right:10px;padding-top:5px;">
	<%@ include file="/WEB-INF/view/evs/manage/viewPersonalInfoHead_evs.jsp"%>
		<div style="font:bold 14px/20px arial,sans-serif;float:left;height:20px;line-height:20px;"><spring:message code="evs.strategicObjective.a"/><!-- Mục tiêu chiến lược --></div>
		<table class="user_table" width="100%" id="viewRegPersonalTarget_table">	
			<tr>
				<td class="td_title"  style="text-align:center;" width="5%">No</td>
				
				<td class="td_title"  style="text-align:center;" width="25%"><spring:message code="inct.salesman.evaluationItemType"/><!--评价项目--></td>
				
				<td class="td_title" style="text-align:center;" width="35%"><spring:message code="inct.salesman.eval.personal.target"/><!--目标--></td>
				<td class="td_title" style="text-align:center;" width="35%"><spring:message code="evs.affirm.comment.e"/><!--Comment--></td>
				<td class="td_title" style="text-align:center;" width="10%"><spring:message code="evs.viewConfirmTargetInfoAbility.CEZHONGZHI.a"/><!--侧重值--></td>
				<td class="td_title" style="text-align:center;" width="10%"><spring:message code="evs.viewEvsResult.BENREN.a"/> (%)<!--本人(%)--></td>
			</tr>
			<c:forEach items="${viewSSTEvsItem}" var="item" varStatus="i">
				<tr>
					<td class="td_type" style="text-align:center">${i.count}</td>
					
			    	<td class="td_type" style="text-align:left;">${item.ITEM_NAME }</td>
			    	<td class="td_type" style="text-align:left;">${item.ITEM_CONTENT }</td>
			    	<td class="td_type" style="text-align:left;">${item.ITEM_COMMENT }</td>
			    	<td class="td_type" style="text-align:right" sysLog="ITEM_SCORE">${item.ITEM_SCORE }</td>
			    	<td class="td_type" style="text-align:right" sysLog="EVS_SCORE">${item.EVS_SCORE }</td>
				</tr>
			</c:forEach>
			<tr>
				<td class="td_title"></td>
				
				<td class="td_title"></td>
				<td class="td_title"></td>
				<td class="td_title"></td>
				<td class="td_title" style="text-align:right;" id="objectTargetSum">0</td>
				<td class="td_title" style="text-align:right;" id="objectTargetSumScore" >${viewEvsObjectInfo.EVS_POINT0 }</td>
			</tr>
		</table>
		
		<div style="font:bold 14px/20px arial,sans-serif;float:left;height:20px;line-height:20px;"><spring:message code="evs.operationalObjective.a"/><!-- Mục tiêu vận hành --></div>
		<table class="user_table" width="100%" id="viewRegOperationalTarget_table">	
			<tr>
				<td class="td_title"  style="text-align:center;" width="5%">No</td>
				
				<td class="td_title"  style="text-align:center;" width="25%"><spring:message code="inct.salesman.evaluationItemType"/><!--评价项目--></td>
				
				<td class="td_title" style="text-align:center;" width="35%"><spring:message code="inct.salesman.eval.personal.target"/><!--目标--></td>
				<td class="td_title" style="text-align:center;" width="35%"><spring:message code="evs.affirm.comment.e"/><!--Comment--></td>
				<td class="td_title" style="text-align:center;" width="10%"><spring:message code="evs.viewConfirmTargetInfoAbility.CEZHONGZHI.a"/><!--侧重值--></td>
				<td class="td_title" style="text-align:center;" width="10%"><spring:message code="evs.viewEvsResult.BENREN.a"/> (%)<!--本人(%)--></td>
			</tr>
			<c:forEach items="${viewOpEvsItem}" var="item" varStatus="i">
				<tr>
					<td class="td_type" style="text-align:center">${i.count}</td>
					
			    	<td class="td_type" style="text-align:left;">${item.ITEM_NAME }</td>
			    	<td class="td_type" style="text-align:left;">${item.ITEM_CONTENT }</td>
			    	<td class="td_type" style="text-align:left;">${item.ITEM_COMMENT }</td>
			    	<td class="td_type" style="text-align:right" sysLog="OP_ITEM_SCORE">${item.ITEM_SCORE }</td>
			    	<td class="td_type" style="text-align:right" sysLog="OP_EVS_SCORE">${item.EVS_SCORE }</td>
				</tr>
			</c:forEach>
			<tr>
				<td class="td_title"></td>
				
				<td class="td_title"></td>
				<td class="td_title"></td>
				<td class="td_title"></td>
				<td class="td_title" style="text-align:right;" id="operationalTargetSum">0</td>
				<td class="td_title" style="text-align:right;" id="operationalTargetSumScore">${viewEvsObjectInfo.EVS_POINT0 }</td>
			</tr>
		</table>
		
		<br/>
		<table class="user_table" width="100%">
			<tr>
				<td class="td_title"  style="text-align:center;" width="80%"><spring:message code="evs.viewConfirmTargetInfoSST.BENRENYIJIAN.a"/><!--本人意见--></td>
				<td class="td_title"  style="text-align:center;" width="10%"><spring:message code="hr.viewCompetence.title.MARK"/><!--分数--></td>
				<c:if test="${ACTIVITY eq '14015358'}">
				<td class="td_title"  style="text-align:center;" width="10%"><spring:message code="sys.affirm.title.affirmLevel"/><!--等级--></td>
				</c:if>
			</tr>
			<tr>
				<td class="td_type">
					${viewEvsObjectInfo.AFFIRM_CONTENT0 }
				</td>
				<td class="td_type" style="text-align:center;">
					${viewEvsObjectInfo.EVS_POINT0 }
				</td>
				<c:if test="${ACTIVITY eq '14015358'}">
				<td class="td_type"  style="text-align:center;">
					<%-- ${viewEvsObjectInfo.EVS_GRADE0} --%>
					<c:choose>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE0 == 'A'}">EX</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE0 == 'B'}">VG</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE0 == 'C'}">GD</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE0 == 'D'}">NI</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE0 == 'E'}">UN</c:when>
					</c:choose>
				</td>
				</c:if>
			</tr>
		</table>
		
		
		<br/>
		<table class="user_table" width="100%">
			<tr>
				<td class="td_title"  style="text-align:center;" width="80%"><spring:message code="evs.viewConfirmTargetInfoSST.YICIKAOHEYIJIAN.a"/><!--1次考核意见--></td>
				<td class="td_title"  style="text-align:center;" width="10%"><spring:message code="hr.viewCompetence.title.MARK"/><!--分数--></td>
				<c:if test="${ACTIVITY eq '14015358'}">
				<td class="td_title"  style="text-align:center;" width="10%"><spring:message code="sys.affirm.title.affirmLevel"/><!--等级--></td>
				</c:if>
			</tr>
			<tr>
				<td class="td_type">${viewEvsObjectInfo.AFFIRM_CONTENT1 }</td>
				<td class="td_type" style="text-align:center;">${viewEvsObjectInfo.EVS_POINT1 }</td>
				<td class="td_type"  <c:if test="${ACTIVITY eq '14015357'}">style="display: none;"</c:if>>
				<%-- ${viewEvsObjectInfo.EVS_GRADE1} --%>
				<c:choose>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE1 == 'A'}">EX</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE1 == 'B'}">VG</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE1 == 'C'}">GD</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE1 == 'D'}">NI</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE1 == 'E'}">UN</c:when>
					</c:choose>
				</td>
			</tr>
		</table>
		
		<c:if test="${not empty viewEvsObjectInfo.EVS_GRADE2}">
		<c:if test="${ACTIVITY eq '14015358'}">
		<br/>
		<table class="user_table" width="100%">
			<tr>
				<td class="td_title"  style="text-align:center;" width="80%"><spring:message code="evs.viewConfirmTargetInfoSST.ERCIKAOHEYIJIAN.a"/><!--2次考核意见--></td>
				<td class="td_title"  style="text-align:center;" width="10%"><spring:message code="hr.viewCompetence.title.MARK"/><!--分数--></td>
				<td class="td_title"  style="text-align:center;" width="10%"><spring:message code="sys.affirm.title.affirmLevel"/><!--等级--></td>
			</tr>
			<tr>
				<td class="td_type">${viewEvsObjectInfo.AFFIRM_CONTENT2 }</td>
				<td class="td_type" style="text-align:center;">${viewEvsObjectInfo.EVS_POINT2 }</td>
				<td class="td_type"  style="text-align:center;">
				<%-- ${viewEvsObjectInfo.EVS_GRADE2} --%>
				<c:choose>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE2 == 'A'}">EX</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE2 == 'B'}">VG</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE2 == 'C'}">GD</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE2 == 'D'}">NI</c:when>
						<c:when test="${viewEvsObjectInfo.EVS_GRADE2 == 'E'}">UN</c:when>
					</c:choose>
				</td>
			</tr>
		</table>
		</c:if>
		</c:if>
	</div>
	<div class="formBar">
			<ul>
				<li>
					<div class="button">
						<div class="buttonContent">
							<button type="button" class="close">
								<spring:message code="ess.title.close"/><!--关闭-->
							</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
</div>
