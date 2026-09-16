<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="../inc/initTaglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>AIT HRS ESS</title><!-- 【${LOGIN_CPNY}】 -->
<link href="/resources/css/dwzUI/core.css" rel="stylesheet" type="text/css" />

<link href="/resources/js/uploadify/css/uploadify.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />

<link href="/resources/css/ztree/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/dwzUI/themes/partner/style.css" rel="stylesheet" type="text/css" />

<!--[if IE]>
<link href="/resources/css/dwzUI/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
<![endif]-->

<!--[if lte IE 9]>
<script src="/resources/js/dwzUI/speedup.js" type="text/javascript"></script>
<![endif]-->

<!-- jquery -->
<script src="/resources/js/jquery/jquery.all.js" type="text/javascript"></script>
<script src="/resources/js/util/StringUtil.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.validate.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.bgiframe.js" type="text/javascript"></script>
<script src="/resources/js/uploadify/scripts/jquery.uploadify.js" type="text/javascript"></script>
<script src="/resources/css/dwzUI/themes/partner/js/bootstrap.min.js" type="text/javascript"></script>

<script src="/resources/js/xheditor/xheditor-1.1.9-en.min.js" type="text/javascript"></script>

<!-- ztree -->
<script src="/resources/js/ztree/jquery.ztree.all-3.1.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.core.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.util.date.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.validate.method.js" type="text/javascript"></script>

<script src="/resources/js/dwzUI/source/dwz.barDrag.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.drag.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.tree.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.accordion.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.ui.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.theme.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.switchEnv.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.alertMsg.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.contextmenu.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.navTab.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.tab.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.resize.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.dialog.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.dialogDrag.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.cssTable.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.stable.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.taskBar.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.ajax.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.pagination.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.database.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.datepicker.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.effects.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.panel.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.checkbox.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.history.js" type="text/javascript"></script>
<script src="/resources/js/dwzUI/source/dwz.combox.js" type="text/javascript"></script>

<!--
<script src="/resources/js/dwzUI/dwz.min.js" type="text/javascript"></script>
-->

<script src="/resources/js/dwzUI/dwz.regional.zh.js" type="text/javascript"></script>

<!-- ligerUI -->
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>

<script src="/resources/js/meizzDate.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.treeTable.js" type="text/javascript"></script>
<!-- <script src="/resources/js/jquery/jquery.dataTables.min.js" type="text/javascript"></script> -->
<script src="/resources/js/jquery/sortable_table.js" type="text/javascript"></script>
<script src="/resources/js/jquery/fixed_table_rc.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.jeditable.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.jqprint-0.3.js" type="text/javascript"></script>
<script src="/resources/js/togglebar.js" type="text/javascript"></script>

<link href="/resources/dataTables/css/dataTables.jqueryui.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/dataTables/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/dataTables/css/scroller.dataTables.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/dataTables/css/fixedColumns.dataTables.min.css" rel="stylesheet" type="text/css" />
<script src="/resources/dataTables/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="/resources/dataTables/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="/resources/dataTables/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="/resources/dataTables/js/dataTables.scroller.min.js" type="text/javascript"></script>
<script src="/resources/dataTables/js/dataTables.fixedColumns.min.js" type="text/javascript"></script>
<script src="/resources/dataTables/js/dataTables.order.js" type="text/javascript"></script>
<style>
      .addselect {
          border-radius: 2px;
          display: inline-block;
          background-color: #ccc;
          height: 12px;
          width: 12px;
          text-align: center;
          color: #fff;
          font-size: 9px;
          font-family: Arial;
          position: relative;
          margin-left: 4px;
          cursor: pointer;
          overflow: hidden;
          vertical-align: top;
          top: 1px;
      }
      .addselect select {
          width: 44px;
          opacity: 0;
          position: absolute;
          left: 0;
          top: 0;
          cursor: pointer;
      }
</style>
<script>
    $(function () {
//        2018-3-19 add
        var right=$('#container').height();
        var left=$('#leftside');
        left.css({
            height:right+15,
            background:'#f3f3f3'
        });
        //左侧伸缩导航
        $('.nav-item>a').on('click', function () {
            //console.log('----');
            if (!$('.nav').hasClass('nav-mini')) {
                if ($(this).next().css('display') == "none") {

                    $('.nav-item').children('ul').slideUp(300);
                    $(this).next('ul').slideDown(300);
                    $(this).parent('li').addClass('nav-show').siblings('li').removeClass('nav-show');
                } else {

                    $(this).next('ul').slideUp(300);
                    $('.nav-item.nav-show').removeClass('nav-show');
                }
            }
        });
        //顶部导航
        $('#nav_all>li').mouseenter(function () {
            $(this).find('ul').stop(false, true).slideDown(180);
        }).mouseleave(function () {
            $(this).find('ul').stop(false, true).slideUp(180);
        });

    })

</script>
<script type="text/javascript">
$(function(){
	DWZ.init("/resources/dwz.frag.xml", {
		loginUrl:"login_dialog.html", loginTitle:"登录",	// 弹出登录对话框
//		loginUrl:"login.html",	// 跳到登录页面
		statusCode:{ok:200, error:300, timeout:301}, //【可选】
		pageInfo:{pageNum:"pageNum", numPerPage:"numPerPage", orderField:"orderField", orderDirection:"orderDirection"}, //【可选】
		debug:false,	// 调试模式 【true|false】
		callback:function(){
			initEnv();
			$("#themeList").theme({themeBase:"/resources/css/dwzUI/themes"}); // themeBase 相对于index页面的主题base路径
		}
	});
});
function menuControl(menu_code,menu_name,child_menu_code){
	$.each($("#navMenu_MyHome ul li"), function(i,val){  
		$(val).removeClass();    
		$(val).addClass("noselected");
	}); 

	$("#nav_"+menu_code).removeClass("noselected");
	$("#nav_"+menu_code).addClass("selected");
	
	$('.nav .nav-item .child').hide();
    $('#nav_item_' + menu_code + ' .child').show();
    $('.nav .nav-item .child li a span').css('color','#666666');
    $('#child_' + child_menu_code + ' a span').css('color','#ff0000');
		
	//var viewMenu = document.getElementById("view_"+menu_code);
	//viewMenu.style.display = "block";
	//$("#maincoll h2").text(menu_name);
//	$("#maincoll div").
	//$("#maincoll .toggleCollapse div").trigger("click");
	
	
}

