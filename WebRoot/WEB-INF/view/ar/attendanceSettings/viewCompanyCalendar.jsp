<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script>
	function f_search_viewcompanycalendar(){	
		navTabSearch(document.viewcompanycalendar);
	}
    function f_update_viewcompanycalendar()
    {
    	var year = $("#year").val() ;
		var month = $("#month").val() ;
        document.viewcompanycalendar.action = '/ar/attendanceSettings/updateCompanyCalendarView?actionType=edit';
        navTabSearch(document.viewcompanycalendar);
        //location.href = '/ar/attendanceSettings/updateCompanyCalendarView?actionType=edit&year=' + year + "&month=" + month ; 
    }

    function prev_viewcompanycalendar(){
    	var year = $("#year",navTab.getCurrentPanel()).val() ;
    	var month = $("#month",navTab.getCurrentPanel()).val() ;
    	var myDate = new Date();
    	myDate.setFullYear(year, month-1, 1);
    	month = myDate.getMonth() + 1;
    	
    	if(month == 1){
    		year = year - 1;
    		month = 12;
    	}else if(month > 1 && month <= 12){
    		month = month - 1;
    	}
    	month = month < 10 ? "0" + month : "" + month;
    	
    	$("#year",navTab.getCurrentPanel()).attr("value",year);
    	$("#month",navTab.getCurrentPanel()).attr("value",month);
    	navTabSearch(document.viewcompanycalendar);
    }

    function next_viewcompanycalendar(){
    	var year = $("#year",navTab.getCurrentPanel()).val() ;
    	var month = $("#month",navTab.getCurrentPanel()).val() ;
    	var myDate = new Date();
    	myDate.setFullYear(year, month-1, 1);
    	month = myDate.getMonth() + 1;
    	
    	if(month == 12) {
    		year = parseInt(year) + 1;
    		month = 1;
    	}else if(month >= 1 && month < 12){
    		month = month + 1 ;
    	}
    	month = month < 10 ? "0" + month : "" + month ;
    	$("#year",navTab.getCurrentPanel()).attr("value",year);
    	$("#month",navTab.getCurrentPanel()).attr("value",month);
		navTabSearch(document.viewcompanycalendar);
    }
    
    function validateAddResumeInfoCallback(form) {
    	var $form = $("#" + form);
		alertMsg.confirm("<spring:message code="hrm.empinfo.SAVE_CONFIRM"/>", {//确定要保存吗？
			okCall : function() {
				$.ajax({
					type : 'POST',
					url : '/ess/infoApplyLeave/uploadFile',
					data : $form.serializeArray(),
					dataType:"json",
	  				cache: false,
	  				success: navTabAjaxDoneWithForm,
	  				error: DWZ.ajaxError
				});
			}
		});
		return false;
	}
    
    
