<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/initTaglibs.jsp"%>
<%@page import = "com.ait.web.util.GetPassword" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <title>AIT HR System</title>
<%
    String wsSt = request.getParameter("slo_p_sv");
	String otaId = request.getParameter("slo_p_ota");
	String requestURL = request.getHeader("Referer");
%>

    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>

    <link href="/resources/css/dwzUI/themes/index/bootstrap-3.3.4.css" rel="stylesheet" type="text/css" /><!-- BOOTSTRAP CSS -->
    <link href="/resources/css/dwzUI/themes/index/bootstrap-reset.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/dwzUI/themes/index/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/dwzUI/themes/index/public.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/dwzUI/themes/index/menu.css"/>
    <script type="text/javascript" src="/resources/js/index/menu.js"></script>
    <script type="text/javascript" src="/resources/js/index/bootstrap.min.js"></script>
    <script type="text/javascript" src="/resources/js/index/index.js"></script>
    <script type="text/javascript">

        //var canSubmit=true;
        var flag=1;
        $(document).ready(function() {

            /* var UA=navigator.userAgent;
             if(UA.toString().indexOf('MSIE')==-1 && UA.toString().indexOf('rv:11')==-1){
                canSubmit=false;
                alert('该系统只支持IE浏览器，请使用IE浏览器进行访问，对此带来的不便，我们深表歉意！！');
                window.opener=null;
               window.open("","_self");
              window.close();
            } */
            /* if(location.port == '7001'){
                $("#COMPANY_ID option[value='TSTO']").attr("selected", true);
                $("#COMPANY_ID option[value='SST']").remove();
            }else if(location.port == '7011'){
                $("#COMPANY_ID option[value='SST']").attr("selected", true);
                $("#COMPANY_ID option[value='TSTO']").remove();
            } */

            var empnumber = document.getElementById('emp_number').value ;
            var requestURL = document.getElementById('requestURL').value ;
            var reqSysType = document.getElementById('reqSysType').value ;
            var reqCpny = document.getElementById('reqCpny').value ;
            var reqRole = document.getElementById('reqRole').value ;
            var reqLanguage = document.getElementById('reqLanguage').value ;

            /*设置如果没有传入语言的默认韩语*/
            if(reqLanguage == null || reqLanguage == ""){
            	reqLanguage = 'ko';
            }
            
            //if(empnumber != 'null' && requestURL.indexOf( 'hanwha.eagleoffice.co')!=-1){
            if(empnumber != 'null' && ( requestURL.indexOf( '118.190.89.40')!=-1 || requestURL.indexOf( 'hanwha.eagleoffice.co')!=-1)){

                document.getElementById('username').value = empnumber;
                document.getElementById('username').readOnly = true;
                document.getElementById('password').value = empnumber;
                document.getElementById('password').readOnly = true;
                $('#sysType').attr('value', reqSysType);
                document.getElementById('sysType').disabled = true;
                $('#language').attr('value', reqLanguage);
                document.getElementById('language').disabled = true;
                document.getElementById('COMPANY_ID').value = reqCpny;
                //$('#COMPANY_ID').attr('value', reqCpny);
                //document.getElementById('COMPANY_ID').disabled = true;
                document.getElementById("btn").style.display='none';
                
                var locale_cookie = "";
                if (reqLanguage == 'zh') {
                    locale_cookie = "zh_CN";
                } else if (reqLanguage == 'vi') {
                    locale_cookie = "vi_VN";
                } else if (reqLanguage == 'en') {
                    locale_cookie = "en_US";
                } else {
                    locale_cookie = "ko_KR";
                }
                
                var mess = check();
                if (flag == 1 && mess == null && reqSysType != 'null'&& reqCpny != 'null') {
                    $("#Tip").text("Loading...");
                    var options = {
                        url: '/login/in?loginType=sso&reqSysType='+reqSysType+'&reqCpny='+reqCpny+'&checkHubByIP=N&reqLanguage='+reqLanguage+'&locale='+locale_cookie,
                        type: 'POST',
                        success: function(responseText) {
                            if (responseText == "1") {
                                if(reqSysType == 'Hub'){
                                    location.href = "/login/home.do";
                                }else{
                                    location.href = "/login/home_partner.do?reqRole="+reqRole;
                                }
                            } else{
                                $("#Tip").text('loginFail');
                                document.getElementById('username').readOnly = false;
                                document.getElementById('password').readOnly = false;
                                document.getElementById('sysType').disabled = false;
                                document.getElementById('language').disabled = false;
                                //document.getElementById('COMPANY_ID').disabled = false;
                                document.getElementById("btn").style.display='block';
                            }
                        }
                    };
                    $('#loginForm').ajaxSubmit(options);
                    return true;
                }else{
                    $("#Tip").text('loginFail');
                    document.getElementById('username').readOnly = false;
                    document.getElementById('password').readOnly = false;
                    document.getElementById('language').disabled = false;
                    document.getElementById('sysType').disabled = false;
                    //document.getElementById('COMPANY_ID').disabled = false;
                    document.getElementById("btn").style.display='block';
                    return false;
                }
            }

            try{
                var arrCookie = document.cookie.split(';');

                var userId = '';
                //var company = '';
                var sysType = '';
                var language = '';
                var arrCookie2=null;
                if(arrCookie != null){
                    //alert(arrCookie.toString());
                    for(var j=0;j<arrCookie.length;j++){
                        arrCookie2 = arrCookie[j].split(",");
                        for(var i=0;i<arrCookie2.length;i++){
                            var arr=arrCookie2[i].split("=");
                            //alert(arr[0]);
                            //alert(arr[1]);
                            if(arr[0].indexOf("sysAdmin.account") != -1){
                                userId=arr[1];
                            }

                            /* if(arr[0].indexOf("sysAdmin.company") != -1){
                                company=arr[1];
                            } */

                            if(arr[0].indexOf("sysAdmin.sysType") != -1){
                                sysType=arr[1];
                            }

                            if(arr[0].indexOf("language_cookie") != -1){
                                language=arr[1];
                            }
                        }
                    }
                }
                document.getElementById('language').value = language;
                //document.getElementById('COMPANY_ID').value = company;
                document.getElementById('username').value = userId;
                document.getElementById('saveBox').checked = true;
                document.getElementById('sysType').value = sysType==''?'Partner': sysType;

                /*if(document.getElementById('sysType').value == 'Hub')
                    $('#login_type_text').html('HR');
                else
                    $('#login_type_text').html('ESS');*/

                if(document.getElementById('sysType').value == 'Hub'){
                    $('#ko').hide();
                }else{
                    $('#ko').show();
                }

            }catch(e){

            }
            if(userId==''){
                document.getElementById('username').focus();
            }else{
                document.getElementById('password').focus();
            }

        });

        $(document).ready(function(){
            $('#btn').click(function() {
                //var arrCookie = document.cookie;

                /* if(!canSubmit){
                    alert('该系统只支持IE浏览器，请使用IE浏览器进行访问，对此带来的不便，我们深表歉意！！');
                    return;
                } */
                var mess = check();
                var language = document
                    .getElementById('language').value;
                if (flag == 1 && mess == null) {
                    var locale_cookie = "";
                    if (language == 'zh') {
                        locale_cookie = "zh_CN";
                    } else if (language == 'vi') {
                        locale_cookie = "vi_VN";
                    } else if (language == 'en') {
                        locale_cookie = "en_US";
                    } else {
                        locale_cookie = "ko_KR";
                    }
                    $("#Tip").text("Loading...");
                    var options = {
                        url : '/login/in?locale='
                        + locale_cookie
                        + '&language='
                        + language
                        + '&checkHubByIP=N',
                        type : 'POST',
                        success : function(responseText) {
                            if (responseText == "1") {
                                //保存cookie
                                var date = new Date();
                                var checkb = document.getElementById('saveBox');
                                if (checkb.checked) {
                                    date.setTime(date.getTime() + 365 * 24 * 3600 * 1000);
                                } else {
                                    date.setTime(date.getTime() - 1000);
                                }

                                document.cookie = 'sysAdmin.account='
                                    + escape(document.getElementById('username').value)
                                    //+ ',sysAdmin.company1='
                                    //+ escape(document.getElementById('COMPANY_ID').value)
                                    + ',sysAdmin.sysType='
                                    + escape(document.getElementById('sysType').value)
                                    + ',language_cookie='
                                    + escape(document.getElementById('language').value)
                                    + ',locale_cookie='
                                    + escape(locale_cookie)
                                    + ';expires='
                                    + date.toGMTString()
                                    + ';path=/';

                                if ($("#sysType").val() == 'Hub') {
                                    location.href = "/login/home.do";
                                } else {
                                    location.href = "/login/home_partner.do";
                                }

                            } else {
                                $('#Tip').html(responseText);
                            }
                        }
                    };
                    $('#loginForm').ajaxSubmit(options);
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
            var sysType = $("#sysType").val();
            var language = $("#language").val();

            var msg = null;

            if (company == '') {
                msg = 'please choose company';
            } else if (sysType == '') {
                msg = 'please choose system';
            } else if (language == '') {
                msg = 'please choose language';
            } else {
                if (u.replace(/(^\s*)|(\s*$)/g, "").length == 0)
                    if (p.replace(/(^\s*)|(\s*$)/g, "").length == 0)
                        msg = 'ID and PASSWORD must input.';
                    else
                        msg = 'ID must input.';
                else if (p.replace(/(^\s*)|(\s*$)/g, "").length == 0)
                    msg = 'PASSWORD must input.';
            }

            return msg;
        }

        $(document).ready(function() {
            /*ESS比Hub多一种语言限定 */
            $('#sysType').change(function(){
                if ($(this).val() == "Hub") {
                    $('#ko').hide();
                    if ($('#language').val() == 'ko') {
                        $('#chooseLanguage').attr("selected", true);
                    }
                } else {
                    $('#ko').show();
                }
            });
        });

        $(document).ready(function() {
            /*slo登陆方式*/
            var requestURL = document.getElementById('requestURL').value ;
            var sloCpny = document.getElementById('COMPANY_ID').value ;
            var sloLanguage = document.getElementById('language').value ;
            var slo_p_ota = document.getElementById('slo_p_ota').value;
            
            if(requestURL.indexOf( 'hanwha.eagleoffice.co')!=-1){   //只有通过链接的方式，并且为eagleoffice的跳转才处理 
            	if("<%=otaId%>" == "" || "<%=otaId%>" == "null"){
    				var eagleOfficeUrl = "http://ci.eagleofice.co.kr/api/branch/common/slo/goSloTarget.mvc?authType=2&destination=";
    								   //"http://hanwha.eagleofice.co.kr/api/branch/common/slo/goSloTarget.mvc?authType=2&destination=";
    				var strURL = window.location.href;
    				var targetUrl = eagleOfficeUrl + strURL;
    				window.location.href = targetUrl;
    			}else{
    				if (flag == 1) {

    					document.getElementById('username').readOnly = true;
    					document.getElementById('password').readOnly = true;
    					document.getElementById('sysType').disabled = true;
    					document.getElementById('language').disabled = true;
    					document.getElementById("btn").style.display='none';
						
    					if(sloLanguage == null || sloLanguage == ""){
    						sloLanguage = 'vi';
        				}
    	                
    	                var locale_cookie = "";
    	                if (sloLanguage == 'zh') {
    	                    locale_cookie = "zh_CN";
    	                } else if (sloLanguage == 'vi') {
    	                    locale_cookie = "vi_VN";
    	                } else if (sloLanguage == 'en') {
    	                    locale_cookie = "en_US";
    	                } else {
    	                    locale_cookie = "ko_KR";
    	                }
        				
                        $("#Tip").text("Loading...");
                        var options = {
                            url: '/login/sloLogin?loginType=slo&slo_p_ota='+slo_p_ota+'&sloLanguage='+sloLanguage+'&locale='+locale_cookie,
                            type: 'POST',
                            success: function(responseText) {
                                if (responseText == "1") {
                                    location.href = "/login/home.do";
                                }else if(responseText == "2"){
                                	location.href = "/login/home_partner.do";
                                } else{
                                    $("#Tip").text('loginFail');
                                    document.getElementById('username').readOnly = false;
                                    document.getElementById('password').readOnly = false;
                                    document.getElementById('sysType').disabled = false;
                                    document.getElementById('language').disabled = false;
                                    document.getElementById("btn").style.display='block';
                                }
                            }
                        };
                        $('#loginForm').ajaxSubmit(options);
                        return true;
                    }else{
                        $("#Tip").text('loginFail');
                        document.getElementById('username').readOnly = false;
                        document.getElementById('password').readOnly = false;
                        document.getElementById('language').disabled = false;
                        document.getElementById('sysType').disabled = false;
                        document.getElementById("btn").style.display='block';
                        return false;
                    }
    			}
            }
			
        });
    </script>

    <style type="text/css">
        .Sign_select_right{ float:right; width:200px; height:30px; line-height:30px; border:1px solid #dbd9da;box-shadow:3px 3px 3px #dddddd inset; padding-left:0px}
    </style>

</head>

<body style="background:#fff">
<div class="Sign_top fix">
    <a href="#"><img src="/resources/images/Sign_bt.png"/></a>
</div>
<!--Sign-->
<div class="Sign fix">
    <div class="Sign_cn fix">
        <div class="Sign_bg"><img src="/resources/images/Sign_bg_2.jpg"/></div>
        <div class="Sign_nr">
            <div class="Sign_bt fix"><img src="/resources/images/Sign_bt.png"/></div>
            <form class="Sign_form fix" id="loginForm" onkeydown="if(event.keyCode==13) $('#btn').click();" method="post">
                <div class="Sign_bl fix">
                    <i><img src="/resources/images/Sign_tb1.png"/></i>
                    <input type="text" class="Sign_text" name="username" id="username"/>
                </div>
                <div class="Sign_bl fix">
                    <i><img src="/resources/images/Sign_tb2.png"/></i>
                    <input  type="password" class="Sign_password" name="password" id="password"/>
                    <input id="emp_number" name="emp_number" type="hidden" value="null">
                    <input id="requestURL"  type="hidden" value="<%=requestURL%>">
                    <input id="reqSysType"  type="hidden" value="null">
                    <input id="reqCpny"  type="hidden" value="null">
                    <input id="reqRole"  type="hidden" value="null">
                    <input id="reqLanguage"  type="hidden" value="null">
                    <input id="slo_p_ota"  type="hidden" value="<%=otaId%>">
                    <input id="slo_p_sv"  type="hidden" value="<%=wsSt%>">
                </div>
                <div class="Sign_bl1 fix">

                </div>
                <div class="Sign_bl1 fix">
                    <select class="Sign_select" id="sysType" name="sysType">
                        <option id="chooseSystem" value="">* Choose system *</option>
                        <option value="Hub"> Hub </option>
                        <option value="Partner"> ESS </option>
                    </select>
                    <select class="Sign_select_right" id="language" name="language">
                        <option id="chooseLanguage" value="">* Choose language *</option>
                        <!-- <option id="zh" value="zh">Chinese</option> -->
                        <option id="ko" value="ko">Korean</option>
                        <option id="vi" value="vi">Vietnamese</option>
                        <option id="en" value="en">English</option>
                    </select>
                </div>
                <div class="Sign_bl1 fix" style="margin-top:10px">
                    <!--<font size=2 color=red style="padding-top:10px"><span id="Tip"></span></font>-->
                    <!-- <select class="Sign_select" id="COMPANY_ID" name="COMPANY_ID">
                        <option value="">* Choose Company *</option>
                        <option value="HTSV">* HTSV *</option>
                        <option value="HAE">* HAE *</option>
                    </select> -->
                    <!--不需要选择法人,隐藏域-->
                    <!-- <input type="hidden" id="COMPANY_ID" name="COMPANY_ID" value="HTSV"/> -->
                    <input type="hidden" id="COMPANY_ID" name="COMPANY_ID" value="HAE"/>
                    <div class="Sign_xz" >
                        <input type="checkbox" id="saveBox" class="Sign_checkbox" />
                        <a href="#">Save ID</a>
                    </div>
                </div>
                <div class="Sign_bl1 fix" style="height:10px;margin-top:10px">
                    <font size=2 color=red style=""><span id="Tip"></span></font>
                </div>
                <div class="Sign_tj fix">
                    <input type="button" class="Sign_submit" value="LOGIN" id="btn"/>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