function alertMsgControl(alertID){
	var idLength=alertID.length;
	$.each($("#main_top_nav_id ul li"), function(i,val){  
		$(val).removeClass();    
		$(val).addClass("main_top_nav_off");
		document.getElementById(alertID.substring(0,idLength-1)+(i+1)+"_content").style.display = "none";
	});
	document.getElementById(alertID+"_content").style.display = "";
	$("#"+alertID).removeClass("main_top_nav_off");
	$("#"+alertID).addClass("main_top_nav_on");
}
/*
function for HR
*/


var hrTheTypeJosn = { "hr0210": "transferOrder",
					  "hr0202": "upGrade",
					  "hr0211": "transferPromote",
					  "hr0204": "plurality",
					  "hr0203": "suspend",
					  "hr0209": "hortation",
					  "hr0208": "punishMent",
					  "hr0206": "resign",
					  "hr0214": "payrise",
					  "hr0216": "agent"
					  
} ;

var hrSaveUrlJosn = { "hr0210": "/hrm/transferOrder/viewTransferNormal",
					  "hr0202": "/hrm/transferOrder/viewUpgrade",
					  "hr0211": "/hrm/transferOrder/viewTransferPromote",
					  "hr0204": "/hrm/transferOrder/viewPlurality",
					  "hr0203": "/hrm/transferOrder/viewSuspend",
					  "hr0209": "/hrm/transferOrder/viewHortation",
					  "hr0208": "/hrm/transferOrder/viewPunishMent",
					  "hr0206": "/hrm/transferOrder/viewResign",
					  "hr0214": "/hrm/transferOrder/viewPayrise",
					  "hr0216": "/hrm/transferOrder/viewAgent"
					  
} ; 



function showSearch(navTabId){
	var theType = hrTheTypeJosn[navTabId] ;
	document.getElementById("searchEmp").href = "/hrm/transferOrder/viewEmpSearchList?pageNum=1&navTabId=" +navTabId + "&theType=" + theType;
	document.getElementById("searchEmp").click();
}


function validateCallbackEmpSearch(navTabId) {	
	
	var eids = $("#searchForm").find("input[name='eidsForSearch']").val(); 
	//var url = "/hrm/transferOrder/viewTransferNormal?eids="+eids+"&&pageNum=1&&navTabId=" + navTabId;
	var url = hrSaveUrlJosn[navTabId]+ "?eids=" + eids + "&&pageNum=1&&navTabId=" + navTabId;
	dialogAjaxDone({
			"statusCode":"200", 
			"forwardUrl":url, 
			"navTabId": navTabId
    });
	return false ;
}


var hrUrlJosn = { "hr0101": "/hrm/empinfo/viewPersonalInfo","hr0102": "/hrm/empinfo/viewPromote","hr0103": "/hrm/empinfo/viewEvaluate",
				  "hr0104": "/hrm/empinfo/viewReward","hr0105": "/hrm/empinfo/viewTranslate","hr0106": "/hrm/empinfo/viewTraining",
				  "hr0107": "/hrm/empinfo/viewRelation","hr0108": "/hrm/empinfo/viewHealth","hr0109": "/hrm/empinfo/viewWorkInfo",
				  "hr0110": "/hrm/empinfo/viewAdditional","hr0112": "/hrm/empinfo/viewAccount","hr0111": "/hrm/empinfo/viewCompetence",
				  "hr0114": "/hrm/empinfo/viewContract","hr0115": "/hrm/empinfo/viewGoAbroad","hr0116": "/hrm/empinfo/viewCredential" } ;

function F_HR_ShowMore(obj, navTabId){
		var turn_to_url = hrUrlJosn[navTabId] ;

		if(turn_to_url.length > 0){
			dialogAjaxDone(
	   	    	{
	   	    		"statusCode":"200", 
					"forwardUrl":turn_to_url + "?navTabId=" + navTabId + "&PERSON_ID=" + obj, 
					"navTabId":navTabId
	   	    	}
	   	    ) ;
	   }
	}

function F_HR_SubmitKeyClick(empid,localName,idcardNo,navTabId){
	
   	if(event.keyCode==13){
   		
		var turn_to_url = hrUrlJosn[navTabId] ;
   		$.ajax({
			type: 'POST',
			url: encodeURI('/hrm/empinfo/getPersonCnt?navTabId=' + navTabId + '&EMPID='+empid+'&LOCAL_NAME='+localName+'&IDCARD_NO='+idcardNo+'&EMP_OFFICE=15119'),//15119设置默认查找在职员工
			dataType:"json",
			cache: false,
			success: function(jsonObject){
					
						if (jsonObject.perCnt==0){
							alert("<spring:message code='alert.message.noBody'/>");
						}
						
						if(jsonObject.perCnt>1 ){
							//15119设置默认查找在职员工
							document.getElementById("onck").href=encodeURI(encodeURI("/hrm/empinfo/viewEmpIdList?pageNum=1&navTabId=" + navTabId + "&seach_EMPID="+empid+'&seach_LOCAL_NAME='+localName+'&seach_IDCARD_NO='+idcardNo+'&seach_EMP_OFFICE=15119' ));
						
							document.getElementById("onck").click();
							
						}
						
						if(jsonObject.perCnt==1){
							
							 navTabAjaxDone(
				    	    	{
				    	    		"statusCode":"200", 
									"forwardUrl":turn_to_url + "?navTabId=" + navTabId + "&PERSON_ID=" + jsonObject.personId, 
									"callbackType":"forward"
				    	    	}
				    	    ) ;
						}
					},
			error: DWZ.ajaxError
		});
    }
 }
 
 
function seachByDept(navTabId){
	document.getElementById("onck").href = "/hrm/empinfo/viewEmpIdList?pageNum=1&navTabId="+navTabId;
	document.getElementById("onck").click();
}
 
function changeLanguage(flag){
	if(flag == 'zh'){
		$.ajax({
	 		type:'GET',
	 		url:"/login/changeLanguage?language="+flag,
	 		cache: false,
	 		success: location.reload()
	 		 
	 	});
	}else{
		alert("<spring:message code='sys.homePartner.ZANBUZHICHIGUOJIHUA.b'/>");//暂不支持国际化！
		return;
	}
}