</script>
<div class="pageContent">
	<div class="day">
		<div class="day_border">
		<div class="day_left_top">
		</div>
		<div class="day_left_bottom">
		</div>
		<div class="day_right_top">
		</div>
		<div class="day_right_bottom">
		</div>	  	 
		<form id="viewcompanycalendar" action="/ar/attendanceSettings/viewCompanyCalendar" method="post" name="viewcompanycalendar">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="day_nav_table">
			<tr>
			<th class="day_table_left_th">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<a href="javascript:prev_viewcompanycalendar()" title="previous" class="day_arrow_left"></a>
						</td>
						<td>
							<ait:date yearName="year" yearMinus="10" yearPlus="10" yearSelected="${param.year}" monthName="month" monthSelected="${param.month}"/>
						</td>
						<td>
							<a href="javascript:next_viewcompanycalendar()" title="next"  class="day_arrow_right"></a>
						</td>
					</tr>
				</table>	
			</th>
			<th class="day_table_right_th">
				<table align="right" border="0" cellpadding="0" cellspacing="0">
				<tr>
				<td class="day_table_right_line">
					<a class="bottona_a" onclick="f_search_viewcompanycalendar()"><span class="icon search_a"></span><span class="bottona_a_r"><!-- 查询 --><spring:message code="button.search"/></span></a>
				</td>
				<td>
					<c:if test="${toolbarInfo.INSERTR == '1'}">
						<a class="bottona_a bottona_b" href="/ar/attendanceSettings/addCompanyCalendarView" target="dialog" mask="true"><span class="icon add_a"></span><span class="bottona_a_r"><!-- 添加 --><spring:message code="button.add"/></span></a>
					</c:if>
				</td>
				<td>
					<c:if test="${toolbarInfo.UPDATER == '1'}">
						<a class="bottona_a" onclick="f_update_viewcompanycalendar()"><span class="icon edit_a"></span><span class="bottona_a_r"><!-- 修改 --><spring:message code="button.update"/></span></a>
					</c:if>
				</td>
				</tr>
				</table>				
			</th>
			</tr>
		</table>
	
	<table width="100%" border="0"  cellpadding="0" cellspacing="0" class="day_table">			
		<tr>
			<th><b>Sun</b></th>
			<th>Mon</th>
			<th>Tues</th>
			<th>Wed</th>
			<th>Thur</th>
			<th>Fri</th>
			<th><b>Sat</b></th>
		</tr>
		${calendarHtml} 
	</table>
	<td class="day_table_right_line">
			<a class="bottona_a"
				onclick="validateAddResumeInfoCallback('viewcompanycalendar')"
				href="#"><span><spring:message code="button.sys.affirm.save" /><!--保存--></span></a>
	</td>
	<c:if test="${fileRoomInfo == '{fileList=[]}'}">
				<div>
					<div style="font:10px;float:left;height:20px;line-height:20px;">
						<a class="w_button"  target="dialog" href="/pa/fileImport/importFile?importFunName=fileUploading&applyType=COMPANY_CALENDAR&applyNo=11111112">
							<span><spring:message code="org.title.Attached_File" /><!--Upload file --></span>
						</a>
						<a class="w_button" href="#" onclick="deleteAttListInsert_new('<spring:message code="js.upload.msg.firstSelectDelete" />');"><span><!-- 删除 --><spring:message code="org.title.DELETE" /></span></a>
					</div>
					<table id="fileTable" class="list" width="100%">
						<thead>
							<tr>
								<th width="10%">V</th>
								<th width="90%"><!-- 附件 --><spring:message code="ess.empInfo.enclosure" /></th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</c:if>
			<c:if test="${fileRoomInfo != '{fileList=[]}'}">
				<div>
					<div style="font:10px;float:left;height:20px;line-height:20px;">
						<a class="w_button"  target="dialog" href="/pa/fileImport/importFile?importFunName=fileUploading&applyType=COMPANY_CALENDAR&applyNo=11111112">
							<span><spring:message code="org.title.Attached_File" /><!--Upload file --></span>
						</a>
						<a class="w_button" href="#" onclick="deleteAttList_new('viewFileRoomList_unit','/evs/manage/viewAddFileRoomInfo?SEQ=${fileRoomInfo.SEQ}',divAjaxDone,'<spring:message code="js.upload.msg.firstSelectDelete" />','<spring:message code="js.upload.msg.confirmToDelete" />')"><span><!-- 删除 --><spring:message code="org.title.DELETE" /></span></a>
					</div>
					<table class="list" width="100%">
						<thead>
							<tr>
								<th width="10%">V</th>
								<th width="90%"><!-- 附件 --><spring:message code="ess.empInfo.enclosure" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${fileRoomInfo.fileList}" var="item" varStatus="i">
								<tr>
									<td class='td_center'><input type="checkbox" name="FILE_NO" value="${item.FILE_NO}"/></td>
									<td><a href="/ess/infoApplyLeave/downloadFile?fileName=${item.FILE_URL }&file=${item.FILE_NAME}" >${item.FILE_NAME}</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>
	</form>
	</div>
	</div>
</div>