<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>

<script type="text/javascript">
function uploadifySuccess_Notice(file, data, response){
  //获取后台返回到前台的文件名，添加到隐藏域,多文件用";"号隔开
  var files = $("#fileNmae_Notice").html();
  var fileUrl = $("#fileUrl_Notice").val();
  var fileName = $("#fileName_Notice").val();
  var fileResult = data.split(";");
  //第一个文件
  if(files=="" || files==null){
    files = fileResult[0];
    fileName = fileResult[0];
    fileUrl = fileResult[1];
  }else{
    files+=";"+fileResult[0];
    fileName+=";"+fileResult[0];
    fileUrl+=";"+fileResult[1];
  }
  $("#fileNmae_Notice").html(files);
  $("#fileUrl_Notice").val(fileUrl);
  $("#fileName_Notice").val(fileName);
}
</script>
<div class="pageContent">
	<form id="updateNoticeInfoView" name="updateNoticeInfoView" method="post" action="/sys/notice/updateNoticeInfo" 
			class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent nowrap" layoutH="56">
			<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="user_table margin_b">
			<tr>
				<td class="td_title"><spring:message code="ess.title.Title"/><!-- 标题 --></td>
				<td class="td_type">
					<%-- <input type="text" name="TITLE" value=" ${item.TITLE }" size="30" maxLength="200"  class="required"> --%>
					<textarea style="width:400px;height:60px" name="TITLE" class="editor" tools="FontColor,|,Fullscreen">${item.TITLE }</textarea>
					<input type="hidden" name="CPNY_ID" value="${defaultCpnyId }"/>
					<input type="hidden" name="ID" value="${item.ID }">
					<font color="red"><!--不能超过200个字--><spring:message code="alert.message.canNotMoreThanFont.b"/></font></td>
			</tr>
			<tr>
					<td class="td_title" style="width:122px"><spring:message code="hr.viewAdditional.title.REMARK"/><!-- 公告内容 --></td>
					<td class="td_type">
						<textarea style="width:400px;height:200px" name="CONTENT" class="editor" tools="Cut,Copy,Paste,|,Fullscreen">${item.CONTENT }</textarea>
					</td>
			</tr>
			<tr>
				<td class="td_title"><spring:message code="hr.contract.title.xuqian.kaishiriqi"/><!-- 发布日期 --></td>
				<td class="td_type">
					<!--<input type="text" id="FROM_DATE" name="FROM_DATE" class="date required"
							yearstart="-20" yearend="20" value="${item.FROM_DATE }"/>
					<a class="inputDateButton"><spring:message
						code="public.title.choose" /> 选择 </a>-->
				<input type="text" name="FROM_DATE" id="FROM_DATE" value="${item.FROM_DATE }" class="Wdate required" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
				</td>
			</tr>
			<tr>
				<td class="td_title"><spring:message code="public.title.endDate"/></td>
				<td class="td_type">
					<!--<input type="text" id="TO_DATE" name="TO_DATE" class="date required"
							yearstart="-20" yearend="20" value="${item.TO_DATE }"/>
					<a class="inputDateButton"><spring:message
						code="public.title.choose" /> 选择 </a>-->
					<input type="text" name="TO_DATE" id="TO_DATE" value="${item.TO_DATE }" class="Wdate required" readonly="true" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" />
					<input type="hidden" name="PERIOD" class="required" value="${item.PERIOD }">
					<input type="hidden" name="ACTIVITY" value="${item.ACTIVITY}"/>
				</td>
			</tr>
			<tr>
				<td class="td_title"><spring:message code="pa.salary.title.order"/></td>
				<td class="td_type">
					<input type="number" name="ORDERNO" class="required" value="${item.ORDERNO }">
				</td>
			</tr>
			</table>
			
			<div style="font:10px;float:left;height:20px;line-height:20px;">
				<a class="w_button"  target="dialog" href="/pa/fileImport/importFile?importFunName=fileUploading&applyType=notice&applyNo=${item.ID }">
					<span><spring:message code="org.title.Attached_File" /><!--Upload file --></span>
				</a>
				<a class="w_button" href="#" 
				onclick="deleteAttList_new('viewFileRoomList_unit','/evs/manage/viewAddFileRoomInfo?SEQ=${item.SEQ}',divAjaxDone,'<spring:message code="js.upload.msg.firstSelectDelete" />','<spring:message code="js.upload.msg.confirmToDelete" />')">
				<span><!-- 删除 --><spring:message code="org.title.DELETE" /></span></a>
			</div>
			<table id="fileTable" class="list" width="100%">
				<thead>
					<tr>
						<th width="10%">V</th>
						<th width="90%"><!--附件--><spring:message code="pa.ins.alert.message.exportdata.fileAdd" /></th>
					</tr>
				</thead>
				<tbody>
				    <c:forEach items="${item.fileList}" var="item" varStatus="i">
						<tr>
							<td class='td_center'><input type="checkbox" name="FILE_NO" id="FILE_NO" value="${item.FILE_NO}"/></td>
							<td><a href="/ess/infoApplyLeave/downloadFile?fileName=${item.FILE_URL }&file=${item.FILE_NAME}" >${item.FILE_NAME}</a></td>
						</tr>
					</c:forEach>
				</tbody>
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
