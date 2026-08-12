<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<style type="text/css">
#t{
table-layout:fixed;word-break:break-all;
}
.aaa td
{
	height:400px;
	overflow:hidden;
	display:block;
}
.ctltable{border-collapse: collapse;
table-layout:fixed;}

.ctltable td {
text-overflow:ellipsis;
overflow:hidden;
white-space: nowrap;
border:1px solid #000000;}

.td_title {
	background: #F1F1F1;
	color: #000000;
}
.td {
	height:20px;
}
.td_type {
	color: #000000;
}

</style>
<script>
$(document).ready(function(){
	//查询
	$("#viewCardInfoList_Serch",navTab.getCurrentPanel()).click(function(){
		$("#viewCardInfoListForm",navTab.getCurrentPanel()).submit();
	});
	
	$("#seach_KEY",navTab.getCurrentPanel()).keydown(function(e) {
        if ( e.keyCode == 13) {
       	 	var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       		$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewHAECardInfoList&seach_KEY='+name);
       		$('.btnLook',navTab.getCurrentPanel()).click();
        }
    });
	$(".btnLook",navTab.getCurrentPanel()).click(function(e) {
       	 var name=encodeURI(encodeURI($('#seach_KEY',navTab.getCurrentPanel()).val()));
       	$('.btnLook',navTab.getCurrentPanel()).attr('href','/hrm/empinfo/viewEmpInfoListTanchu?pageNum=1&firstFlag=N&searchChange=viewHAECardInfoList&seach_KEY='+name);
    });

});

function changeZhijiCARD(status, id, aid) {
	var idvalue = $('#' + id).val();
	<c:if test="${LoginUser.cpnyId eq 'HTSV'}">
		var parentnoCARD = "'14015813','14015815'";
	</c:if>
	<c:if test="${LoginUser.cpnyId eq 'HAE'}">
	var parentnoCARD = "'14015814','14015815'";
</c:if>
	var idhref = '/hrm/empinfo/searchTanchu?PARENT_CODE_NO='+ parentnoCARD + '&firstFlag=N&status='+status+'&nameid=' + id + '&typeFlag=Y&idvalue=' + idvalue;
	$('#' + aid).attr('href', idhref);
}

function printData() {

	$("#viewHAECardInfoList_pageContent").jqprint( {
		debug : false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
		importCSS : true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
		printContainer : true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
		operaSupport : true
	//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
			});

}
</script>
<div>
<form id="viewCardInfoListForm" onsubmit="return navTabSearch(this);" action="/hrm/empinfo/viewHAECardInfoList" method="post">
<div class="searchBar">
<table class="searchContent">
	<tr>
		<td width="7%"><spring:message code="hrm.empinfo.nameAndEmpid"/><!-- 社号/姓名 --></td>
		<td width="23%">
			<div style="float:left"><input type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"/></div>
			<input type="hidden" name="seach_EMP_ID" id="seach_EMP_ID" value="${personInfo.EMPID}"/>
			<div style="float:left"><a class="btnLook" href="" lookupGroup="person"></a></div>
		</td>
		<td width="50%" colspan="3">
			<c:if test="${not empty personInfo}">
				<span style="margin-left: 50px;" >${personInfo.LOCAL_NAME }&nbsp/&nbsp${personInfo.EMPID }&nbsp/&nbsp${personInfo.POST_GRADE_NO_NAME}&nbsp/&nbsp${personInfo.STATUS_CODE_NAME }</span>
			</c:if>
		</td>
		<td width="20%"></td>
	</tr>
	<tr>
		<td><spring:message code="hrm.recruitManage.DATE_STARTED"/><!-- 入职日期 --></td>
		<td>
			<input type="text" id="seach_START_DATE_JOIN" name="seach_START_DATE_JOIN" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${START_DATE_JOIN }"/>~
			<input type="text" id="seach_END_DATE_JOIN" name="seach_END_DATE_JOIN" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${END_DATE_JOIN }"/>
		</td>
		<td><spring:message code="hrm.empinfo.ORG_NAME_LOCAL"/><!-- 部门 --></td>
		<td>
			<ait:deptList name="seach_DEPTNO" limit="hr" id="viewHAECardInfoList_seachDept"/>
			<ait:deptTreeIcon name="seach_DEPTNO" limit="hr" id="viewHAECardInfoList_seachDept" selected="${DEPTNO}"/>
			<input type="checkbox" name="seach_SON_FLAG" value="1" <c:if test="${SON_FLAG eq '1' }">checked="checked"</c:if>>
			<spring:message code="hrm.empinfo.Department_include"/><!-- 下位部门包括 -->
		</td>
		<td><spring:message code="ess.infoApply.renzhizhuangtai"/><!-- 任职状态 --></td>
		<td><ait:selectCodeMulti id="seach_EMP_OFFICE" name="seach_EMP_OFFICE_NAME" parentNo="15118" selected="${EMP_OFFICE}" selectedNm="${EMP_OFFICE_NAME}"/></td>
	</tr>
	<tr>
		<td><spring:message code="hrm.recruitManage.LEAVE_DATE"/><!-- 离职日期 --></td>
		<td>
			<input type="text" id="seach_START_DATE_LEFT" name="seach_START_DATE_LEFT" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${START_DATE_LEFT }"/>~
			<input type="text" id="seach_END_DATE_LEFT" name="seach_END_DATE_LEFT" class="Wdate" onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" value="${END_DATE_LEFT }"/>
		</td>
		<td><spring:message code="ess.trans.title.postGradeName"/><!-- 职级 --></td>
		<td>
			<!--<ait:selectCodeMulti id="seach_POST_GRADE_NO" name="seach_POST_GRADE_NO_NAME" 
				parentNo="14015578" selected="${POST_GRADE_NO}" selectedNm="${POST_GRADE_NO_NAME}"/>
			--><input type="text" id="zhijiCARD" name="zhijiCARD"
						value="${zhijiCARD }">
			<a id="jiCARD" class="" href="#"
				onclick="changeZhijiCARD('zhijiCARD','GRADE_NO_CARD','jiCARD')"
				lookupGroup="person"> <input type="button" value="......">
			</a>
			<input type="hidden" id="GRADE_NO_CARD" name="GRADE_NO" value="${GRADE_NO }">
		</td>
		<td><spring:message code="hrm.empinfo.EMP_TYPE_CODE_NAME"/><!-- 员工类型 --></td>
		<td><ait:selectCodeMulti id="seach_EMP_TYPE_CODE" name="seach_EMP_TYPE_CODE_NAME" parentNo="13864" selected="${EMP_TYPE_CODE}" selectedNm="${EMP_TYPE_CODE_NAME}"/></td>
		<td><div class="subBar">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent" align="center">
								<button class="button" id="viewCardInfoList_Serch">
									<!--onkeydown="javascript:if(event.keyCode == 13)return false;"-->
									<spring:message code="public.title.search" />
								</button>
							</div>
						</div>
					</li>

					<li>
						<div>
							<div class="buttonContent" align="center">
								<a class="button" onclick="printData()"><span><!--印刷--><spring:message code="hrm.approve.PRINTING" /></span> </a>
							</div>
						</div>
					</li>
					
					<li><a class="buttonActive" onclick="downloadExcel('viewCardInfoListForm','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=359&CPNY=${LoginUser.cpnyId}','/hrm/empinfo/viewHAECardInfoList?firstFlag=N')">
					<span><!-- 导出到Excel --><spring:message code="org.title.exportLOtImportExcel"/></span></a></li>
				</ul>
			</div></td>
	</tr>
</table>
</div>
</form>
</div>


<div class="pageContent" id="viewHAECardInfoList_pageContent"
		sysLong='printDiv'
		style="width: 850px;  padding-left: 10px; text-align: left;overflow: hidden;" >
		<c:if test="${empty viewCardInfoList}">
			<div style="height: 800px;">
			</div>
		</c:if>
<c:forEach items="${viewCardInfoList}" var="info">
<div style="height:1254px;position:relative;">
		<table width="100%" style="height: 40px;">
			<tr >
				<td width="40%">
				  <img src='/resources/images/HR_Card_logo.jpg'>
				</td>
				<td style="font-size: 20px; text-align: center;font-family:Calibri;color: #000000;" width="20%">
					<b>HR CARD</b></td>
				<td width="40%"></td>
			</tr>
		</table>
		<br />
		<c:forEach items="${info.viewBaseInfoList}" var="item">
		<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
			<tr>
				<td class="td_type" width="14.5%" rowspan="5" style="padding-top:0px;padding-bottom:0px;padding-left:1px;"><img src='${item.PHOTO_PATH }' height="118px" width="90px"></td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="15%">Date of Emp</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%">${item.DATE_STARTED} </td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">Level of education</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">${item.DEGREE_CODE}</td>
			</tr>
			<tr>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="15%">Promotion date</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%">${item.PROMOTION_DAY}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">Team</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%" colspan="2">${item.TEAM}</td>
			</tr>
			<tr>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="15%">Position</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%">${item.POST_GRADE_NAME}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">Nationality</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">${item.NATIONALITY_NAME}</td>
			</tr>
			<tr>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="15%">Group</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%">${item.DEPTNO}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">Job</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;"  width="20.5%" colspan="2">${item.MAIN_BUSINESS}</td>
			</tr>
			<tr>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="15%">Date of resign</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%">${item.DATE_LEFT}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">Marriage (Y/N)</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">${item.MARITAL_STATUS_CODE}</td>
			</tr>
			<tr>
				<td class="td_type" width="14.5%" rowspan="2" style="text-align: center;font-family:Calibri;color: #000000;">${item.LOCAL_NAME}<br>${item.EMPID}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="15%">Current Add</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%">${item.CURRENT_ADDRESS}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">Tell (Mobile)</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="20.5%" colspan="2">${item.CELLPHONE}</td>
			</tr>
			<tr>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="15%">Date of birth</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="29.5%">${item.DOB}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="10.25%">Height (cm)</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="10.25%">${item.HEIGHT}</td>
				<td class="td_title" style="text-align:left;font-family:Calibri;color: #000000;" width="10.25%">Weight (kg)</td>
				<td class="td_type" style="text-align:center;font-family:Calibri;color: #000000;" width="10.25%">${item.WEIGHT}</td>
			</tr>
		</table>
		</c:forEach>
		
		<br>
		
		<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
		<span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Education</b></span>
		<tr>
			<td class="td_title" width="10%" style="font-family:Calibri;color: #000000;">Y. of entrance</td>
			<td class="td_title" width="10%" style="font-family:Calibri;color: #000000;">Y. of graduation</td>
			<td class="td_title" width="20%" style="font-family:Calibri;color: #000000;">School name</td>
			<td class="td_title" width="14%" style="font-family:Calibri;color: #000000;">Level of education</td>
			<td class="td_title" width="14%" style="font-family:Calibri;color: #000000;">Major</td>
		</tr>
		<c:forEach items="${info.viewJiaoyuInfoList}" var="item">
		<tr>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="10%" height="20">${item.START_DATE }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="10%" height="20">${item.END_DATE }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="20%" height="20">${item.INSTITUTION_NAME }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="14%" height="20">${item.DEGREE_NAME }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="14%" height="20">${item.SUBJECT }</td>
		</tr>
		</c:forEach>
		</table>
		
		
		<br>
		
		
		<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
		 <span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Work experience</b></span>
			<tr>
				<td class="td_title" width="10%" style="font-family:Calibri;color: #000000;">Start</td>
				<td class="td_title" width="10%" style="font-family:Calibri;color: #000000;">Finish</td>
				<td class="td_title" width="20%" style="font-family:Calibri;color: #000000;">Company</td>
				<td class="td_title" width="14%" style="font-family:Calibri;color: #000000;">Position</td>
				<td class="td_title" width="14%" style="font-family:Calibri;color: #000000;">Job</td>
			</tr>
			<c:forEach items="${info.viewJingliInfoList}" var="item">
			<tr>
				<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="10%" height="20">${item.START_DATE }</td>
				<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="10%" height="20">${item.END_DATE }</td>
				<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="20%" height="20">${item.CPNY_NAME }</td>
				<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="14%" height="20">${item.DUTY }</td>
				<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" width="14%" height="20">${item.POSITION }</td>
			</tr>
			</c:forEach>
		</table>
		
		
		<br>
		
		
		<table width="100%" cellspacing="0" style="table-layout:fixed;word-break:break-all;">
			<tr>
				<td width="59%">
					<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
						<span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Family Relations</b></span>
						<tr>
							<td class="td_title" width="4.5%" style="font-family:Calibri;color: #000000;">Relations</td>
							<td class="td_title" width="4.5%" style="font-family:Calibri;color: #000000;">Name</td>
							<td class="td_title" width="3%" style="font-family:Calibri;color: #000000;">Age</td>
							<td class="td_title" width="3%" style="font-family:Calibri;color: #000000;">Company</td>
							<td class="td_title" width="3%" style="font-family:Calibri;color: #000000;">Position</td>
						</tr>
						<c:forEach items="${info.viewJiatingInfoList}" var="item">
						<tr>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.FAM_TYPE_NAME }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.FAM_NAME }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20" >${item.AGE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.FAM_COMPANY_NAME }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.OCUPATION }</td>
						</tr>
						</c:forEach>
					</table>
					
				</td>
				
				<td>&nbsp;</td>
				
				<td width="41%">
					<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
						  <span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Evaluation</b></span>
						<tr>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">Year</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">First half</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">Second half</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">Ability</td>
						</tr>
						<c:forEach items="${info.viewPingjiaInfoList}" var="item">
						<tr>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.EVS_YEAR }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.FIRST_HALF }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.SECOND_HALF }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.ABILITY }</td>
						</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
		</table>
		
		<br>
		
		<table width="100%" cellspacing="0" style="table-layout:fixed;word-break:break-all;">
			<tr>
				<td width="59%">
				
					<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
						<span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Certification</b></span>
						<tr >
							<td class="td_title" width="4.5%" style="font-family:Calibri;color: #000000;">Certificate</td>
							<td class="td_title" width="4.5%" style="font-family:Calibri;color: #000000;">Level</td>
							<td class="td_title" width="3%" style="font-family:Calibri;color: #000000;">D. of issue</td>
							<td class="td_title" width="3%" style="font-family:Calibri;color: #000000;">D. of exp</td>
							<td class="aaa" width="3%" style="background: #F1F1F1;color: #000000;font-family:Calibri;color: #000000;">Publishing<br>Office</td>
						</tr>
						<c:forEach items="${info.viewZigeInfoList}" var="item">
						<tr>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.QUAL_NAME }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.QUAL_LEVEL }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.DATE_OBTAINED }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.VALIDITY_DATE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.QUAL_INSTITUTE }</td>
						</tr>
						</c:forEach>
					</table>
					
				</td>
				
				<td>&nbsp;</td>
				
				<td width="41%">
					<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
						<span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Training issue</b></span>
						<tr >
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">Start</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">End</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">Course</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;">Grade</td>
						</tr>
						<c:forEach items="${info.viewPeixunInfoList}" var="item">
						<tr>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.IMPLE_START_DATE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.IMPLE_END_DATE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.COURSE_NAME_CODE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.EVA_RESULT }</td>
						</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
		</table>
		
		<br>
		
		<table width="100%" cellspacing="0" style="table-layout:fixed;word-break:break-all;">
			<tr>
				<td width="59%">
				
					<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
						<span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Reward</b></span>
						<tr >
							<td class="td_title" width="4.5%" style="font-family:Calibri;color: #000000;" height="20">Classification</td>
							<td class="td_title" width="4.5%" style="font-family:Calibri;color: #000000;" height="20">Date</td>
							<td class="td_title" width="6%" style="font-family:Calibri;color: #000000;" height="20">Reward name</td>
							<td class="td_title" width="3%" style="font-family:Calibri;color: #000000;" height="20">Reason for</td>
						</tr>
						<c:forEach items="${info.viewJiangliInfoList}" var="item">
						<tr>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">Reward</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.REWARD_DATE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.REWARD_TYPE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.REMARKS }</td>
						</tr>
						</c:forEach>
					</table>
				</td>
				
				<td>&nbsp;</td>
				
				<td width="41%">
					<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
						<span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Disciplinary</b></span>
						<tr >
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;" height="20">Classification</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;" height="20">Date & end date</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;" height="20">Name</td>
							<td class="td_title" width="7%" style="font-family:Calibri;color: #000000;" height="20">Reason for</td>
						</tr>
						<c:forEach items="${info.viewChengfaInfoList}" var="item">
						<tr>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">Discipline</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.S_E_DATE }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.PUNISH_NAME }</td>
							<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.PUNISH_REASON }</td>
						</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
		</table>
		
		<br>
		
		<table width="100%" class="user_table" style="table-layout:fixed;word-break:break-all;">
		 <span style="font-size:14px;font-family:Calibri;color: #000000;"><b>Appointment History</b></span>
		<tr>
			<td class="td_title" width="10%" style="font-family:Calibri;color: #000000;" height="20">App. date</td>
			<td class="td_title" width="10%" style="font-family:Calibri;color: #000000;" height="20">App. type</td>
			<td class="td_title" width="20%" style="font-family:Calibri;color: #000000;" height="20">Dept</td>
			<td class="td_title" width="14%" style="font-family:Calibri;color: #000000;" height="20">Position</td>
			<td class="td_title" width="14%" style="font-family:Calibri;color: #000000;" height="20">Grade</td>
		</tr>
		<c:forEach items="${info.viewFalingInfoList}" var="item">
		<tr>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.START_DATE }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.TRANS_REASON }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.DEPT_NAME }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.POST_GRADE_NAME }</td>
			<td class="aaa" style="text-align:center;font-family:Calibri;color: #000000;" height="20">${item.PAY_STEP_NAME }</td>
		</tr>
		</c:forEach>
		</table>
		</div>
	</c:forEach>
	</div>
