<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<style type="text/css">
.feedbackContent { padding:15px 20px; line-height:1.8; font-size:13px; }
.feedbackContent h3 { color:#d0021b; font-size:15px; margin:0 0 15px 0; }
.feedbackContent h4 { color:#0072bc; font-size:13px; margin:15px 0 8px 0; }
.feedbackContent ul { margin:0 0 10px 20px; padding:0; }
.feedbackContent ul li { margin:6px 0; }
.feedbackContent p { margin:6px 0; }
.feedbackContent ol { margin:0 0 10px 20px; padding:0; }
.feedbackContact { width:100%; border-collapse:collapse; margin-top:10px; }
.feedbackContact th, .feedbackContact td { border:1px solid #ddd; padding:6px 10px; text-align:left; }
.feedbackContact th { background:#f2941e; color:#fff; }
.feedbackForm { width:100%; border-collapse:collapse; margin-top:15px; }
.feedbackForm td { border:1px solid #ddd; padding:8px 10px; vertical-align:top; }
.feedbackForm td.feedbackLabel { background:#4a90d9; color:#fff; width:180px; font-weight:bold; }
.feedbackForm input[type=text] { width:98%; }
.feedbackForm textarea { width:98%; height:90px; }
</style>
<script type="text/javascript">
function submitFeedback(){
	var $panel = navTab.getCurrentPanel();
	var type = $.trim($("#FEEDBACK_TYPE", $panel).val());
	var title = $.trim($("#FEEDBACK_TITLE", $panel).val());
	var content = $.trim($("#FEEDBACK_CONTENT", $panel).val());
	if(type == ""){
		alertMsg.error("<spring:message code='alert.message.sys.notice.feedback.typeRequired'/>");
		return false;
	}
	if(title == ""){
		alertMsg.error("<spring:message code='alert.message.sys.notice.feedback.titleRequired'/>");
		return false;
	}
	if(content == ""){
		alertMsg.error("<spring:message code='alert.message.sys.notice.feedback.contentRequired'/>");
		return false;
	}
	$.ajax({
		type: 'POST',
		url: '/sys/notice/addFeedback',
		data: { FEEDBACK_TYPE: type, TITLE: title, CONTENT: content },
		dataType: 'json',
		cache: false,
		success: function(data){
			if(data.statusCode == "200"){
				alertMsg.correct(data.message);
				$("#FEEDBACK_TYPE", $panel).val("");
				$("#FEEDBACK_TITLE", $panel).val("");
				$("#FEEDBACK_CONTENT", $panel).val("");
			}else{
				alertMsg.error(data.message);
			}
		},
		error: DWZ.ajaxError
	});
	return false;
}
</script>
<div class="pageContent">
<div class="tabs" eventType="click" currentIndex="0">
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<li><a href="javascript:;"><span><spring:message code="sys.notice.feedback.tab1"/></span></a></li>
				<li><a href="javascript:;"><span><spring:message code="sys.notice.feedback.tab2"/></span></a></li>
				<li><a href="javascript:;"><span><spring:message code="sys.notice.feedback.tab3"/></span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsContent">
		<div id="feedbackComplaints_0">
			<div class="feedbackContent">
				<h3><spring:message code="sys.notice.feedback.tab1"/></h3>
				<h4>&#9744; <spring:message code="sys.notice.feedback.intro.title"/></h4>
				<ul>
					<li><spring:message code="sys.notice.feedback.intro.p1"/></li>
					<li><spring:message code="sys.notice.feedback.intro.p2"/></li>
					<li><spring:message code="sys.notice.feedback.intro.p3"/></li>
				</ul>
				<h4>&#9744; <spring:message code="sys.notice.feedback.security.title"/></h4>
				<ul>
					<li><spring:message code="sys.notice.feedback.security.p1"/></li>
				</ul>
				<h4>&#9744; <spring:message code="sys.notice.feedback.process.title"/></h4>
				<ul>
					<li><spring:message code="sys.notice.feedback.process.p1"/></li>
					<li><spring:message code="sys.notice.feedback.process.p2"/></li>
					<li><spring:message code="sys.notice.feedback.process.p3"/></li>
				</ul>
			</div>
		</div>
		<div id="feedbackComplaints_1">
			<div class="feedbackContent">
				<h3><spring:message code="sys.notice.feedback.tab2"/></h3>
				<h4><spring:message code="sys.notice.feedback.guide.content.title"/></h4>
				<p><spring:message code="sys.notice.feedback.guide.content.p1"/></p>
				<p><spring:message code="sys.notice.feedback.guide.content.p2"/></p>
				<h4><spring:message code="sys.notice.feedback.guide.staff.title"/></h4>
				<p><spring:message code="sys.notice.feedback.guide.staff.p1"/></p>
				<table class="feedbackContact">
					<tr>
						<th style="width:30px;">1</th>
						<td>Hoàng Thị Diệu Hồng</td>
						<td><spring:message code="sys.notice.feedback.guide.staff.position1"/></td>
						<td>0967324898</td>
						<td>dieuhong01@hanwha.com</td>
					</tr>
					<tr>
						<th>2</th>
						<td>Mr. ko JaeGyun</td>
						<td><spring:message code="sys.notice.feedback.guide.staff.position2"/></td>
						<td>0986979740</td>
						<td>kojaegyun@hanwha.com</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="feedbackComplaints_2">
			<div class="feedbackContent">
				<h3><spring:message code="sys.notice.feedback.tab3"/></h3>
				<h4><spring:message code="sys.notice.feedback.send.contentTitle"/></h4>
				<table class="feedbackForm">
					<tr>
						<td class="feedbackLabel"><spring:message code="sys.notice.feedback.send.issueTitle"/></td>
						<td><ait:SelectSyCodeByCpnyID id="FEEDBACK_TYPE" name="FEEDBACK_TYPE" parentNo="14014426" selected="${FEEDBACK_TYPE}" limit="ALL"/></td>
					</tr>
					<tr>
						<td class="feedbackLabel"><spring:message code="sys.notice.feedback.send.titleLabel"/></td>
						<td><input type="text" id="FEEDBACK_TITLE" name="FEEDBACK_TITLE" maxlength="200" /></td>
					</tr>
					<tr>
						<td class="feedbackLabel"><spring:message code="sys.notice.feedback.send.contentLabel"/></td>
						<td><textarea id="FEEDBACK_CONTENT" name="FEEDBACK_CONTENT" maxlength="4000"></textarea></td>
					</tr>
				</table>
				<div class="formBar">
					<ul>
						<li>
							<div class="buttonActive">
								<div class="buttonContent">
									<button type="button" onclick="return submitFeedback();"><spring:message code="sys.notice.feedback.send.button"/></button>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
