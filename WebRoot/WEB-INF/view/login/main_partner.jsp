<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/initTaglibs.jsp"%>
<script type="text/javascript">
var icon = 0;
var loggedAccount = null;
//定时触发验证方法
$(document).ready(
		function() {
			var tempCookie = document.cookie.split(";");
			for ( var i = 0; i < tempCookie.length; i++) {
				if (tempCookie[i].indexOf(",") != -1) {
					loggedAccount = tempCookie[i].substring(tempCookie[i]
							.indexOf("=") + 1, tempCookie[i].indexOf(","))
				}
			}

			//setInterval("checkSession()", 1000 * 1860);
		});
//验证session是否失效
function checkSession() {

	if (icon == 0) {
		$.ajax( {
			type : 'POST',
			url : "/login/validateSession/checkSession",
			cache : false,
			dataType : "text",
			success : function(result) {
				if (result !== "0") {
					//$("#loginAgain").css("display","block");
			alert('<spring:message code="hrm.alert.empinfo.session_invalid" />');//session已失效 请重新登陆！
			window.opener = null;
			window.open("", "_self");
			window.close();
			icon = 1;
		}
	}
		});
	}
}

var flag = 1;
$(document).ready(function() {

	try {
		var arrCookie = document.cookie.split(';');
		var userId = '';
		var company = '';

		for ( var i = 0; i < arrCookie.length; i++) {

			if (arrCookie[i].indexOf(",") != -1) {
				var array = arrCookie[i].split(",");
				var arr_user = array[0].split("=");
				var arr_company = array[1].split("=");

				if (arr_user[0].indexOf("sysAdmin.account") != -1) {
					userId = arr_user[1];
				}

				if (arr_company[0].indexOf("sysAdmin.company") != -1) {
					company = arr_company[1];
				}

				if (userId != '' && company != '') {
					break;
				}
			}
		}

		//document.getElementById('language').value = language;
		document.getElementById('COMPANY_ID').value = company;
		document.getElementById('username').value = userId;
		document.getElementById('saveBox').checked = true;
	} catch (e) {

	}
	//	if(userId=='' && document.getElementById('username')){
	//		document.getElementById('username').focus();
	//	}else if(userId!='' && document.getElementById('password')){
	//		document.getElementById('password').focus();
	//	}

});

$(document)
		.ready(function() {
			//获取cookie字符串 
				var strCookie = document.cookie;
				//将多cookie切割为多个名/值对 
				var arrCookie = strCookie.split(";");
				var userId = null;
				//alert(arrCookie);
				//遍历cookie数组，处理每个cookie对 
				for ( var i = 0; i < arrCookie.length; i++) {
					var arr = arrCookie[i].split("=");
					//找到名称为userId的cookie，并返回它的值 
					if ("locale_cookie" == arr[0].replace(/^\s+|\s+$/g, "")) {
						userId = arr[1];
						break;
					}
				}
				if (userId == null) {
					userId = 'zh_CN';
				}
				$('#btn')
						.click(function() {
							//var arrCookie = document.cookie;

								var mess = check();
								if (flag == 1 && mess == null) {
									$("#Tip").text("Loading...");
									$
											.ajax( {
												type : 'POST',
												url : '/login/in?locale=' + userId,
												cache : false,
												data : {
													"username" : $("#username")
															.val(),
													"password" : $("#password")
															.val(),
													"COMPANY_ID" : $(
															"#COMPANY_ID")
															.val()
												},
												dataType : "text",
												success : function(responseText) {
													if (responseText == "1") {
														//保存cookie
														var date = new Date();
														var checkb = document
																.getElementById('saveBox')
														if (checkb.checked) {
															date.setTime(date
																	.getTime()
																	+ 365
																	* 24
																	* 3600
																	* 1000);
														} else {
															date
																	.setTime(date
																			.getTime() - 1000);
														}

														document.cookie = 'sysAdmin.account1='
																+ escape(document
																		.getElementById('username').value)
																+ ',sysAdmin.company1='
																+ escape(document
																		.getElementById('COMPANY_ID').value)
																+ ';expires='
																+ date
																		.toGMTString();

														var tempCookie = document.cookie
																.split(";");
														var account = tempCookie[0]
																.substring(
																		tempCookie[0]
																				.indexOf("=") + 1,
																		tempCookie[0]
																				.indexOf(","));
														icon = 0;
														if (loggedAccount != account) {
															alertMsg
																	.warn(
																			"\u60a8\u4e0d\u662f\u4e0a\u6b21\u767b\u5f55\u8005! \u70b9\u51fb\u8fd4\u56de\u767b\u5f55\u9875!",
																			{
																				okCall : function() {
																					location.href = "/";

																				}
																			});
														}
														$("#loginAgain").css(
																"display",
																"none");
														$('#Tip').html("");
														$("#password").val("");
													} else {
														$('#Tip').html(
																responseText);
													}
												}
											});
									return true;
								} else {
									$('#Tip').html(mess);
									return false;
								}
							});
			});