function changeLanguage(flag){
    var temp="";
    if(flag=='zh'){
    	temp='zh_CN';
    }else if(flag=='en'){
        temp='en_US'; 
    }else if(flag=='ko'){ 
    	temp='ko_KR'; 
    }else{
    	temp='vi_VN'; 
    }
 $.cookie('language_cookie',flag ,{expires:365,path:'/'});  
 $.cookie('locale_cookie',temp ,{expires:365,path:'/'});  

 $("#tabsPageHeaderContent li").each(function (i) {
 	if("selected"==$(this).attr("class").replace(/^\s+|\s+$/g, "")){
 		//alert($(this).attr("url"));
 		var url=decodeURIComponent($(this).attr("url"));
 		$.cookie('openUrl',url);
 	}
 }); 
  $.ajax({
		type:'GET',
		url:"/login/changeLanguage?language="+flag+"&locale="+temp,
		cache: false,
		async:false,
		success: location.reload()
	});

}

 var i  = 1;//定义一个全局变量 ，控制下拉收回。
function showUL(liID){
		if( i==0 )
		{
		$("#quick_menu_${defaultRoleGroupName } .ulss").slideUp();	
		$("#showUL"+liID).slideDown("slow");
			i=1;
		}else{
			$("#quick_menu_${defaultRoleGroupName } .ulss").slideUp();	
		i=0;
  	  }
}
$(document).bind("click",function(e){ 
    var target  = $(e.target); 
    if(target.closest("#manual_button").length == 0){ 
        $("#manual_info #manual").slideUp();
    } 
    else 
    { 
        $("#manual_info #manual").slideDown();	 
    } 
	//待裁决下拉框
    if(target.closest("#tab4_viewInfo").length == 0){ 
        $("#quick_menu_${defaultRoleGroupName } .ulss").slideUp();
    } 
    else 
    { 
        $("#quick_menu_${defaultRoleGroupName } .ulss").slideDown();	 
    } 
	//语言选择下拉框
    if(target.closest("#Language_button").length == 0){ 
        $("#Language_info #Language_ul").slideUp();
    } 
    else 
    { 
        $("#Language_info #Language_ul").slideDown();	 
    } 
	//角色选择下拉框
    if(target.closest("#roleGroup_button").length == 0){ 
        $("#roleGroup_info #roleGroup_ul").slideUp();
    } 
    else 
    { 
        $("#roleGroup_info #roleGroup_ul").slideDown();	
    } 
});


$(window).load(function () {
	  
var quick_width = $("#quick_menu_${defaultRoleGroupName }").width();
var quick_height = $("#quick_menu_${defaultRoleGroupName }").height();
var quick_right = 10 - $("#quick_menu_${defaultRoleGroupName }").width();
$("#quick_menu_${defaultRoleGroupName }").css({right:0});
<c:if test="${tipsMap.total_count_viewInfo le 0}">
$("#quick_menu_${defaultRoleGroupName }").show();
$("#quick_menu_${defaultRoleGroupName } ul li").hide();
$("#quick_menu_${defaultRoleGroupName } ul li ul").hide();
</c:if>
<c:if test="${tipsMap.total_count_viewInfo gt 0}">
$("#quick_menu_${defaultRoleGroupName }").show();
$("#quick_menu_${defaultRoleGroupName } ul li").show();
$("#quick_menu_${defaultRoleGroupName } ul li ul").show();
</c:if>
	$("#quick_menu_${defaultRoleGroupName } ul span").toggle(
      function () {
       getTips();
       $("#quick_menu_${defaultRoleGroupName } ul li").fadeOut();
       $("#quick_menu_${defaultRoleGroupName }").animate({
    			right: 0
 			}, 500, function() {
 				$("#quick_menu_${defaultRoleGroupName } ul span").removeClass();
   				$("#quick_menu_${defaultRoleGroupName } ul span").addClass("show");				 			 
  			});
      },
      function () {
        //初始化提示信息
     
      	$("#quick_menu_${defaultRoleGroupName } ul li ul").slideUp();
 		$("#quick_menu_${defaultRoleGroupName } ul li").fadeIn();
        $("#quick_menu_${defaultRoleGroupName }").animate({
    			right: 0
 			}, 500, function() { 				
 				$("#quick_menu_${defaultRoleGroupName } ul span").removeClass();
   				$("#quick_menu_${defaultRoleGroupName } ul span").addClass("hide");
  			});
      }
    );
	
    if($("#qMenuHideFlag").val() == "show"){
    	// show 인 경우(결재건수가 한건이라도 있는 경우)는 퀵메뉴를 클릭해준다.
    	setTimeout(function(){
    	      $("#quick_menu_${defaultRoleGroupName } ul span").trigger("click");
    	 },1000);
    }
    $("#showUL4").blur(function(){
    	$("#showUL4").slideUp();
  	});
});


<c:if test="${LoginUser.isDob eq '1'}">
$(function(){
	setTimeout(function(){
		$.pdialog.open("/login/manualWindow", "manualWindow", "<spring:message code='sys.homePartner.happyBirthday.b'/>", {width:400,height:235,mask:true});//生日快乐
		},"2000");
});
</c:if>

<c:if test="${empty LoginUser.personalDataConfirmBy}">
$(function(){
	setTimeout(function(){
		$.pdialog.open("/login/viewPersonalDataConfirm", "personalDataConfirm", "Phiếu đồng ý xử lý dữ liệu cá nhân", {
			width:800, height:640, mask:true, resizable:false, drawable:false, maxable:false, minable:false,
			close:function(){ location.href = "/login/out"; return false; }
		});
		},"2000");
});
</c:if>
function getTips(){
	$.ajaxSettings.global=false;
	$.ajax({
    	type:'get',
    	cache:false,
    	contentType:'application/json',	            			            	
    	url:'/myhome/getTips',            	
    	dataType:'json',
    	success:function(data){
    		getTipsAfter(data);
    		if(data.total_count_viewInfo>0){
	    		$("#quick_menu_${defaultRoleGroupName }").show();
	    		$("#quick_menu_${defaultRoleGroupName } ul li").show();
	    		$("#quick_menu_${defaultRoleGroupName } ul li ul").show();
    		}
    	}        	           	
	});
	$.ajaxSettings.global=true;
}

function getTipsAfter(data){
        $("#tab4_viewInfo a b").html(data.total_count_viewInfo);
        if(typeof (data['ess0601']) != "undefined"){
            $("#tab4 #showUL4 #tab4_viewInfo_1 a b").html(data.ess0601);
        }
        <c:if test="${LoginUser.cpnyId eq 'HTSV' or LoginUser.cpnyId eq 'HAE' or LoginUser.cpnyId eq 'SPC_DL'}">
		if(typeof (data['ess3436']) != "undefined"){
            $("#tab4 #showUL4 #tab4_viewInfo_2 a b").html(data.ess3436);
        }
		</c:if>
        <c:if test="${LoginUser.cpnyId eq 'SPC_SH' or LoginUser.cpnyId eq 'SPC_NJ' or LoginUser.cpnyId eq 'SPC_HZ'}">
		if(typeof (data['ess3438']) != "undefined"){
            $("#tab4 #showUL4 #tab4_viewInfo_2 a b").html(data.ess3438);
        }
		</c:if>
		if(typeof (data['ess3444']) != "undefined"){
            $("#tab4 #showUL4 #tab4_viewInfo_3 a b").html(data.ess3444);
        } 
		
}

$(function(){
    //refresh approval count! //300초(1000 * 5 * 60) =>5분 
    //setInterval("getTips()",1000 * 1 * 60);
});

var iapp=0;
function checkApprovalCount(){
    if(iapp==0){
       // alert("here & qMenuHideFlag:::" + parent.document.getElementById("qMenuHideFlag").value);
        var data = getTips();
       // alert("data:::"+data);
        parent.document.getTipsAfter(data);
        iapp=1;
    }
}

function goTab(menuCode,menuNo,menuUrl){
	
}

function openNavTab(url){
	
	if($("#esstransform").val()!="0000"){
		$("#maincoll h2").text($("#esstransform").val());
		}
	var a=url.indexOf("&");
	var b=url.lastIndexOf("&");
	var title_name=url.substring(a+1,b);
	var title="";
	var menu_code="";
	var menu_name="";
	$.ajax({
    	type:"post",
    	cache:false,     			            	
    	url:'/login/titleNamePartner',            	
    	data:title_name,
    	dataType:"json",
    	async:false,
    	success:function(data){
			title=data.TATLENAME,
			menu_code=data.MENU_CODE,
			menu_name=data.MENU_NAME
		}
    	});
	navTab.init();
	navTab.openTab("open_Id",url,{title:title,frech:true,date:{}});
	$.cookie('openUrl',null);
	if(typeof(menu_code)!="undefined" && typeof(menu_name)!="undefined" && menu_code!="" && menu_name!=""){
	$("#maincoll h2").text(menu_name);
	menuControl(menu_code,menu_name,'');}
}
$(document).ready(function(){
	//navTab.openTab(tabid,url)
		if($.cookie('openUrl')!=null){
			openNavTab($.cookie('openUrl'));
		}
	
	});

	//navTab 最多可以打开10个
function navTabNum(url,param,menuCode,name){
	var num=0;
		$(".navTab-tab li[tabid]").each(function(){
			if($(this).attr("tabid")!=menuCode){
				num++;
			}
		});
		
		//alert(url);
	if(num>=12){
		//alert("最多只能打开10个选项卡");
		//alertMsg.info("最多只能打开10个选项卡");
		alertMsg.info("<spring:message code='liang.alert.message.maximumtTenTab'/>");
		return false;
	}else{
		if(url.indexOf(',')!=-1){
			var targets = url.split(',');
			if(targets[1]=='_blank'){
				window.open(targets[0]);
				return;
			}
		}else
			$("#home_open").attr("target",'navTab');
		if(url.indexOf('?')!=-1)
			url+='&'+param;
		else
			url+='?'+param;
		$("#home_open").attr("href",url);
		$("#home_open").attr("rel",menuCode);
		$("#home_open").text(name);
		$("#home_open").click();
	}
}

function changeCpny(id){
	  
	 $.ajax({
			type:'GET',
			url:'/login/changeCpny?cpny_id='+id,
			cache: false,
			async:false,
			success: location.reload()
		});
}

function openOnRight(url,relId){
	$("#right_open").attr("href",url);
	$("#right_open").attr("rel",relId);
	$("#right_open").click();
}
function changeRoleGroup(){
	var tempUrl = $('#roleGroupSelect').val();
	location.href = tempUrl ;
}
function logoutComfirm(){
	if(confirm('Are You Sure To Logout?')){
		location.href = '/login/out' ;
	}
}

</script>
</head>