function check() {
	var u = $("#username").val();

	var p = $("#password").val();

	var company = $("#COMPANY_ID").val();

	var msg = null;

	if (company == '') {
		msg = 'please choose company';
	} else {
		if (u.replace(/(^\s*)|(\s*$)/g, "").length == 0)
			if (p.replace(/(^\s*)|(\s*$)/g, "").length == 0)
				msg = 'ID and PASSWORD must input.'
			else
				msg = 'ID must input.'
		else if (p.replace(/(^\s*)|(\s*$)/g, "").length == 0)
			msg = 'PASSWORD must input.'
	}

	return msg;
}<c:if test="${isIndexUserHr eq '1'}">
$(function(){
	//setTimeout('getUpgradeList()',"2000");
	//setTimeout('getProbationList()',"2000");
});
</c:if>
<c:if test="${isIndexUserContract eq '1'}">
$(function(){
	//setTimeout('getNotExistsContractList()',"2000");
	//setTimeout('getContractList()',"2000");
});
</c:if>
$(function(){
	//setTimeout('getBirthdayList()',"2000");
});

function getNotExistsContractList() {
		$.ajaxSettings.global = false;
		$.ajax( {
			type : "POST",
			url : "/login/getNotExistsContractList",
			data : {},
			dataType : "json",
			success : function(data) {
				$('#alertMsg3 a').html("<spring:message code="hrm.empinfo.no_sign_contract" />(" + data['getNotExistsContractCnt'] + ")");//未签合同
				var html = '';
				if (typeof (data['getNotExistsContractList']) != "undefined") {
					$.each(data['getNotExistsContractList'], function(commentIndex, comment) {
						var index = commentIndex + 1;
						if(index%2==0){
							html += '<tr class="tr_bg">';
						}else{
							html += '<tr>';
						}
						html += '<td>' + index + '</td>';
						html += '<td style="text-align:left">';
						html += '<a onclick="navTabNum(\'/hrm/contractInfo/viewNOContractInfo?pageNum=1&menuNo=5308&navTabId=hr0305&singlePerson_id=' + comment['PERSON_ID'] + '\',\'\',\'hr0305\',\'<spring:message code="hrm.empinfo.no_sign_contract" />\');">' + comment['EMPID'] + '</a>';//未签合同
						html += '<td style="text-align:left">';
						html += '<a onclick="navTabNum(\'/hrm/contractInfo/viewNOContractInfo?pageNum=1&menuNo=5308&navTabId=hr0305&singlePerson_id=' + comment['PERSON_ID'] + '\',\'\',\'hr0305\',\'<spring:message code="hrm.empinfo.no_sign_contract" />\');">' + comment['LOCAL_NAME'] + '</a>';//未签合同
						html += '<td style="text-align:left">' + comment['DEPARTMENT_NAME'] + '</td>';
						html += '<td>' + comment['START_DATE'] + '</td>';
						html += '<td>' + comment['END_DATE'] + '</td>';
						html += '<td style="text-align:left">' + comment['PROB_PAY_RAT'] + '</td></tr>';
					});
				}
				$('#main_top_type_list_id3 table').append(html);
			}
		});
		$.ajaxSettings.global = true;
}
function getContractList() {
	$.ajaxSettings.global = false;
	$.ajax( {
		type : "POST",
		url : "/login/getContractList",
		data : {},
		dataType : "json",
		success : function(data) {
			$('#alertMsg4 a').html("<spring:message code='main.home.message.ovcontract' />(" + data['getContractCnt'] + ")");//到期合同
			var html = '';
			if (typeof (data['getContractList']) != "undefined") {
				$.each(data['getContractList'], function(commentIndex, comment) {
					var index = commentIndex + 1;
					if(index%2==0){
						html += '<tr class="tr_bg">';
					}else{
						html += '<tr>';
					}
					html += '<td>' + index + '</td>';
					html += '<td style="text-align:left">';
					html += '<a onclick="navTabNum(\'/hrm/contractInfo/viewExpiredContract?pageNum=1&menuNo=2558&navTabId=hr0301&singlePerson_id=' + comment['PERSON_ID'] + '\',\'\',\'hr0301\',\'<spring:message code="hrm.empinfo.contract_renew" />\');">' + comment['EMPID'] + '</a>';//续签合同
					html += '<td style="text-align:left">';
					html += '<a onclick="navTabNum(\'/hrm/contractInfo/viewExpiredContract?pageNum=1&menuNo=2558&navTabId=hr0301&singlePerson_id=' + comment['PERSON_ID'] + '\',\'\',\'hr0301\',\'<spring:message code="hrm.empinfo.contract_renew" />\');">' + comment['LOCAL_NAME'] + '</a>';//续签合同
					html += '<td style="text-align:left">' + comment['DEPARTMENT_NAME'] + '</td>';
					html += '<td style="text-align:left">' + comment['POSITION'] + '</td>';
					html += '<td>' + comment['START_CONTRACT_DATE'] + '</td>';
					html += '<td>' + comment['END_CONTRACT_DATE'] + '</td>';
					html += '<td>' + comment['DAYS'] + '</td></tr>';
				});
			}
			$('#main_top_type_list_id4 table').append(html);
		}
	});
	$.ajaxSettings.global = true;
}
function getProbationList() {
	$.ajaxSettings.global = false;
	$.ajax( {
		type : "POST",
		url : "/login/getProbationList",
		data : {},
		dataType : "json",
		success : function(data) {
			$('#alertMsg2 a').html("<spring:message code='main.home.message.yuzhuanzheng' />(" + data['getProbationCnt'] + ")");//预转正日期
			var html = '';
			if (typeof (data['getProbationList']) != "undefined") {
				$.each(data['getProbationList'], function(commentIndex, comment) {
					var index = commentIndex + 1;
					if(index%2==0){
						html += '<tr class="tr_bg">';
					}else{
						html += '<tr>';
					}
					html += '<td>' + index + '</td>';
					html += '<td style="text-align:left">';
					html += '<a onclick="navTabNum(\'/hrm/empinfo/viewPerConversionList?pageNum=1&menuNo=125243&navTabId=hr1100&singlePerson_id=' + comment['PERSON_ID'] + '\',\'\',\'hr1100\',\'预转正信息\');">' + comment['EMPID'] + '</a>';
					html += '<td style="text-align:left">';
					html += '<a onclick="navTabNum(\'/hrm/empinfo/viewPerConversionList?pageNum=1&menuNo=125243&navTabId=hr1100&singlePerson_id=' + comment['PERSON_ID'] + '\',\'\',\'hr1100\',\'预转正信息\');">' + comment['LOCAL_NAME'] + '</a>';
					html += '<td style="text-align:left">' + comment['DEPT_NAME'] + '</td>';
					html += '<td style="text-align:left">' + comment['POSITION'] + '</td>';
					html += '<td>' + comment['BEFORE_END_PROBATION_DATE'] + '</td>';
					html += '<td>' + comment['DAYS'] + '</td></tr>';
				});
			}
			$('#main_top_type_list_id2 table').append(html);
		}
	});
	$.ajaxSettings.global = true;
}
function getUpgradeList() {
	$.ajaxSettings.global = false;
	$.ajax( {
		type : "POST",
		url : "/login/getUpgradeList",
		data : {},
		dataType : "json",
		success : function(data) {
			$('#alertMsg5 a').html("<spring:message code='main.home.message.experiece' />(" + data['getUpgradeCnt'] + ")");//一个月内人事令
			var html = '';
			if (typeof (data['getUpgradeList']) != "undefined") {
				$.each(data['getUpgradeList'], function(commentIndex, comment) {
					var index = commentIndex + 1;
					if(index%2==0){
						html += '<tr class="tr_bg">';
					}else{
						html += '<tr>';
					}
					html += '<td>' + index + '</td>';
					html += '<td style="text-align:left">' + comment['EMPLOYEE_NUMBER'] + '</td>';
					html += '<td style="text-align:left">' + comment['LOCAL_NAME'] + '</td>';
					html += '<td style="text-align:left">' + comment['ORG_NAME_LOCAL'] + '</td>';
					html += '<td style="text-align:left">' + comment['POSITION'] + '</td>';
					html += '<td style="text-align:left">' + comment['EMP_TYPE_NAME'] + '</td>';
					html += '<td style="text-align:left">' + comment['ASSIGNMENT_TYPE'] + '</td>';
					html += '<td>' + comment['ASSIGNMENT_START_DATE'] + '</td></tr>';
				});	
			}
			$('#main_top_type_list_id5 table').append(html);
		}
	});
	$.ajaxSettings.global = true;
}
function getBirthdayList() {
	$.ajaxSettings.global = false;
	$.ajax( {
		type : "POST",
		url : "/login/getBirthdayList",
		data : {},
		dataType : "json",
		success : function(data) {
			$('#alertMsg6 a').html("<spring:message code='main.home.message.shengriliebiao' />(" + data['getBirthdayListCnt'] + ")");//生日列表
			var html = '';
			if (typeof (data['getBirthdayList']) != "undefined") {
				$.each(data['getBirthdayList'], function(commentIndex, comment) {
					var index = commentIndex + 1;
					if(index%2==0){
						html += '<tr class="tr_bg">';
					}else{
						html += '<tr>';
					}
					html += '<td>' + index + '</td>';
					html += '<td style="text-align:left">' + '<spring:message code="ess.empInfo.birth" />' + '</td>';//生日
					html += '<td style="text-align:left">' + comment['LOCAL_NAME'] + '</td>';
					//html += '<td style="text-align:left">' + comment['DEPARTMENT_NAME'] + '</td>';
					html += '<td style="text-align:left">' + comment['DOB'] + '</td>';
					
					html += '<td><a  style="cursor: pointer"  onclick="clickEquip(\'/login/sendEmailPage?email='+comment['EMAIL'] +'&date='+comment['DOB']+'&name='+comment['LOCAL_NAME']+'\')"  target="dialog"    mask="true" ><img src="/resources/images/E_mail.jpg" height="25" width="36"  />' + '</td></tr>';
				});	
			}
			$('#main_top_type_list_id6 table').append(html);
		}
	});
	$.ajaxSettings.global = true;
}

 
function  clickEquip(equipname){
$('#yq1012').attr('href',equipname);//通向后台的目标链接
 $('#yq1012').click();
}