<body >
<div style="display:none;">
<a id="home_open" target="navTab" style="visibility:hidden"></a>
<a id="right_open" target="ajax" rel="" style="visibility:hidden"></a>
</div>
	<div id="layout">
		<div id="header">
		<div class="logo"></div>
			<div class="headerNav">
            <ul class="nav_MyHome __new_nav">
					<%-- <li class="personnel_info">
					<!--欢迎--><spring:message code="sys.homePartner.HUANYING.b"/>&nbsp;&nbsp;&nbsp;&nbsp;[${LoginUser.empID }]${LoginUser.localName}&nbsp;&nbsp;&nbsp;&nbsp;${LoginUser.content}
					</li>
					<li id="roleGroup_info" class="personnel_info">
						<a style="text-decoration:none ;" id="roleGroup_button">${defaultRoleGroupNameDis }</a>
						<ul id="roleGroup_ul" style="background-image: url(/resources/css/dwzUI/themes/partner/images/top/info_${defaultRoleGroupName }.png);background-repeat: no-repeat;background-position: left bottom;">
						<ul id="roleGroup_ul" style="background-image: url(/resources/css/dwzUI/themes/partner/images/top/info_MyHome.png);background-repeat: no-repeat;background-position: left bottom;">
							<c:forEach var="roleGroupInfo" items="${roleGroupList}" varStatus="i">
								<li>
                                	<a style="text-decoration:none ;" href="/login/home_partner.do?defaultRoleGroupId=${roleGroupInfo.ROLE_GROUP_ID }&defaultRoleGroupName=${roleGroupInfo.ROLE_GROUP_ENG_NAME}&defaultRoleGroupNameDis=${roleGroupInfo.ROLE_GROUP_NAME }">${roleGroupInfo.ROLE_GROUP_NAME }</a>
                            	</li>
							</c:forEach>
						</ul>
					</li> --%>
					<li id="manual_info" class="personnel_info">
						<a style="text-decoration:none ;" id="manual_button"><!--用户手册下载--><spring:message code="sys.mainHub.YONGHUSHOUCEXIAZAI.b"/></a>
						<ul id="manual" style="width:165px;background-image: url(/resources/css/dwzUI/themes/partner/images/top/info_MyHome.png);background-repeat: no-repeat;background-position: left bottom;">
		                    <c:if test="${defaultRoleGroupName == 'MyHome' }">
			                    <li style="width:165px;">
			                    	 <a style="text-decoration:none ;width:145px;" href="/ess/infoApplyLeave/downloadFile?fileName=/resources/manual/${LoginUser.cpnyId }/${LoginUser.cpnyId }-Module-ESS-MyHome-Vietnamese.pptx&file=${LoginUser.cpnyId }-Module-ESS-MyHome-Vietnamese.pptx">MyHome-<spring:message code="ess.main.vietnamese"/></a>
			                    </li>
			                    <li style="width:165px;">
			                    	 <a style="text-decoration:none ;width:145px;" href="/ess/infoApplyLeave/downloadFile?fileName=/resources/manual/${LoginUser.cpnyId }/${LoginUser.cpnyId }-Module-ESS-MyHome-Korean.pptx&file=${LoginUser.cpnyId }-Module-ESS-MyHome-Korean.pptx">MyHome-<spring:message code="ess.main.korean"/></a>
			                    </li>
		                    </c:if>
		                    <c:if test="${defaultRoleGroupName == 'Coordinator' }">
			                    <li style="width:165px;">
			                    	 <a style="text-decoration:none ;width:145px;" href="/ess/infoApplyLeave/downloadFile?fileName=/resources/manual/${LoginUser.cpnyId }/${LoginUser.cpnyId }-Module-ESS-Coordinator-Vietnamese.pptx&file=${LoginUser.cpnyId }-Module-ESS-Coordinator-Vietnamese.pptx">Coordinator-<spring:message code="ess.main.vietnamese"/></a>
			                    </li>
		                    </c:if>
		                    <c:if test="${defaultRoleGroupName == 'Management' }">
			                    <li style="width:165px;">
			                    	 <a style="text-decoration:none ;width:200px;" href="/ess/infoApplyLeave/downloadFile?fileName=/resources/manual/${LoginUser.cpnyId }/${LoginUser.cpnyId }-Module-ESS-Management-Vietnamese.pptx&file=${LoginUser.cpnyId }-Module-ESS-Management-Vietnamese.pptx">Management-<spring:message code="ess.main.vietnamese"/></a>
			                    </li>
			                    <li style="width:165px;">
			                    	 <a style="text-decoration:none ;width:200px;" href="/ess/infoApplyLeave/downloadFile?fileName=/resources/manual/${LoginUser.cpnyId }/${LoginUser.cpnyId }-Module-ESS-Management-Korean.pptx&file=${LoginUser.cpnyId }-Module-ESS-Management-Korean.pptx">Management-<spring:message code="ess.main.korean"/></a>
			                    </li>
		                    </c:if>
		                    <!--<li style="width:165px;margin-bottom:10px;">
		                        <a style="text-decoration:none ;width:145px;" href="/ess/infoApplyLeave/downloadFile?fileName=/resources/manual/${LoginUser.cpnyId }/${LoginUser.cpnyId }-Module-ESS-Manual.pptx&file=${LoginUser.cpnyId }-Module-ESS-Manual.pptx">使用手册<spring:message code="sys.homePartner.SHIYONGSHOUCE.b"/>-Korean</a>
		                    </li>-->
                         </ul>
					</li>
					<li id="Language_info" class="personnel_info">
						<a style="text-decoration:none ;" id="Language_button"><spring:message code="hrm.empinfo.LANGUAGE"/><!-- Language --></a>
						<ul id="Language_ul" style="width:100px;background-image: url(/resources/css/dwzUI/themes/partner/images/top/info_MyHome.png);background-repeat: no-repeat;background-position: left bottom;">
							<%-- <li><a style="text-decoration:none ;" href="#" onclick="changeLanguage('zh');" style=""><spring:message code="pa.bonus.title.chinese"/><!-- Chinese --><!-- 中文 <spring:message code="pa.bonus.title.chinese" />--></a></li> --%>
							<li><a href="#" onclick="changeLanguage('en');" style="">English</a></li>
							<li><a style="text-decoration:none ;" href="#" onclick="changeLanguage('ko');" style=""><spring:message code="ess.main.korean"/><!-- Korean --><!-- 韩语 <spring:message code="sys.homePartner.languageKO.b" />--></a></li>
							<li style="margin-bottom:10px;"><a style="text-decoration:none ;" href="#" onclick="changeLanguage('vi');" style=""><spring:message code="ess.main.vietnamese"/><!-- Vietnamese --><!-- 越南语 <spring:message code="hrm.login.YUENANYU.Z" />--></a></li>
						
							<!--<c:forEach var="list" items="${languageList}">
								<li><a href="#" onclick="changeLanguage('${list.LANGUAGE}');" style="">${list.DESCRIPTION}</a></li>
							</c:forEach>-->
						
						</ul>
					</li> 
					<%-- <li><a style="text-decoration:none ;" onclick="navTabNum('/ess/change/changePassword','pageNum=1&menuNo=2462&navTabId=ess0401','ess0401','<spring:message code="sys.homePartner.changePassword.b" />');" ><!-- 密码修改 --><spring:message code="sys.homePartner.changePassword.b" /></a></li>
					<li id="logout"><a style="text-decoration:none ;" href="/login/out" >Logout</a></li> --%>
				</ul>
				<div id="navMenu_MyHome" >
				<ul id="nav_all">
                    <li class="selected"><a href="#">${defaultRoleGroupName }</a></li>
					<c:set value="0000" var="MENU_NAME" />
					<c:forEach var="menuInfo" items="${menuList}" varStatus="i">
						<c:if test="${menuInfo.MENU_CODE == defaultSecMenu}">
							<li id="nav_${menuInfo.MENU_CODE}" class="noselected">
								<a href="#" >${menuInfo.MENU_NAME}
									<%-- <span>
										${menuInfo.MENU_NAME}
									</span> --%>
								</a>
		                        <ul class="__nav_item" style="display: none;">
		                        	<c:forEach var="secondMenuInfo" items="${secondMenuList}" varStatus="ii">
		                        		<c:if test="${secondMenuInfo.MENU_PARENT_NO == menuInfo.MENU_NO }">
		                            		<li><a href="#" onclick="menuControl('${menuInfo.MENU_CODE}','${menuInfo.MENU_NAME}','${secondMenuInfo.MENU_CODE}');navTabNum('${secondMenuInfo.MENU_URL}','pageNum=1&menuNo=${secondMenuInfo.MENU_NO}&navTabId=${secondMenuInfo.MENU_CODE}','${secondMenuInfo.MENU_CODE}','${secondMenuInfo.MENU_NAME}');">${secondMenuInfo.MENU_NAME}
												</a></li>
		                        		</c:if>
		                        	</c:forEach>
		                        </ul>
							</li>
							<c:set value="${menuInfo.MENU_NAME}" var="MENU_NAME" />
						</c:if>
						<c:if test="${menuInfo.MENU_CODE ne defaultSecMenu }">
							<li id="nav_${menuInfo.MENU_CODE}" class="noselected">
								<a href="#" >${menuInfo.MENU_NAME}
									<%-- <span>
										${menuInfo.MENU_NAME}
									</span> --%>
								</a>
		                        <ul class="__nav_item" style="display: none;">
		                        	<c:forEach var="secondMenuInfo" items="${secondMenuList}" varStatus="ii">
		                        		<c:if test="${secondMenuInfo.MENU_PARENT_NO == menuInfo.MENU_NO }">
		                            		<li><a href="#" onclick="menuControl('${menuInfo.MENU_CODE}','${menuInfo.MENU_NAME}','${secondMenuInfo.MENU_CODE}');navTabNum('${secondMenuInfo.MENU_URL}','pageNum=1&menuNo=${secondMenuInfo.MENU_NO}&navTabId=${secondMenuInfo.MENU_CODE}','${secondMenuInfo.MENU_CODE}','${secondMenuInfo.MENU_NAME}');">${secondMenuInfo.MENU_NAME}
												</a></li>
		                        		</c:if>
		                        	</c:forEach>
		                        </ul>
							</li>
						</c:if>
					</c:forEach>
                	<!-- <i class="i_nav_right"></i> -->
				</ul>
			</div>
			</div>
			<!-- navMenu -->
			
			
		</div>
			<input type="hidden" id="esstransform" value="${MENU_NAME}"/>

		<%-- <div id="leftside">
			<div id="sidebar_s">
				<div class="collapse" >
					<div class="toggleCollapse" ><div></div></div>
				</div>
			</div>
			<div id="sidebar">
				<div id="maincoll" class="toggleCollapse"><h2></h2><div></div></div>

				<div class="accordion" fillSpace="sidebar">
				
					<c:forEach var="menuInfo" items="${leftList}" varStatus="i"> 
						
						<div id="view_${menuInfo.MENU_CODE}" class="t1"
							<c:if test="${menuInfo.MENU_CODE eq defaultSecMenu }">style="display:block;"</c:if>
							<c:if test="${menuInfo.MENU_CODE ne defaultSecMenu }">style="display:none;"</c:if>
						>
						    <c:if test="${menuInfo.childMenuList ne null}">
						    	<div class="accordionContent">
									<ul class="tree treeFolder">
										
										<c:forEach items="${menuInfo.childMenuList}" var="menuInfo2">
											<li><a href="javascript:;">${menuInfo2.MENU_NAME}</a>
												 <c:if test="${menuInfo2.childMenuList ne null}">
												    <ul>
														<c:forEach items="${menuInfo.childMenuList}" var="menuInfo3">  
														  <li>
														  	 <c:if test="${menuInfo3.childMenuList ne null}">
														  	     <a href="javascript:;">${menuInfo3.MENU_NAME}</a>
															  	 <ul id="aaaaaaa">	  		
																	 <c:forEach items="${menuInfo3.childMenuList}" var="menuInfo4">
																	     <li>
																		 <a  onclick="navTabNum('${menuInfo4.MENU_URL}','pageNum=1&menuNo=${menuInfo4.MENU_NO}&navTabId=${menuInfo4.MENU_CODE}','${menuInfo4.MENU_CODE}','${menuInfo4.MENU_NAME}');">${menuInfo4.MENU_NAME}</a>
																	     
																	     </li>
																	 </c:forEach>
																 </ul>
															  </c:if>
														      <c:if test="${menuInfo3.childMenuList eq null}">