$(function(){
    $('.left_tab .tab_tit a').click(function(){
        $(this).addClass('active').siblings().removeClass('active');
        $('.left_tab .tab_sub .tab_con').eq($(this).index()).show().siblings().hide();
    })
})

$(function(){
    $('.right_tab .tab_tit a').click(function(){
        $(this).addClass('active').siblings().removeClass('active');
        $('.right_tab .tab_sub .tab_con').eq($(this).index()).show().siblings().hide();
    })
})
function changeColor_home(obj){
	$(obj).css("color","black").css("font-weight","normal");
}
</script>
<style type="text/css">
/*public*/
* { margin: 0; padding: 0; }
body {  font-family: "Helvetica Neue", "Luxi Sans", "DejaVu Sans", Tahoma, "Hiragino Sans GB", STHeiti, "Microsoft YaHei"; font-size: 12px; }
ol, ul, li, dd, dl, dt { list-style: none; }
*:focus { outline: 0; }
em, i { font-style: normal; }
img, fieldset { border: 0; }
a { cursor: pointer; text-decoration: none; color: #4d4d4d; }
a:visited { color: #000 }
a:hover, a:active { text-decoration: none; }
.clearfix:after { content: "."; display: block; clear: both; height: 0; overflow: hidden; visibility: hidden; }
table { border-collapse: collapse; }
p { word-wrap: break-word; }

/*ess首页*/
.ess_content{
    background-size: 100% auto;
    /*background-size: 100% auto;*/
    /*width: 1600px;
    min-height: 710px;*/
}
.ess_content .tab_box{
    padding-top: 30%;
    padding-left: 3%;
    padding-right: 60px;
    padding-bottom: 60px;
    height: 150px;
}
.ess_content .left_tab{
    float: left;
    width: 870px;
    height: 315px;
    background: #fff;
    border-radius: 10px;
    box-shadow: -2px 4px 10px 3px #eee1d8;
}

.ess_content .right_tab{
    float: left;
    width: 100%;
    height: 100%;
    min-height: 380px;
    background-size: 100% 100%;
    border-radius: 10px;
    box-shadow: -2px 4px 10px 3px #eee1d8;
}
.ess_content .tab .tab_tit{
    height: 40px;
    width: 550px;
}
.ess_content .tab .tab_tit a{
    display: inline-block;
    width: 98px;
    height: 40px;
    line-height: 40px;
    background: #35060636;
    text-decoration: none;
    text-align: center;
    margin-right: 3px;
}
.ess_content .tab .tab_tit a.active{
    background: #fd7402;
    color: #fff;
}
.ess_content .tab .tab_con{
    height: 100%;
    width: 100%;
}
.tab_con{background: #ffffff;}
.tab_con ul{
    margin: 0;
    padding: 0;
    font-size: 13px;
}
.tab_con ul li{
    height: 23px;
    line-height: 23px;
}
.tab_con ul li a{
    display: block;
    padding-left: 10px;
    font-size: 13px;
}
.tab_con ul li a:hover{
    color: #fe913e;
}
.notice_box{
    position: absolute;
    top: 0;
    right: 0px;
    background: url("/resources/images/notice_bg.png") no-repeat;
    width: 400px;
    height: 400px;
    overflow: hidden;
}
.notice_box ul{
    margin: 117px 100px 0 68px;
}
.notice_box ul li{
    height: 30px;
    line-height: 30px;
    text-overflow:ellipsis;
    white-space:nowrap;
    overflow:hidden;
}
.notice_box ul li a{
    color: #000000;
    font-size: 13px;
}
.notice_box ul p{
    margin-top: 40px;
    text-align: right;
}
.notice_box ul p a{
    color: #0581b9;
    font-size: 13px;
}
.more{
	padding-top: 10px;
	padding-right: 10px;
}
</style>
<!-- 浮动登录框  -->
 <a target="dialog" id="yq1012" href="" title="编辑邮件" width="1000"
	height="400" mask="true" ></a>
	<%--<div id="loginAgain" style="display: none;">
		<div class="white_content">
			<form id="loginForm"
				onkeydown="if(event.keyCode==13) $('#btn').click();">
				<div class="login_top">
					<table border="0" cellspacing="0" cellpadding="0" id="infoTB"
						width="70%">
						<tr>
							<td class="l-table-edit-td">
								<img src="/resources/images/login/company.jpg" />
							</td>
							<td align="left">
								<ait:SyCompany target="login" name="COMPANY_ID" language="zh"
									limit="ALL" activity="1" />
							</td>
							<td rowspan="3" align="left" valign="middle">
								<img src="/resources/images/login/btn.jpg"
									title="<spring:message code='submit'/>" id="btn"
									class="l-button-submit" />
								<span style="display: none"><spring:message code="submit" />
								</span>
							</td>
						</tr>
						<tr>
							<td class="l-table-edit-td">
								<img src="/resources/images/login/userid.jpg" />
								<span style="display: none"><spring:message
										code="username" />:</span>
							</td>
							<td align="left">
								<input type="text" id="username" name="username" value=""
									class="l-input" onkeyup="check()">
							</td>
						</tr>
						<tr>
							<td class="l-table-edit-td">
								<img src="/resources/images/login/pw.jpg" />
								<span style="display: none"><spring:message
										code="password" />:</span>
							</td>
							<td align="left">
								<input type="password" id="password" name="password" value=""
									class="l-input" onkeyup="check()">
								<input type="hidden" id="language" name="language" value="zh" />
							</td>
						</tr>
						<tr>
							<td class="l-table-edit-td">
								&nbsp;
							</td>
							<td align="left">
								<input type="checkbox" name="checkbox" class="che"
									value="checkbox" id='saveBox' />
								Save ID
							</td>
							<td class="l-table-edit-td">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<font size="2" color="red"><span id="Tip">${msg}</span> </font>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<div class="black_overlay"></div>
	</div> --%>



	<div class="navTab-panel tabsPageContent layoutBox" style="max-height: 835px;">
		<div class="page unitBox"style="max-height: 835px;">
			<div class="main_type"style="max-height: 835px;">



				<!-- 3333333 -->

	<!-- <div width="500px" style="padding: 10px"> -->
	<div class="ess_content" style="max-height: 835px;">
		<div class="index_details fix">
               <!--index_top-->
               <div class="index_top">
                <div class="index_topcn1 col-lg-7 col-sm-6">
                <div class="index_toptp"><!-- <img src="/resources/css/dwzUI/themes/partner/images/index_tp.png"/> --></div>
                </div>
                <div class="index_topcn3 col-lg-5 col-sm-6">
                 <!--index_Notice-->
                 <div class="tab right_tab">
                  <%-- <div class="index_bt1 fix">
                   <div class="index_btcn1 fix">
                   <i><img src="/resources/css/dwzUI/themes/partner/images/index_bt3.png"/></i>
                   <h3><spring:message code="ess.main.announcement"/><!-- Announcement --></h3>
                   </div>
                  </div> --%>
                  
                  <div class="tab tab_tit">
                      <a href="javascript:void(0)" class="active"><spring:message code="ess.main.announcement"/><!-- Announcement --></a>
                      <a href="javascript:void(0)"><spring:message code="hr.viewCondSql.title.SHENGRI"/>(${getBirthdayListCnt})<!-- 生日 --></a>
                      <c:if test="${LoginUser.specialParam ne 'general'}">
                      <a style="text-decoration:none;" target="_blank" href="/login/home.do?sysType='Hub'">HUB</a>
                      </c:if>
                  </div>
                      
                  <div class="tab_sub">
						<!-- 公告 -->
						<div class="tab_con"xstyle="display: none">
                              <div class="index_Noticecn fix" style="margin-left:10px; margin-top:10px">
			                       <ul>
			                         <c:if test="${fn:length(getNoticeList) <= 0}">
			                            <li><!--无 --> <spring:message code="ess.infoApply.NOINFO" /></li>
			                         </c:if>
				                     <c:forEach items="${getNoticeList}" var="notice" varStatus="i" begin="0" end="12">
				                        <li><a href="/sys/notice/viewNotice?ID=${notice.ID}" target="dialog" rel="gg0101" mask="true" width="1000" height="800" title="${notice.CONTENT }">
				                            <font >
				                            <c:if test="${fn:length(notice.TITLE) > 60 }">${fn:substring(notice.TITLE,0,60)}...</c:if>
				                            <c:if test="${fn:length(notice.TITLE) <= 60 }">${notice.TITLE }</c:if>
				                            </font>
				                            </a>
				                        </li>
				                     </c:forEach>
				                     <p style="padding-right: 10px; float:right;">
				                     <a href="/sys/notice/viewNoticeInfo?cpnyId=${LoginUser.cpnyId}&pageNum=1&menuNo=2505&navTabId=ess0700" rel="ess0700" target="navTab" ref="2505"  mask="true" width="800" height="600" title="<spring:message code='ess.infoApply.gonggao' />">
				                     <spring:message code='ess.login.GENGDUO.Z' />>></a></p>
			                       </ul>
			                  </div>
						</div>
						
                        <!-- 生日 -->
                        <div class="tab_con" style="display: none">
                            
                            <div style="padding-top:10px">
                            <p class="more" style="text-align: right;">
                            <a href="/ess/empinfo/viewBrithList" style="text-decoration: none;" rel="photomissing" target="navTab"  title="<spring:message code="hr.viewCondSql.title.SHENGRI"/>">
                            <spring:message code='ess.login.GENGDUO.Z' />>></a></p>
                            <%-- <c:forEach items="${getBirthdayList}" var="notice" varStatus="i" begin="0" end="4"> --%>
								<table  width="100%" border="0" cellpadding="2" cellspacing="1">
									<tr>
									<td class="td_title" width="3%" style="text-align: center">No</td>
									<td class="td_title" width="10%" style="text-align: center"><spring:message code="inct.salesman.empNo" /><!-- 工号 --></td>
									<td class="td_title" width="23%" style="text-align: center"><spring:message code="alert.pa.pasalarycanshu.xingming" /><!-- 员工姓名 --></td>
									<td class="td_title" width="30%" style="text-align: center"><spring:message code="hr.viewPersonalInfo.title.DEPTNAME" /><!-- 部门 --></td>
									<td class="td_title" width="15%" style="text-align: center"><spring:message code="hr.viewPersonalInfo.title.POST_GRADE_NAME" /><!-- 职位 --></td>
									<td class="td_title" width="12%" style="text-align: center"><spring:message code="hrm.empinfo.DOB" /><!-- 生日 --></td>
									</tr>
									<c:forEach items="${getBirthdayList}" var="d" varStatus="i">
									<tr>
									<td class="td_type" style="text-align: center">${i.count }</td>
									<td class="td_type" style="text-align: center">${d.EMPID }</td>
									<td class="td_type" style="text-align: center">${d.LOCAL_NAME }</td>
									<td class="td_type" style="text-align: center">${d.DEPARTMENT_NAME }</td>
									<td class="td_type" style="text-align: center">${d.POST_GRADE_NAME }</td>
									<td class="td_type" style="text-align: center">${d.BIRTH }</td>
									</tr>
									</c:forEach>
									</table>
							<%-- </c:forEach> --%>
                            </div>
                         </div>
                         
                     </div>
                  
                 </div>
                </div>
               </div>
               <!--index_center-->
               <div class="index_center">
                <div class="index_centercn1 col-lg-2 col-sm-6">
                 <!--index_Record-->
                 <div class="index_Record fix">
                 <div class="index_bt1 fix">
                   <div class="index_btcn1 fix">
                   <i><img src="/resources/css/dwzUI/themes/partner/images/index_bt2.png"/></i>
                   <h3><spring:message code="ess.main.attendance"/><!-- Attendance --></h3>
                   <!--<a href="#"></a>-->
                   </div>
                  </div>
                  <!--index_Recordcn-->
                  <div class="index_Recordcn fix">
                   <ul>
                    <c:if test="${defaultRoleGroupName eq 'Administrator' || defaultRoleGroupName eq 'MyHome'}">
	                    <li>
	                       <a href="#" onclick="navTabNum('/ess/infoApplyAttendance/viewSSTApplyAttendance','pageNum=1&menuNo=587&navTabId=ess0214','ess0214','<spring:message code="ess.infoApply.attendance_applicated" />');"><span><spring:message code="ess.infoApply.attendance_applicated" /><!--考勤申请-->
	                       </span></a>
	                    </li>
	                    <li>
							<a onclick="navTabNum('/ess/infoApply/viewSSTOtApplyInfo','pageNum=1&menuNo=526&navTabId=ess0234','ess0234','<spring:message code="ess.infoApply.title.overtimeApply" />');"><span><spring:message code="ess.infoApply.title.overtimeApply" /><!--加班申请--></span></a>
						</li>
						<li>
	                       <a href="#" onclick="navTabNum('/ess/infoApplyAttendance/viewAttendancePersonalInfoList','pageNum=1&menuNo=80000077&navTabId=ess3213','ess3213','<spring:message code="ar.viewArVacationMonthExcel.KAOQINCHAKAN.b" />');"><span><spring:message code="ar.viewArVacationMonthExcel.KAOQINCHAKAN.b" /><!--考勤-->
	                       </span></a>
	                    </li>
	                    <li>
							<a onclick="navTabNum('/ess/infoApply/viewPersonOtApplyInfoList','pageNum=1&menuNo=14013700&navTabId=ess3207','ess3207','<spring:message code="ar.viewEmpInfoListTanchu.JIABANCHAXUN.b" />');"><span><spring:message code="ar.viewEmpInfoListTanchu.JIABANCHAXUN.b" /><!--加班--></span></a>
						</li>
					</c:if>
					<c:if test="${defaultRoleGroupName eq 'Coordinator'}">
					    <c:if test="${LoginUser.cpnyId eq 'HTSV'}">
					    <li>
					    	<a href="#" onclick="navTabNum('/ess/infoApplyAttendance/viewApplyAttenanceBatchInfoList?deleteYN=Y','defaultRoleGroupName=Coordinator&pageNum=1&menuNo=218333&navTabId=ess3401','ess3401','<spring:message code="ess.viewApplyAttenanceBatchInfoList.ApplyAttenanceBatch.b" />');">
					    	<span><spring:message code="ess.viewApplyAttenanceBatchInfoList.ApplyAttenanceBatch.b" /><!--批量考勤申请--></span></a>
					    </li>	
					    <li>
					        <a href="#" onclick="navTabNum('/ess/infoApply/viewPiciOtAffirmLBatchList?deleteYN=Y','defaultRoleGroupName=Coordinator&pageNum=1&menuNo=277586&navTabId=ess3403','ess3403','<spring:message code="ess.viewPiciOtAffirmLBatchList.ApplyOTBatch.b" />');">
					        <span><spring:message code="ess.viewPiciOtAffirmLBatchList.ApplyOTBatch.b" /><!--批量加班处理--></span></a>
					    </li>
					    </c:if>
					    <c:if test="${LoginUser.cpnyId eq 'HAE'}">
					    <li>
					    	<a href="#" onclick="navTabNum('/ess/infoApplyAttendance/viewApplyAttBatchByAnyApproverList?deleteYN=Y','defaultRoleGroupName=Coordinator&pageNum=1&menuNo=90000426&navTabId=ess3469','ess3469','<spring:message code="ess.viewApplyAttenanceBatchInfoList.ApplyAttenanceBatch.b" />');">
					    	<span><spring:message code="ess.viewApplyAttenanceBatchInfoList.ApplyAttenanceBatch.b" /><!--批量考勤申请--></span></a>
					    </li>	
					    <li>
					        <a href="#" onclick="navTabNum('/ess/infoApply/viewApplyOtLBatchByAnyApproverList?deleteYN=Y','defaultRoleGroupName=Coordinator&pageNum=1&menuNo=90000427&navTabId=ess3470','ess3470','<spring:message code="ess.viewPiciOtAffirmLBatchList.ApplyOTBatch.b" />');">
					        <span><spring:message code="ess.viewPiciOtAffirmLBatchList.ApplyOTBatch.b" /><!--批量加班处理--></span></a>
					    </li>
					    </c:if>
					</c:if>
                    <!--<c:forEach items="${viewApplyList}" var="list" varStatus="i" begin="0" end="3">
                       <li><a href="#"><span>${list.TYPE_NAME }(${list.TYPE_CODE_NAME })</span><i></i></a></li>
                    </c:forEach>-->                  
                   </ul>
                  </div>
                 </div>
                </div>
                <div class="index_centercn2 col-lg-7 col-sm-6">
                 <div class="tab left_tab">
                      <div class="tab tab_tit">
                          <a href="javascript:void(0)" class="active"><spring:message code="ess.main.approval_status"/>(${fn:length(viewNotAffirm)})<!-- Approval Status --></a>
                          <a href="javascript:void(0)"><spring:message code="ess.affirmApply.title.remark.weishenpi"/>(${fn:length(viewApprovalEmail)})<!-- 未审批 --></a>
                          <a href="javascript:void(0)"><spring:message code="ess.infoApply.gonggao"/>(${fn:length(viewNoticeedEmail) + fn:length(viewNoticeMeeting)})<!-- 公告 --></a>
                      </div>
                      <div class="tab_sub">
                      <!-- Approval Status -->
                          <div class="tab_con"xstyle="display: none"> <p class="more" style="text-align: right;"><a  href="#">&nbsp;</a></p>
                          	<ul>
		                     <c:forEach items="${viewNotAffirm}" var="item" varStatus="i">
		                        <li>
		                            <a href="${item.AFFIRM_URL}?seach_SEQ=${item.SEQ}&seach_APPLY_NO=${item.APPLY_NO}&READ_FLAG=1&seach_APPLY_TYPE=${item.APPLY_TYPE}&APPLY_FLAG=${item.APPLY_FLAG}&seach_ACTIVITY=${item.ACTIVITY}" 
		                            target="dialog" mask="true" width="1000" height="600" rel="applyInfo"
		                            <c:if test="${item.READ_FLAG eq '0'}">style="color:blue;font-weight:bold;"</c:if> onclick="changeColor_ess0601(this)"> * ${item.TITLE}</a> <br />
		                        </li>
		                     </c:forEach>
			               </ul>

						</div>
						<!-- 未审批 -->
                        <div class="tab_con" style="display: none"> <p class="more" style="text-align: right;"><a  href="#">&nbsp;</a></p>
                            <ul>
		                     <c:forEach items="${viewApprovalEmail}" var="item" varStatus="i">
								<li>
	                        		<a href="${item.AFFIRM_URL}?seach_SEQ=${item.SEQ}&seach_APPLY_NO=${item.APPLY_NO}&READ_FLAG=1&seach_APPLY_TYPE=${item.APPLY_TYPE}&APPLY_FLAG=${item.APPLY_FLAG}&seach_ACTIVITY=${item.ACTIVITY}&isHtml=main" 
	                        		target="dialog" mask="true" width="1000" height="600" rel="applyInfo"
	                        		<c:if test="${item.READ_FLAG eq '0'}">style="color:blue;font-weight:bold;"</c:if> onclick="changeColor_ess0601(this)"> * ${item.TITLE}</a> <br />
	                        	</li>
                        		</c:forEach>
			               </ul>
                        </div>
                        <!-- 公告 -->
                        <div class="tab_con" style="display: none"> <p class="more" style="text-align: right;"><a  href="#">&nbsp;</a></p>
                        	<ul>
		                     <c:forEach items="${viewNoticeedEmail}" var="item" varStatus="i">
								<li>
	                        		<a href="${item.AFFIRM_URL}?seach_SEQ=${item.SEQ}&seach_APPLY_NO=${item.APPLY_NO}&READ_FLAG=1&seach_APPLY_TYPE=${item.APPLY_TYPE}&APPLY_FLAG=${item.APPLY_FLAG}&seach_ACTIVITY=${item.ACTIVITY}" 
	                        		target="dialog" mask="true" width="1000" height="600" rel="applyInfo"
	                        		<c:if test="${item.READ_FLAG eq '0'}">style="color:blue;font-weight:bold;"</c:if> onclick="changeColor_ess0601(this)"> * ${item.TITLE}</a> <br />
	                        	</li>
                        	</c:forEach>
                        	<c:forEach items="${viewNoticeMeeting}" var="item" varStatus="i">
								<li>
	                        		<a href="#" style="color:red;font-weight:bold;"
	                        		onclick="navTabNum('/hrm/empinfo/MeetingRoomSearch','defaultRoleGroupName=MyHome&pageNum=1&menuNo=90000605&navTabId=ess0908&ROOM_NO=${item.ROOM_NO }','ess0908','<spring:message code="ga.meetingRoom.MEETING_WITH_EMPLOYEE" />');">
	                        		<span> * <spring:message code="ga.meetingRoom.MEETING_WITH_EMPLOYEE" /></span> ${item.ROOM_DATE }</a>
	                        	</li>
                        	</c:forEach>
			               </ul>
                        </div>
                        
                             </div>
                         </div>
                </div>
                <div class="index_topcn2 col-lg-3 col-sm-6">
                 <!--index_news-->
                 <div class="index_news fix">
                  <div class="index_bt fix">
                   <div class="index_btcn fix">
                   <i><img src="/resources/css/dwzUI/themes/partner/images/index_bt1.png"/></i>
                   <h3><spring:message code="ess.main.attendance_status"/><!-- Attendance Status --></h3>
	                   <c:if test="${defaultRoleGroupName eq 'Administrator' || defaultRoleGroupName eq 'MyHome'}">
	                   		<a href="#" onclick="navTabNum('/ess/infoApply/viewAbnormalApplyByAnyApprover','defaultRoleGroupName=MyHome&pageNum=1&menuNo=218302&navTabId=ess3205','ess3205','<spring:message code="ess.infoApply.check_error_attendance" />');"></a>
	                   </c:if>
	                   <c:if test="${defaultRoleGroupName eq 'Coordinator'}">
	                   		<a href="#" onclick="navTabNum('/ess/infoApplyAttendance/viewAttendanceExForBatchInfoList','defaultRoleGroupName=Coordinator&pageNum=1&menuNo=14015881&navTabId=ess3434','ess3434','<spring:message code="ess.infoApply.check_error_attendance" />');"></a>
	                   </c:if>
                   </div>
                  <!--index_newscn-->
                  <div class="index_newscn fix">
                    <ul>
                     <c:if test="${defaultRoleGroupName eq 'Administrator' || defaultRoleGroupName eq 'MyHome'}">
                        <c:forEach items="${viewAttendanceEx}" var="item" varStatus="i">
	                        <c:if test="${i.count lt 7}">
	                        	<li><span>${item.AR_DATE_STR }</span><a href="#" onclick="navTabNum('/ess/infoApply/viewAbnormalApplyByAnyApprover','defaultRoleGroupName=MyHome&pageNum=1&menuNo=218302&navTabId=ess3205&PK_NO=${item.PK_NO }','ess3205','<spring:message code="ess.infoApply.check_error_attendance" />');">${item.ITEM_NO_NAME }</a></li>
	                        </c:if>
                        </c:forEach>
                     </c:if>
                     <c:if test="${defaultRoleGroupName eq 'Coordinator'}">
                        <c:forEach items="${viewAttendanceExCoor}" var="item" varStatus="i">
                        	<c:if test="${i.count lt 7}">
	                        	<li><span>${item.AR_DATE_STR }</span><a href="#" onclick="navTabNum('/ess/infoApplyAttendance/viewAttendanceExForBatchInfoList','defaultRoleGroupName=Coordinator&pageNum=1&menuNo=14015881&navTabId=ess3434&ITEM_NO=${item.ITEM_NO }&seach_START_DATE=${item.AR_DATE_STR }&seach_END_DATE=${item.AR_DATE_STR }','ess3434','<spring:message code="ess.infoApply.check_error_attendance" />');">${item.ITEM_NAME }(${item.EMP_NUM })</a></li>
                        	</c:if>
                        </c:forEach>
                     </c:if>
                     <c:if test="${defaultRoleGroupName eq 'Management'}">
                        <c:forEach items="${viewAttendanceExManagement}" var="item" varStatus="i">
                        	<c:if test="${i.count lt 7}">
	                        	<!--<li><span>${item.AR_DATE_STR }</span><a href="#" onclick="navTabNum('/ess/infoApplyAttendance/viewAttendanceExForBatchInfoList','defaultRoleGroupName=Coordinator&pageNum=1&menuNo=14015881&navTabId=ess3434&ITEM_NO=${item.ITEM_NO }&seach_START_DATE=${item.AR_DATE_STR }&seach_END_DATE=${item.AR_DATE_STR }','ess3434','<spring:message code="ess.infoApply.check_error_attendance" />');">${item.ITEM_NAME }(${item.EMP_NUM })</a></li>-->
                                <li><span>${item.AR_DATE_STR }</span><a href="/ess/infoApply/viewAbnormalDetailInfo?AR_DATE_STR=${item.AR_DATE_STR }&ITEM_NO=${item.item.ITEM_NO }&ITEM_TYPE=218197" target="dialog" rel="gg0101" mask="true" width="1000" height="400" title="<spring:message code='ess.trans.title.viewInfo' />">
	                            ${item.ITEM_NAME }(${item.EMP_NUM })</a>
	                            </li>
	                        </c:if>
                        </c:forEach>
                        <c:if test="${viewAttendanceManagement[0] ne null}">
                                <li><span>${viewAttendanceManagement[0].AR_DATE_STR }</span><a href="/ess/infoApply/viewAbnormalDetailInfo?AR_DATE_STR=${viewAttendanceManagement[0].AR_DATE_STR }&ITEM_TYPE=21" target="dialog" rel="gg0101" mask="true" width="1000" height="400" title="<spring:message code='ess.trans.title.viewInfo' />">
	                            ${viewAttendanceManagement[0].ITEM_NAME }(${viewAttendanceManagement[0].EMP_NUM })</a>
	                            </li>
	                    </c:if>
	                    <c:if test="${viewOTManagement[0] ne null}">
	                            <li><span>${viewOTManagement[0].AR_DATE_STR }</span><a href="/ess/infoApply/viewAbnormalDetailInfo?AR_DATE_STR=${viewOTManagement[0].AR_DATE_STR }&ITEM_TYPE=31" target="dialog" rel="gg0101" mask="true" width="1000" height="400" title="<spring:message code='ess.trans.title.viewInfo' />">
	                            ${viewOTManagement[0].ITEM_NAME }(${viewOTManagement[0].EMP_NUM })</a>
	                            </li>
	                    </c:if>
                     </c:if>
                    </ul>
                  </div>
                  </div>
                 </div>
                </div>
                
               </div>
              </div>
	</div>
			</div>
		</div>
	</div>
	
	
<script>
window.onload=function(){
	//index_topcn1
	/* var content1= $('.index_topcn1').height();
    var bar1=$('.index_topcn2').height();
    if(content1>bar1){
        $('.index_topcn2').height(content1);
    }else{
        $('.index_topcn1').height(bar1);    
    }
	//index_topcn2
	var content2= $('.index_topcn2').height();
    var bar2=$('.index_topcn3').height();
    if(content2>bar2){
        $('.index_topcn3').height(content2);
    }else{
        $('.index_topcn2').height(bar2);    
    }
	//index_topcn3
	var content3= $('.index_topcn3').height();
    var bar3=$('.index_topcn1').height();
    if(content3>bar3){
        $('.index_topcn1').height(content3);
    }else{
        $('.index_topcn3').height(bar3);    
    }
	//index_centercn1
	var content4= $('.index_centercn1').height();
    var bar4=$('.index_centercn2').height();
    if(content4>bar4){
        $('.index_centercn2').height(content4);
    }else{
        $('.index_centercn1').height(bar4);    
    } */
};
</script>