<!-- 														  	      <a href="${menuInfo3.MENU_URL}?pageNum=1&menuNo=${menuInfo3.MENU_NO}&navTabId=${menuInfo3.MENU_CODE}"  target="navTab" rel="${menuInfo3.MENU_CODE}">${menuInfo3.MENU_NAME}@@</a>  -->
														  	      <a onclick="navTabNum('${menuInfo3.MENU_URL}','defaultRoleGroupName=${defaultRoleGroupName }&pageNum=1&menuNo=${menuInfo3.MENU_NO}&navTabId=${menuInfo3.MENU_CODE}','${menuInfo3.MENU_CODE}','${menuInfo3.MENU_NAME}');" >${menuInfo3.MENU_NAME}</a>
															  </c:if>
														  </li>
														 </c:forEach>
													</ul>	
												</c:if>
											 </li>
										</c:forEach>
									</ul>
								</div>
						    </c:if>
					    </div>
					</c:forEach>
				</div>
			</div>
		</div> --%>
		 <div id="leftside" style="max-height: 870px;">
        <div class="__my_home">
            <div class="__my_home_info">
                <span><spring:message code="ess.main.role"/><!-- Role --></span>
                <select id="roleGroupSelect" onchange="changeRoleGroup();">
                	<option value="">${defaultRoleGroupNameDis }</option>
                	<c:forEach var="roleGroupInfo" items="${roleGroupList}" varStatus="i">
                    	<option value="/login/home_partner.do?defaultRoleGroupId=${roleGroupInfo.ROLE_GROUP_ID }&defaultRoleGroupName=${roleGroupInfo.ROLE_GROUP_ENG_NAME}&defaultRoleGroupNameDis=${roleGroupInfo.ROLE_GROUP_NAME }">${roleGroupInfo.ROLE_GROUP_NAME }</option>
                    </c:forEach>
                </select>
            </div>
            <div class="__my_home_img">
            	<c:choose>
            		<c:when test="${LoginUser.photo_path == null }">
            			<img src="/resources/images/head_img.jpg" alt="">
            		</c:when>
            		<c:otherwise><img src="${LoginUser.photo_path }" alt=""></c:otherwise>
            	</c:choose>
                <p class="name">${LoginUser.localName}</p>
                <p class="pro_name">${LoginUser.content} ${LoginUser.postGradeName}</p>
            </div>
            <div class="__my_home_text">
                <p class="time"><spring:message code="ess.main.login_time"/><!-- Login time --></p>
                <p class="calendar">${lastLoginTime}</p>
            </div>

        </div>

        <div class="__my_home_tips" >
            <span class="active" style = "width: 38px; text-align: center;"><spring:message code="ess.main.home"/><!-- Home --></span>
            <span style="cursor: pointer;" onclick="navTabNum('/ess/change/changePassword','pageNum=1&menuNo=2462&navTabId=ess0401','ess0401','<spring:message code="sys.homePartner.changePassword.b" />');" ><spring:message code="sys.homePartner.changePassword.b" /><!-- Password Change --></span>
            <span style="cursor: pointer;" onclick="logoutComfirm();"><spring:message code="ess.main.logout"/><!-- Logout --></span>
        </div>

        <!--伸缩菜单-->
        <div class="nav">
            <ul style="max-height: 500px;overflow: auto">
            	<c:forEach var="menuInfo" items="${menuList}" varStatus="i">
            		<li class="nav-item" id="nav_item_${menuInfo.MENU_CODE}">
	                    <a href="javascript:;"><span>${menuInfo.MENU_NAME}</span></a>
	                    <ul class="child" >
                        	<c:forEach var="secondMenuInfo" items="${secondMenuList}" varStatus="ii">
                        		<c:if test="${secondMenuInfo.MENU_PARENT_NO == menuInfo.MENU_NO }">
                            		<li id="child_${secondMenuInfo.MENU_CODE}"><a href="javascript:;" onclick="menuControl('${menuInfo.MENU_CODE}','${menuInfo.MENU_NAME}','${secondMenuInfo.MENU_CODE}');navTabNum('${secondMenuInfo.MENU_URL}','pageNum=1&menuNo=${secondMenuInfo.MENU_NO}&navTabId=${secondMenuInfo.MENU_CODE}','${secondMenuInfo.MENU_CODE}','${secondMenuInfo.MENU_NAME}');"><span>${secondMenuInfo.MENU_NAME}</span>
										</a></li>
                        		</c:if>
                        	</c:forEach>
	                    </ul>
	                </li>
            	</c:forEach>
            </ul>
        </div>

    </div>
		<div id="container" style="max-height: 860px;">
			<div id="navTab" class="tabsPage">
				<div class="tabsPageHeader">
					<div class="tabsPageHeaderContent" id="tabsPageHeaderContent"><!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
						<ul class="navTab-tab">
							<li tabid="main" url="/login/home2" class="main"><a href="javascript:;"><span><span class="home_icon"><spring:message code="main.home.message.myPage"/></span></span></a></li>
							<div id="open_id_div" style="display:none;"><li tabid="open_Id" url="/login/home2" class="" ><a href="javascript:;"><span class="open_id_namne"><!-- 标签名称 --><spring:message code="hrm.login.BAIOQIAN_NAME.Z" /></span></a></li></div>
						</ul>
					</div>
				</div>
				<ul class="tabsMoreList">
					<li><a href="javascript:;"><spring:message code="main.home.message.myPage"/></a></li>
				</ul>
				<div id="quick_menu_${defaultRoleGroupName }" class="quick_menu_MyHome" style=" right:5px">
						<ul>
                            <li style=" padding-right:20px">
                                <div id="tab4">
                                    <div id="tab4_viewInfo"><a href="#" > <!-- 待审批信息  --><spring:message code="ess.infoApply.daishenpixinxi" /> (<b>${tipsMap.total_count_viewInfo}</b>)</a></div>                  
                                    <ul id="showUL4" class="ulss" style="width:160px;background-repeat:repeat;">
                                    	<c:if test="${!empty tipsMap.ess0601}">
                                                <li id="tab4_viewInfo_1">
                                                    <a href="/ess/infoApply/viewApprovalEmail?defaultRoleGroupName=MyHome&pageNum=1&menuNo=2439&navTabId=ess0601" target="navTab" rel="ess0601" title='<spring:message code="ess.infoApply.JUECAIGESHU" />'><spring:message code="ess.infoApply.JUECAIGESHU" /> (<b>${tipsMap.ess0601}</b>)</a><!-- 待决裁加班 -->
                                                </li>
                                        </c:if>
                                        <c:if test="${LoginUser.cpnyId eq 'HAE'}">
                                                <c:if test="${!empty tipsMap.ess0603}">
	                                                <li id="tab4_viewInfo_2">
	                                                    <a href="/ess/infoApply/viewApprovalBatchEmail?seach_ACTIVITY=0&defaultRoleGroupName=MyHome&pageNum=1&menuNo=90000409&navTabId=ess0603" target="navTab" rel="ess0603" title='<spring:message code="ess.infoApply.PILIANGJUECAIGESHU" />'><spring:message code="ess.infoApply.PILIANGJUECAIGESHU" /> (<b>${tipsMap.ess0603}</b>)</a><!-- 批量待裁决 -->
	                                                </li>
	                                            </c:if>
                                        </c:if>
                                        <c:if test="${LoginUser.cpnyId eq 'HTSV' or LoginUser.cpnyId eq 'HAE'}">
	     		                          	<c:if test="${!empty tipsMap.ess3436}">
	                                                <li id="tab4_viewInfo_2">
	                                                    <a href="/ess/tempEmp/viewShopDetailConfirmList?seach_ACTIVITY=0&defaultRoleGroupName=Coordinator&pageNum=1&menuNo=14015972&navTabId=ess3436" target="navTab" rel="ess3436" title='<spring:message code="login.RIKAOQIN_QUEREN.Z" />'><spring:message code="login.RIKAOQIN_QUEREN.Z" /><!-- 日考勤确认 --> (<b>${tipsMap.ess3436}</b>)</a><!-- 待决裁加班 -->
	                                                </li>
	                                        </c:if>
                                         </c:if>
                                       <c:if test="${LoginUser.cpnyId eq 'SPC_SH' or LoginUser.cpnyId eq 'SPC_NJ' or LoginUser.cpnyId eq 'SPC_HZ'}">
	                                    	<c:if test="${!empty tipsMap.ess3438}">
	                                                <li id="tab4_viewInfo_2">
	                                                    <a href="/ess/tempEmp/viewShopDetailConfirmSHList?seach_ACTIVITY=0&defaultRoleGroupName=Coordinator&pageNum=1&menuNo=14016373&navTabId=ess3448" target="navTab" rel="ess3438" title='<spring:message code="login.RIKAOQIN_QUEREN.Z" />'><spring:message code="login.RIKAOQIN_QUEREN.Z" /><!-- 日考勤确认 --> (<b>${tipsMap.ess3438}</b>)</a><!-- 待决裁加班 -->
	                                                </li>
	                                        </c:if>
                                        </c:if>
                                    	<c:if test="${LoginUser.cpnyId eq 'HTSV'}">
                                         	<c:if test="${defaultRoleGroupName ne 'Coordinator'}">
                                               <li id="tab4_viewInfo_233">
                                                   <a href="/hrm/contractInfo/becomeRegularEvaluate?navTabId=ess2369" target="navTab"  rel="ess2369" title='<spring:message code="login.EMPLOYEE_ZHUANZHENG_PINGJIA.Z" /> '><spring:message code="login.EMPLOYEE_ZHUANZHENG_PINGJIA.Z" /><!-- 员工转正评价 --> </a>
                                               </li>
                                            </c:if>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.ess3444}">
                                                <li id="tab4_viewInfo_3">
                                                    <a href="/ess/tempEmp/viewChangeShopConfirmList?defaultRoleGroupName=Coordinator&pageNum=1&menuNo=14016228&navTabId=ess3444" target="navTab" rel="ess3444" title='<spring:message code="hrm.login.EMPLOYEE_DIAODIAN_SURE.Z" />'><spring:message code="hrm.login.EMPLOYEE_DIAODIAN_SURE.Z" /><!-- 员工调店确认 --> (<b>${tipsMap.ess3444}</b>)</a><!-- 待决裁休假 -->
                                                </li>
                                        </c:if>
                                        <c:if test="${!empty tipsMap.ess0209}">
                                                <li id="tab4_viewInfo_3">
                                                    <a href="/ess/recordApply/viewArMacRecordAffirmList?pageNum=1&menuNo=69&navTabId=ess0209" target="navTab" rel="ess0209" title='漏刷卡审批'>漏刷卡审批(<b>${tipsMap.ess0209}</b>)</a><!-- 待决裁出差 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.ess0305}">
                                                <li id="tab4_viewInfo_4">
                                                    <a href="/ess/infoApply/viewCwaAbnormalAffirmList?pageNum=1&menuNo=218286&navTabId=ess0305" target="navTab" rel="ess0305" title='考勤异常审批'>考勤异常审批(<b>${tipsMap.ess0305}</b>)</a><!-- 待决裁外出 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.ess0304}">
                                                <li id="tab4_viewInfo_5">
                                                    <a href="/ess/affirmApply/viewAnnualadjustmentAffirmList?pageNum=1&menuNo=217791&navTabId=ess0304" target="navTab" rel="ess0304" title='年假调整审批'>年假调整审批(<b>${tipsMap.ess0304}</b>)</a><!-- 待决裁喜丧假 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.ess2017}">
                                                <li id="tab4_viewInfo_6">
                                                    <a href="/ess/editionAffirm/viewEditionAffirmList?pageNum=1&menuNo=218379&navTabId=ess2017" target="navTab" rel="ess2017" title='离职审批'>离职审批(<b>${tipsMap.ess2017}</b>)</a><!-- 待决裁调休假 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.hr0306}">
                                                <li id="tab4_viewInfo_7">
                                                    <a href="/hrm/contractInfo/viewExpiredContractApproveList?pageNum=1&menuNo=215968&navTabId=hr0306" target="navTab" rel="hr0306" title='合同审批'>合同审批(<b>${tipsMap.hr0306}</b>)</a><!-- 待决裁调休假 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.ess0244}">
                                                <li id="tab4_viewInfo_8">
                                                    <a href="/ess/wageApplication/viewWageApplicationList?pageNum=1&menuNo=218222&navTabId=ess0244" target="navTab" rel="ess0244" title='费用审批'>费用审批(<b>${tipsMap.ess0244}</b>)</a><!-- 待决裁调休假 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.pa0901}">
                                                <li id="tab4_viewInfo_9">
                                                    <a href="/pa/tempsale/viewTempSaleAffirmList?pageNum=1&menuNo=218170&navTabId=pa0901" target="navTab" rel="pa0901" title='临促工资审批'>临促工资审批(<b>${tipsMap.pa0901}</b>)</a><!-- 待决裁调休假 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.pa0903}">
                                                <li id="tab4_viewInfo_10">
                                                    <a href="/pa/tempsale/viewTempSaleAccrualAffirmList?pageNum=1&menuNo=218582&navTabId=pa0903" target="navTab" rel="pa0903" title='临促预提审批'>临促预提审批(<b>${tipsMap.pa0903}</b>)</a><!-- 待决裁调休假 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.pa0907}">
                                                <li id="tab4_viewInfo_11">
                                                    <a href="/pa/tempsale/viewTempSaleConfirmList?pageNum=1&menuNo=277600&navTabId=pa0907" target="navTab" rel="pa0907" title='临促汇总确认'>临促汇总确认(<b>${tipsMap.pa0907}</b>)</a><!-- 待决裁调休假 -->
                                                </li>
                                        </c:if>
                                    	<c:if test="${!empty tipsMap.pa0706}">
                                                <li id="tab4_viewInfo_13">
                                                    <a href="/pa/salary/viewPaForLeftMenAffirmList?pageNum=1&menuNo=225&navTabId=pa0706" target="navTab" rel="pa0706" title='离职员工薪资补发审批'>离职员工薪资补发审批(<b>${tipsMap.pa0706}</b>)</a><!-- 待决裁调休假 -->
                                                </li>
                                        </c:if>
                                    </ul> 
                                </div>
                            </li>
							<span class="show"></span>
						</ul>
				</div>
				 <jsp:include page="main_partner.jsp" flush="true"/> 
              </div>
		</div>
</div>
		<!-- <div id="footer"><span>Copyright&copy;2015 TSTO SST All Rights Reserved.</span></div> -->
	    <input type="hidden" id="qMenuHideFlag" name="qMenuHideFlag" value="${qMenuHideFlag}" />
        <!-- <iframe src="" border="0" width="0" height="0"></iframe> -->

</body>
</html>