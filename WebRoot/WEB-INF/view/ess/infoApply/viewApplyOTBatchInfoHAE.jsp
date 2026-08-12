<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
$(document).ready(function(){
	$("#viewApplyOTBatchInfoHAE_Search",navTab.getCurrentPanel()).click(function(){
		$("#viewApplyOTBatchInfoHAE",navTab.getCurrentPanel()).submit();
   });
	 $('#otOverAffirmLBatchTable',navTab.getCurrentPanel()).on( 'draw.dt', function () {
			initEditFun_ess3458();
			init_ess3458();
		} );
	$(".orderList",navTab.getCurrentPanel()).dataTable({
		"bPaginate": true,    //分页
	    "bAutoWidth":false,//表格宽度自动变化
	    "bProcessing":true,
	    "lengthMenu": [[50,100,200, 500], [50,100,200, 500]],
		"bLengthChange": true,  //按多少条记录显示下拉框
		"iDisplayLength": 50, //默认每页显示的记录数
		"bFilter": true,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
     	"searching": true,//本地搜索
		"bSort": true,   //排序功能
		"bInfo": true,   //显示datatables的信息（底部的页数，条目数信息）
		"bScrollInfinite":true,
	     "orderClasses": false,
	     "order":[],//初始化不用自动排序
	     "scrollY": $(document.body).height() - 390,
	     "scrollX": $(document.body).width(),
	     "scrollCollapse": false,
	     "deferRender":true,
	        "columnDefs": [//自定义排序类型
		                     { "orderable": false, "targets": [1,14,16] }
	                     ],
	    "fixedColumns":{leftColumns: 3},
        "oLanguage": {//多语言配置
    	"sProcessing": "<spring:message code='ess.message.loading' />",//正在加载中......
        "sZeroRecords": "<spring:message code='ess.message.NOT_FOUND_DATA' />",//查询不到相关数据！
        "sEmptyTable": "<spring:message code='ess.message.NOT_FOUND_DATA_FROM_TABLE' />",//表中无数据存在！
        "sSearch": "<spring:message code='ess.message.rapid_screening' />",//快速筛选
        "sLengthMenu": "<spring:message code='ess.message.page_of_lines' />",//每页 _MENU_ 条记录
        "sInfo": "<spring:message code='ess.message.sum_begin_to_end' />",//从 _START_ 到 _END_ /共 _TOTAL_ 条数据
        "sInfoFiltered": "<spring:message code='ess.message.filter_from_max' />",//(从 _MAX_ 条记录过滤)
        "oPaginate": {
            "sPrevious": "<spring:message code='ess.message.previous_page' />",//上一页
            "sNext": "<spring:message code='ess.message.next_page' />"//下一页
            }
        },
        "sDom":'<"top"r<"clear">fBl>t<"bottom"ip<"clear">>',
        "buttons": [] 
		});
		init_ess3458();
});
function init_ess3458(){
	var ids= document.getElementsByName("c2");
	for(var i=0;i<ids.length;i++){
		var index = ids[i].id.substring(3);
		getAffirmor_ess3458(index);
	}
}
function initEditFun_ess3458(){
	$('.orderList tbody tr td:[sysLog="text"]',navTab.getCurrentPanel()).editable({type:'text',
		onblur:function(val,settings){
			var index = $(this).attr("sysIndex");
			if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
				$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
			}
			$(this).html(val);
			$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
			this.editing = false;
		}
	});
	$('.orderList tbody tr td:[sysLog="date"]',navTab.getCurrentPanel()).editable({type:'date1',
		onblur:function(val,settings){
			var index = $(this).attr("sysIndex");
			if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
				$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
			}
			$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
			/*$("#ADJUST_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
			$("#SPECIAL_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);*/
			$("#OFFSET_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
			this.editing = false;
		}
	});
	$('.orderList tbody tr td:[sysLog="select"]').editable({type:'select',
		onblur:function(val,settings){
			$(this).html(val);
			var index = $(this).attr("sysIndex");
			otAffirm_callength(index,2);
			if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
				$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
			}
			$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
			this.editing = false;
		}
	});
	$('.orderList tbody tr td:[sysLog="lookUp"]').editable({type:'lookUp',
		onblur:function(val,settings){
			var index = $(this).attr("sysIndex");
			$(this).html(val);
			submitKeyClick_OtAffirm(val,index);
			if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
				$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
			}
			$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
			this.editing = false;
		}
	});
}
$('.orderList tbody tr td:[sysLog="text"]',navTab.getCurrentPanel()).editable({type:'text',
	onblur:function(val,settings){
		var index = $(this).attr("sysIndex");
		if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
			$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
		}
		$(this).html(val);
		$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
		this.editing = false;
	}
});
$('.orderList tbody tr td:[sysLog="date"]',navTab.getCurrentPanel()).editable({type:'date1',
	onblur:function(val,settings){
		var index = $(this).attr("sysIndex");
		if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
			$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
		}
		$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
		$("#OFFSET_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
		this.editing = false;
	}
});
$('.orderList tbody tr td:[sysLog="select"]').editable({type:'select',
	onblur:function(val,settings){
		$(this).html(val);
		var index = $(this).attr("sysIndex");
		otAffirm_callength(index,2);
		if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
			$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
		}
		$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
		this.editing = false;
	}
});
$('.orderList tbody tr td:[sysLog="lookUp"]').editable({type:'lookUp',
	onblur:function(val,settings){
		var index = $(this).attr("sysIndex");
		$(this).html(val);
		submitKeyClick_OtAffirm(val,index);
		if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
			$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
		}
		$("#modifyFlag_" + index,navTab.getCurrentPanel()).html("modify");
		this.editing = false;
	}
});
function saveApplyOTBatchInfo(){
	var affirmflag = true;
	var affirmIDList = '';
	var jsonData = '[';
	$.each($("input[name='c2']"),function(i, obj) {
		if (obj.checked) {
			if (jsonData.length > 1) {
				jsonData += ',{';
			} else {
				jsonData += '{';
			}
			var index = obj.id.substring(3);
			//var adjusr = $("#ADJUST_YN_"+index,navTab.getCurrentPanel()).attr("checked");
			var offset = $("#OFFSET_YN_"+index,navTab.getCurrentPanel()).attr("checked");
			var deduct = $("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("checked");
			var usecar = $("#USECAR_YN_"+index,navTab.getCurrentPanel()).attr("checked");
			if(offset=='checked'){
				$("#OFFSET_YN_"+index,navTab.getCurrentPanel()).val("1");
			}else{
				$("#OFFSET_YN_"+index,navTab.getCurrentPanel()).val("0");
			}
			if(deduct=='checked'){
				$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).val("1");
			}else{
				$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).val("0");
			}
			if(usecar=='checked'){
				$("#USECAR_YN_"+index,navTab.getCurrentPanel()).val("1");
			}else{
				$("#USECAR_YN_"+index,navTab.getCurrentPanel()).val("0");
			}
			jsonData += ' "APPLY_NO": "' + obj.value + '" ,';
			jsonData += ' "PERSON_ID": "' + $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId') + '" ,';
			jsonData += ' "APPLY_OT_DATE":"'+ $("#APPLY_OT_DATE_"+index,navTab.getCurrentPanel()).html() +'" ,';
			jsonData += ' "OT_FROM_TIME":"'+ $("#OT_FROM_DATE_"+index,navTab.getCurrentPanel()).html() +" "+ $("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html() +'" ,';
			jsonData += ' "OT_TO_TIME":"'+ $("#OT_TO_DATE_"+index,navTab.getCurrentPanel()).html() +" "+ $("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html() +'" ,';
			jsonData += ' "OT_APPLY_HOUR":"'+ $("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val() +'" ,';
			jsonData += ' "OFFSET_YN":"'+ $("#OFFSET_YN_"+index,navTab.getCurrentPanel()).val() +'" ,';
			jsonData += ' "DEDUCT_YN":"'+ $("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).val() +'" ,';
			jsonData += ' "USECAR_YN":"'+ $("#USECAR_YN_"+index,navTab.getCurrentPanel()).val() +'" ,';
			jsonData += ' "OT_TYPE_CODE":"'+ $("#OT_TYPE_CODE_NO_"+index,navTab.getCurrentPanel()).val() +'" ,';
			jsonData += ' "APPLY_OT_REMARK":"'+ $("#APPLY_OT_REMARK_"+index,navTab.getCurrentPanel()).html() +'" ,';
			jsonData += ' "CAR_ADDRESS":"'+ $("#CAR_ADDRESS_"+index,navTab.getCurrentPanel()).html() +'" ,';
			jsonData += ' "CAR_ADDRESS_DETAIL":"'+ $("#CAR_ADDRESS_DETAIL_"+index,navTab.getCurrentPanel()).html() +'" ,';

			var affirmJsonData = '[';
			var tb2 = document.getElementById("addApplyOtOverAffirm_list_"+index);
			if(tb2.rows.length > 0){
                for(var i=0;i<tb2.rows.length;i++){
                	var temp = tb2.rows[i].id.substring(16);
                	var affirmID = $("[id='dwz.person.AFFIRMOR_IDApplyOt" + temp +"']",navTab.getCurrentPanel()).val();
                	if($("[id='dwz.person.AFFIRMOR_IDApplyOt" + temp +"']",navTab.getCurrentPanel()).val() != null 
                        	&& $("[id='dwz.person.AFFIRMOR_IDApplyOt" + temp +"']",navTab.getCurrentPanel()).val() != ''){
                    	if (affirmJsonData.length > 1) {
                    		affirmJsonData += ',{';
        				} else {
        					affirmJsonData += '{';
        				}
                    	affirmJsonData += ' "AFFIRM_LEVEL": "' + $("#rowIndex_"+temp,navTab.getCurrentPanel()).html() + '" ,';
                    	affirmJsonData += ' "AFFIRM_TYPE": "' + $("#approvType"+temp,navTab.getCurrentPanel()).val() + '" ,';
                    	affirmJsonData += ' "AFFIRMOR_ID": "' + $("[id='dwz.person.AFFIRMOR_IDApplyOt" + temp +"']",navTab.getCurrentPanel()).val() + '"';
                    	affirmJsonData += '}';
                    	affirmIDList += '"' + affirmID + '" ,';
                    	}
                	}
		    }
		    affirmJsonData += ']';
		    if(affirmJsonData.length == 2){
		    	affirmflag = false;
		     	return false;
			}
		    jsonData += ' "affirmJsonData": '+affirmJsonData+'';
			jsonData += '}';
		}

	});
	jsonData += ']';
	var ids= document.getElementsByName("c2");
	for(var i=0;i<ids.length;i++){
		if(ids[i].checked){
			checked=true;
			var index = ids[i].id.substring(3);
			var sysPersonId = $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId');
			if(sysPersonId == null||sysPersonId==''){
				alertMsg.error("<spring:message code='ar.viewarcardrecord.title.empidnotnull' />");//社号不能为空
				return false;
			}
			var apply_ot_date = $("#APPLY_OT_DATE_"+index,navTab.getCurrentPanel()).html();
			apply_ot_date = apply_ot_date.substring(6,10)+"-"+apply_ot_date.substring(3,5)+"-"+apply_ot_date.substring(0,2);
			if(apply_ot_date.substring(0,1)=="<"||apply_ot_date==''){
				alertMsg.error("<spring:message code='ar.viewArOvertimeManagentFast.QINGXUANZEZHENGQUERIQI.b' />");//请选择正确日期
				return false;
			}
			var tb2 = document.getElementById("addApplyOtOverAffirm_list_"+index);
		   	if(tb2.rows.length == 0 || affirmflag == false){
		   		alertMsg.error("<spring:message code='alert.message.pleaseFirstSetRuler.b' />");//请先设置决裁者
				return false;
		   	}
			var applyNo = $("#c2_"+index,navTab.getCurrentPanel()).val(); 
			var offset = $("#OFFSET_YN_"+index,navTab.getCurrentPanel()).attr("checked");
			if(offset=='checked'){
				offset = 1;
			}else{
				offset = 0;
			}
			var ot_from_date = $("#OT_FROM_DATE_"+index,navTab.getCurrentPanel()).html();
			ot_from_date = ot_from_date.substring(6,10)+"-"+ot_from_date.substring(3,5)+"-"+ot_from_date.substring(0,2);
			
			var ot_to_date = $("#OT_TO_DATE_"+index,navTab.getCurrentPanel()).html();
			ot_to_date = ot_to_date.substring(6,10)+"-"+ot_to_date.substring(3,5)+"-"+ot_to_date.substring(0,2);
			
			var otFromDate = ot_from_date +" "+ $("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html();
			var otToDate = ot_to_date +" "+ $("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html();
			 $.ajax({//人事确认过的会和AR_DETAIL表的考勤冲突
			 cache: false,
			 type: 'post',
			 url: '/hrm/recruitManage/doSql',
			 data:{sql:"select AR_GET_OT_OVER_CLASH('"+applyNo+"','"+sysPersonId+"','"+otFromDate+"','"+otToDate+"','"+offset+"') FLAG from dual"},
			 dataType:"json",
			 success: function(data) {
				var flag = data.result[0].FLAG;
				if(flag>0){
					alertMsg.error("<spring:message code='ar.viewArOvertimeManagentFast.JIABANSHIJIANCHONGTUQINGJIANCHA.b' />");//与已有加班冲突，请检查该时间内是否已经申请
					return false;
				}else if(flag == -1){
					alertMsg.error("<spring:message code='ar.viewApplyAttenanceManagentInfoList.BAOHANKAOQINGUANBIDESHIJIAN.b' />");//包含考勤关闭的时间
					return false;
				}else if(flag == -2){
					alertMsg.error("<spring:message code='ar.viewArOvertimeManaget_fast.Include_apply_closed.b' />");//包含考勤关闭的时间
					return false;
				}else if(flag == -3){
					alertMsg.error("<spring:message code='ess.viewSSTOtApplyInfo.JIABANCHAOGUOYUESHANGXIAN.b' />");//加班时长超过月加班上限
					return false;
				}else if(flag == -4){
					alertMsg.error("<spring:message code='ess.viewSSTOtApplyInfo.JIABANCHAOGUONIANSHANGXIAN.b' />");//加班时长超过年加班上限
					return false;
				}else if(flag == -5){
					alertMsg.error("<spring:message code='alert.message.ess.trans.passAgentTransInBatch_fail' />");//怀孕从七个月以上，则不能加班！
					return false;
				}
				
			 },
			 error:DWZ.ajaxError
			}); 

			var otLimitMonth  = $("#OT_LIMIT_MONTH_"+index,navTab.getCurrentPanel()).val();
			var otLimtYear = $("#OT_LIMIT_YEAR_"+index,navTab.getCurrentPanel()).val();
			var oTApplyHour = $("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val();
            var otTotail = $("#OT_TOTAIL_"+index,navTab.getCurrentPanel()).html();
            var otTotailLimit = $("#OT_TOTAIL_LIMIT_"+index,navTab.getCurrentPanel()).html(); 
            var otTotailMonth = $("#OT_TOTAIL_MONTH_"+index,navTab.getCurrentPanel()).html();
            var otSaturdayMonth = $("#SATURDAY_OT_TOTAIL_"+index,navTab.getCurrentPanel()).html();
            var otTotailMonthLimit = $("#OT_TOTAIL_MONTH_LIMIT_"+index,navTab.getCurrentPanel()).html();
            var otApplyRemark = $("#APPLY_OT_REMARK_"+index,navTab.getCurrentPanel()).html();
            var otPostFamily = $("#OT_POST_FAMILY_"+index,navTab.getCurrentPanel()).val();
            var adminID = $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId');
            
            if (otApplyRemark == '' || otApplyRemark == ' ') {
            	alertMsg.info("<spring:message code='ga.viewApplyCard.APPLY_REASON_NOT_NULL.d' />");
    			return false;
            }
            
			if($("#AFFIRM_FLAG_"+index,navTab.getCurrentPanel()).val()!='14014308' && $("#AFFIRM_FLAG_"+index,navTab.getCurrentPanel()).val()!=''){
				alertMsg.error("<spring:message code='ar.viewArOvertimeManagentFast.QINGXUANZEZHENGQUEXUANXIANG.b' />");//请选择正确选项
				return false;
			}
			if(oTApplyHour == '0' || oTApplyHour ==''){
				alertMsg.error("<spring:message code='ar.viewArOvertimeManagentFast.JIABANSHIJIANBUNENGLING.b' />");//加班时长不能等于0
				return false;
			}
			if(otPostFamily == "14015813" && oTApplyHour < 1){
				alertMsg.info("<spring:message code='alert.message.GUANLIZHIZUISHAOJIABANYIXIAOSHI.b' />");//管理职最少加班一小时
				return false;
			}
	        if(otPostFamily == "14015814" && oTApplyHour < 1){
				alertMsg.info("<spring:message code='alert.message.GUANLIZHIZUISHAOJIABANYIXIAOSHI.b' />");//管理职最少加班一小时
				return false;
			}
	        if(otPostFamily == "14015815" && oTApplyHour < 0.5){
				alertMsg.info("<spring:message code='alert.message.SHENGCHANZHIZUISHAOJIABANBANXIAOSHI.b' />");//生产值最少加班0.5小时
				return false;
			}
	        if(parseFloat(otTotailMonth) + parseFloat(oTApplyHour) < 40 && otLimitMonth == 1 && parseFloat(otTotail) + parseFloat(oTApplyHour) < 300){
	        	alertMsg.info("<spring:message code='ess.viewSSTOtApplyInfo.OVERTIMELIMIT40HOUR.b' />");//加班时长超过月加班上限,无法申请!
	        	return false;
			}
	        var shiftEndTime = $("#AR_SHIFT_END_TIME_"+index,navTab.getCurrentPanel()).val();
	        var dateTime = new Date(shiftEndTime);
	        var curentTime = new Date();
	        var HRAffirmID = '35451890';
	        if (curentTime.getTime() > dateTime.getTime()) {
	        	if(!affirmIDList.includes(HRAffirmID)){
	        		//alert(affirmIDList.includes(HRAffirmID));
	         	    alertMsg.error("<spring:message code='ar.viewArOvertimeManaget_fast.Apply_closed.Ad_HR_Director.b' />");//请将裁决者信息补充完整!
	         	   //alertMsg.error("<spring:message code='ar.viewarcardrecord.title.empidnotnull' />");//社号不能为空
	                return false;
	            }
	        }
		}
	}
	if (jsonData.length == 2) {
		//请选择要添加的数据
		alertMsg.error("<spring:message code='ar.alert.message.viewardetail.choosetoadd'/>");
		return false;
	}
	alertMsg.confirm ("<spring:message code='ar.alert.message.viewArAnnualStandard.consubmit'/>",{
		okCall:function(){
			$.ajax({
	 			type:'post',
	 			url:'/ess/infoApply/saveOTApplyInfoForBatchHAE' ,
	 			data:[{ name: 'jsonData', value: jsonData }],
	 			dataType:"json",
				cache: false,
				success:function(data){ //请求成功后处理函数。
					if(data.statusCode=="200"){
						navTabSearch($("#viewApplyOTBatchInfoHAE"));
						alertMsg.correct(data.message);
					}else{
						if(data.result=="2"){
							alertMsg.info(data.message);
						}else{
							alertMsg.error(data.message);
						}
					}   
		   	 	}  ,
				error: DWZ.ajaxError
 			});
 	}})
 	return false;
}
function delOtApplyCallback(OP_FLAG,form,callback){
	var $form=null;
	if($('#'+form).length>0){
		$form=$('#'+form);}
	else{
 		$form = $(form);}
	
	if (!$form.valid()) {
		return false;
	}
    var checked=false;
	var ids= document.getElementsByName("c2");
	for(var i=0;i<ids.length;i++){
		if(ids[i].checked){
			checked=true;
			
			var index = ids[i].id.substring(3);
			var sysPersonId = $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId');
			var apply_ot_date = $("#APPLY_OT_DATE_"+index,navTab.getCurrentPanel()).html();
			apply_ot_date = apply_ot_date.substring(6,10)+"-"+apply_ot_date.substring(3,5)+"-"+apply_ot_date.substring(0,2);
			var applyNo = $("#c2_"+index,navTab.getCurrentPanel()).val(); 
			var offset = $("#OFFSET_YN_"+index,navTab.getCurrentPanel()).attr("checked");
			if(offset=='checked'){
				offset = 1;
			}else{
				offset = 0;
			}
			var ot_from_date = $("#OT_FROM_DATE_"+index,navTab.getCurrentPanel()).html();
			ot_from_date = ot_from_date.substring(6,10)+"-"+ot_from_date.substring(3,5)+"-"+ot_from_date.substring(0,2);
			
			var ot_to_date = $("#OT_TO_DATE_"+index,navTab.getCurrentPanel()).html();
			ot_to_date = ot_to_date.substring(6,10)+"-"+ot_to_date.substring(3,5)+"-"+ot_to_date.substring(0,2);
			
			var otFromDate = ot_from_date +" "+ $("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html();
			var otToDate = ot_to_date +" "+ $("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html();
			 $.ajax({//人事确认过的会和AR_DETAIL表的考勤冲突
			 cache: false,
			 type: 'post',
			 url: '/hrm/recruitManage/doSql',
			 data:{sql:"select AR_GET_OT_OVER_CLASH('"+applyNo+"','"+sysPersonId+"','"+otFromDate+"','"+otToDate+"','"+offset+"') FLAG from dual"},
			 dataType:"json",
			 success: function(data) {
				var flag = data.result[0].FLAG;
				if(flag == -1){
					alertMsg.error("<spring:message code='ar.viewApplyAttenanceManagentInfoList.BAOHANKAOQINGUANBIDESHIJIAN.b' />");//包含考勤关闭的时间
					return false;
				}else if(flag == -2){
					alertMsg.error("<spring:message code='ar.viewArOvertimeManaget_fast.Include_apply_closed.b' />");//包含考勤关闭的时间
					return false;
				}
			 },
			 error:DWZ.ajaxError
			}); 
		}
	}
	if(!checked){
		alertMsg.error('<spring:message code="alert.message.ess.affirmApply.chooseApplyRecordFirstForBatch"/>'); 
		return false;
	}
    $form.attr("action","/ess/infoApply/delOtOverApplyAffirmForBatch");
    alertMsg.confirm ("<spring:message code='ar.viewApplyAttenanceManagentInfoList.QUEDINGPILIANGQUXIAOMA.b' />",{//确定要批量取消吗?
        okCall:function(){
	    	$.ajax({
				type: form.method || 'POST',
				url:$form.attr("action"),
				data:$form.serializeArray(),
				dataType:"json",
				cache: false,
				success: function(data){ //请求成功后处理函数。
					if(data.statusCode=="200"){
						navTabSearch($("#viewApplyOTBatchInfoHAE"));
						alertMsg.correct(data.message);
					}else{
						if(data.result=="2"){
							alertMsg.info(data.message);
						}else{
							alertMsg.error(data.message);
						}
					}   
		   	 	}  ,
				error: DWZ.ajaxError
			});
        }});
	return false;
}
function addOtOverApplyAffirm(){
	 $.ajax({
			type:'post',
			url:'/ess/infoApply/addOtOverApplyAffirm',
			dataType:null,
			success: function(data){ //请求成功后处理函数。
				navTab.reload('/ess/infoApply/viewApplyOTBatchInfoHAE?type=add&firstFlag=N&seach_START_DATE=${START_DATE}&seach_END_DATE=${END_DATE}');
	   	 	}  ,
			error: DWZ.ajaxError});
}
function submitKeyClick_OtAffirm(obj,index){
	var empid=obj.replace(/[ ]/g," ");
	var personIdStr="applyOtOverApprover";
	if(empid != ''){
	   	$.ajax({
			type: 'POST',
			url: encodeURI('/sys/affirm/getPersonCntByEmpid?EMPID='+empid ),
			dataType:"json",
			cache: false,
			success: function(jsonObject){
				 if(jsonObject.perCnt != 1 ){
					document.getElementById("onckSche").href=encodeURI(encodeURI("/ar/attendanceMintenance/viewAddAffirmEvsList?isEmployeement=1&limit=ar&pageNum=1"
							+'&seach_KEY='+empid+'&personidStr='+personIdStr + '&index=' + index));
					document.getElementById("onckSche").click();
				}
				if(jsonObject.perCnt==1){
					
					$("#EMPID_" + index,navTab.getCurrentPanel()).html(jsonObject.empId);
					$("#EMPID_" + index,navTab.getCurrentPanel()).attr('sysPersonId',jsonObject.personId);
					$("#DEPT_NAME_" +  index,navTab.getCurrentPanel()).html(jsonObject.deptName);
					$("#LOCAL_NAME_" + index,navTab.getCurrentPanel()).html(jsonObject.empName);
					$("#OT_POST_FAMILY_" + index,navTab.getCurrentPanel()).val(jsonObject.POST_FAMILY_NO);
					$("#SHIFT_NAME_" + index,navTab.getCurrentPanel()).html(jsonObject.shiftName);
					$("#OT_LIMIT_" + index,navTab.getCurrentPanel()).val(jsonObject.OT_LIMIT);
					$("#OT_LIMIT_100_" + index,navTab.getCurrentPanel()).val(jsonObject.OT_LIMIT_100);
					getAffirmor_ess3458(index);
				} ;
				getOt_Totail(index);
				otAffirm_callength(index,1);
			},
			error: DWZ.ajaxError
		});
	}else{
		$("#EMPID_" + index,navTab.getCurrentPanel()).html("");
		$("#DEPT_NAME_" +  index,navTab.getCurrentPanel()).html("");
		$("#LOCAL_NAME_" + index,navTab.getCurrentPanel()).html("");
	}
}
function otAffirm_fillItem(){
	$.ajaxSettings.global = false;
	var applyOtRemark = $("#APPLY_OT_REMARK",navTab.getCurrentPanel()).val();
	var fromDate = $("#OT_FROM_DATE",navTab.getCurrentPanel()).val();
	var fromTime = $("#OT_FROM_TIME",navTab.getCurrentPanel()).val();
	var toTime = $("#OT_TO_TIME",navTab.getCurrentPanel()).val();
	var otTypeCode = $("#OT_TYPE_CODE",navTab.getCurrentPanel()).val();
	var ids= document.getElementsByName("c2");
	var checked=false;
	var length = null;
	var lengthText = " ";
	var otTypeCodeName = " ";
	var otTypeCode = " ";
	if(fromDate.substring(0,1)=="<"||fromDate==''){
		alertMsg.error("<spring:message code='ar.viewArOvertimeManagentFast.QINGXUANZEZHENGQUERIQI.b' />");//请选择正确日期
		return false;
	}

	var fromDateformat = fromDate.substring(6,10)+"-"+fromDate.substring(3,5)+"-"+fromDate.substring(0,2);
	
	for(var i=0;i<ids.length;i++){
		if(ids[i].checked){
			checked=true;
			var index = ids[i].id.substring(3);
			var adjust_yn = 0;
			var sprcial_yn = 0;
			var apply_person_id = $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId');
			/*if($("#ADJUST_YN_"+index,navTab.getCurrentPanel()).attr("checked")=='checked'){
				adjust_yn=1;
			}
			if($("#SPECIAL_YN_"+index,navTab.getCurrentPanel()).attr("checked")=='checked'){
				sprcial_yn=1;
			}*/
			$.ajax({
				type: 'POST',
				url: '/ess/infoApply/getValidateInfo',
				async:false,
				data:{"CNPY_ID":'${LoginUser.cpnyId}',"PERSON_ID":apply_person_id,"apply_ot_date":fromDateformat,"otFromTime":fromTime,"otToTime":toTime,"apply_person_id":apply_person_id,"DEDUCT_YN":"0","USECAR_YN":"0"},
				dataType:"json",
				success: function(data){
					length = data.result[0].OT_LENGTH;
					lengthText = data.result[0].OT_LENGTH + "<spring:message code='ar.viewitemparameter.title.xiaoshi' />";//小时
					otTypeCode = data.result[0].OT_TYPE_CODE;
					otTypeCodeName = data.result[0].OT_TYPE_CODE_NAME;
					SHIFT_START_TIME = data.result[0].SHIFT_START_TIME;
					SHIFT_END_TIME = data.result[0].SHIFT_END_TIME;
				},
				error: DWZ.ajaxError
			}); 
			
			$("#APPLY_OT_DATE_"+index,navTab.getCurrentPanel()).html(fromDate);
			$("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html(fromTime);
			$("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html(toTime);
			if(applyOtRemark != ""){
				$("#APPLY_OT_REMARK_"+index,navTab.getCurrentPanel()).html(applyOtRemark);
			}
			$("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(lengthText);
			$("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(length);
			$("#OT_TYPE_CODE_"+index,navTab.getCurrentPanel()).html(otTypeCodeName);
			$("#OT_TYPE_CODE_NO_"+index,navTab.getCurrentPanel()).val(otTypeCode);
			$("#SHIFT_START_TIME_"+index,navTab.getCurrentPanel()).html(SHIFT_START_TIME);
			$("#SHIFT_END_TIME_"+index,navTab.getCurrentPanel()).html(SHIFT_END_TIME);
			
			$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
			$("#USECAR_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
			if(fromTime>toTime){
				$("#OFFSET_YN_"+index,navTab.getCurrentPanel()).attr("checked",true);
			}else{
				$("#OFFSET_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
			}
		}
	}
	if(!checked){
		alertMsg.error('<spring:message code="ar.viewApplyAttenanceManagentInfoList.QINGXUANZEXIUGAINEIRONG.b" />'); //请选择要修改的内容
		return false;
	}
	$.ajaxSettings.global = true;
}
function otAffirm_callength(index,FLAG){
	var adjust_yn = 0;
	var sprcial_yn = 0;
	var deduct_yn = 0;
	var apply_ot_date = $("#APPLY_OT_DATE_"+index,navTab.getCurrentPanel()).html();
	apply_ot_date = apply_ot_date.substring(6,10)+"."+apply_ot_date.substring(3,5)+"."+apply_ot_date.substring(0,2);
	
	var otFromDate = $("#OT_FROM_DATE_"+index,navTab.getCurrentPanel()).html();
        otFromDate = otFromDate.substring(6,10) + "." + otFromDate.substring(3,5) + "." + otFromDate.substring(0,2);
    var otToDate = $("#OT_TO_DATE_"+index,navTab.getCurrentPanel()).html();    
        otToDate = otToDate.substring(6,10) + "." + otToDate.substring(3,5) + "." + otToDate.substring(0,2);
	
    var otFromTime = $("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html();
	var otToTime = $("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html();
	
	    otFromTime = otFromDate + " " + otFromTime;
	    otToTime   = otToDate + " " + otToTime;
	
	var apply_person_id = $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId');
	var length = " ";
	if($("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("checked")=='checked'){
		deduct_yn = 1;
	}
	if(new Date(otToTime) - new Date(otFromTime)<0){
		$("#OFFSET_YN_"+index).attr("checked",true);
	}
	if(new Date(otToTime) - new Date(otFromTime)>0){
		$("#OFFSET_YN_"+index).attr("checked",false);
	}
	if(apply_ot_date.substring(0,1)=="<"||apply_ot_date==''){
		alertMsg.error("<spring:message code='ar.viewArOvertimeManagentFast.QINGXUANZEZHENGQUERIQI.b' />");//请选择正确日期
		return false;
	}
	if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
		$("#c2_"+index,navTab.getCurrentPanel()).attr("checked",true); 
	}
	$.ajax({
		 cache: false,
		 type: 'post',
		 async:false,
		 url: '/ess/infoApply/getValidateInfo',
		 data:{"CNPY_ID":'${LoginUser.cpnyId}',"PERSON_ID":apply_person_id,"apply_ot_date":apply_ot_date,"otFromTime":otFromTime,"otToTime":otToTime,"apply_person_id":apply_person_id,"DEDUCT_YN":deduct_yn},
		 dataType:"json",
		 success: function(data) {
			 length = data.result[0].OT_LENGTH;
			 var shiftStartTime = data.result[0].SHIFT_START_TIME;
			 var shiftEndTime = data.result[0].SHIFT_END_TIME;
			 var shiftEndTime_2 = data.result[0].SHIFT_END_TIME_2;
			 var otShiftLength = data.result[0].OT_SHIFT_LENGTH;
			 $("#OT_TYPE_CODE_"+index,navTab.getCurrentPanel()).html(data.result[0].OT_TYPE_CODE_NAME);
			 $("#OT_TYPE_CODE_NO_"+index,navTab.getCurrentPanel()).val(data.result[0].OT_TYPE_CODE);
			 if(data.result[0].DATETYPE == '1440'){
				 //$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).removeAttr("disabled");
				if(FLAG==1){
					//$("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					//$("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime_2);
					$("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(length+" <spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					$("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(length);
					$("#SHIFT_START_TIME_"+index,navTab.getCurrentPanel()).html(shiftStartTime);
					$("#SHIFT_END_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					$("#INDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].INDOOR_TIME);
					$("#OUTDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].OUTDOOR_TIME);
				 }else{
					 $("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(length+" <spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					 $("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(length);
				 }
			}else if(data.result[0].DATETYPE == '90000425'){
				//$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
				//$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("disabled","disabled");
				if(FLAG==1){
					$("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html(shiftStartTime);
					$("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					$("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(otShiftLength+"<spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					$("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(otShiftLength);
					$("#SHIFT_START_TIME_"+index,navTab.getCurrentPanel()).html(shiftStartTime);
					$("#SHIFT_END_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					$("#INDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].INDOOR_TIME);
					$("#OUTDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].OUTDOOR_TIME);
				}else{
					 $("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(length+"<spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					 $("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(length);
				 }
			}else if(data.result[0].DATETYPE == '1441'){
				//$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
				//$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("disabled","disabled");
				if(FLAG==1){
					$("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html(shiftStartTime);
					$("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					$("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(otShiftLength+" <spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					$("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(otShiftLength);
					$("#SHIFT_START_TIME_"+index,navTab.getCurrentPanel()).html(shiftStartTime);
					$("#SHIFT_END_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					$("#INDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].INDOOR_TIME);
					$("#OUTDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].OUTDOOR_TIME);
				}else{
					 $("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(length+" <spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					 $("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(length);
				 }
			}else{
				//$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("checked",false);
				//$("#DEDUCT_YN_"+index,navTab.getCurrentPanel()).attr("disabled","disabled");
				if(FLAG==1){
					$("#OT_FROM_TIME_"+index,navTab.getCurrentPanel()).html(shiftStartTime);
					$("#OT_TO_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					$("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(otShiftLength+" <spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					$("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(otShiftLength);
					$("#SHIFT_START_TIME_"+index,navTab.getCurrentPanel()).html(shiftStartTime);
					$("#SHIFT_END_TIME_"+index,navTab.getCurrentPanel()).html(shiftEndTime);
					$("#INDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].INDOOR_TIME);
					$("#OUTDOOR_TIME_"+index,navTab.getCurrentPanel()).html(data.result[0].OUTDOOR_TIME);
				}else{
					 $("#OT_APPLY_HOUR_TEXT_"+index,navTab.getCurrentPanel()).html(length+" <spring:message code='ar.viewitemparameter.title.xiaoshi' />");//小时
					 $("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val(length);
				}
			}
		 },
		 error:DWZ.ajaxError
	});
	getAffirmor_ess3458(index);
	getOt_Totail(index);
}
function getDefaultOtTimeSST(){
	$.ajaxSettings.global = false;
	var OT_FROM_DATE = $("#OT_FROM_DATE",navTab.getCurrentPanel()).val();
	if(OT_FROM_DATE.substring(0,1)=="<"||OT_FROM_DATE==''){
		alertMsg.error("<spring:message code='ar.viewArOvertimeManagentFast.QINGXUANZEZHENGQUERIQI.b' />");//请选择正确日期
		return false;
	}
	$.ajax({
		type: 'POST',
		url: '/hrm/recruitManage/doSql',
		data:{sql:"select GET_AR_DATETYPE('${LoginUser.adminID}','" + OT_FROM_DATE + "','${LoginUser.cpnyId}') DATETYPE," +
			"TO_CHAR(TO_DATE(GET_AR_SHIFT_END_TIME('${LoginUser.adminID}','"+OT_FROM_DATE+"','${LoginUser.cpnyId}'),'YYYY.MM.DD HH24:MI'),'HH24:MI') SHIFT_END_TIME,"+
			"TO_CHAR(TO_DATE(GET_AR_SHIFT_END_TIME('${LoginUser.adminID}','"+OT_FROM_DATE+"','${LoginUser.cpnyId}'),'YYYY.MM.DD HH24:MI')+3/24,'HH24:MI') SHIFT_END_TIME_2," +
			"TO_CHAR(TO_DATE(GET_AR_SHIFT_START_TIME('${LoginUser.adminID}','"+OT_FROM_DATE+"','${LoginUser.cpnyId}'),'YYYY.MM.DD HH24:MI'),'HH24:MI') SHIFT_START_TIME from dual"},
		dataType:"json",
		cache: false,
		success: function(data){
			var shiftStartTime = data.result[0].SHIFT_START_TIME;
			var shiftEndTime = data.result[0].SHIFT_END_TIME;
			var shiftEndTime_2 = data.result[0].SHIFT_END_TIME_2;
			if(data.result[0].DATETYPE == '1440'){
				$("#OT_TYPE_CODE",navTab.getCurrentPanel()).val(32);
				$("#OT_FROM_TIME",navTab.getCurrentPanel()).val(shiftEndTime);
				$("#OT_TO_TIME",navTab.getCurrentPanel()).val(shiftEndTime_2);
			}else if(data.result[0].DATETYPE == '90000425'){
				$("#OT_TYPE_CODE",navTab.getCurrentPanel()).val(218181);
				$("#OT_FROM_TIME",navTab.getCurrentPanel()).val(shiftStartTime);
				$("#OT_TO_TIME",navTab.getCurrentPanel()).val(shiftEndTime);
			}else if(data.result[0].DATETYPE == '1441'){
				$("#OT_TYPE_CODE",navTab.getCurrentPanel()).val(33);
				$("#OT_FROM_TIME",navTab.getCurrentPanel()).val(shiftStartTime);
				$("#OT_TO_TIME",navTab.getCurrentPanel()).val(shiftEndTime);
			}else{
				$("#OT_TYPE_CODE",navTab.getCurrentPanel()).val(34);
				$("#OT_FROM_TIME",navTab.getCurrentPanel()).val(shiftStartTime);
				$("#OT_TO_TIME",navTab.getCurrentPanel()).val(shiftEndTime);
			}
		},
		error: DWZ.ajaxError
	});
	$.ajaxSettings.global = true;
}
/**
 * 禁用textArea以及Input框的enter键的自动提交
 */
document.onkeydown = function(event) {  
	  var target, code, tag;  
	  if (!event) {  
	       event = window.event; //针对ie浏览器  
	       target = event.srcElement;  
	       code = event.keyCode;  
	       if (code == 13) {  
	           tag = target.tagName;  
	           if (tag == "TEXTAREA") {
		           return true;
		       }else{ 
			       return false;
			   }  
	       }  
	  }else {  
	       target = event.target; //针对遵循w3c标准的浏览器，如Firefox  
	       code = event.keyCode;  
	       if (code == 13) {  
	           tag = target.tagName;  
	           if (tag == "INPUT"){ 
	        	   $("#seach_KEY",navTab.getCurrentPanel())[0].focus();
		           return false; 
		       }else {
			        return true;
			   }   
	      }  
	 }  
};
function updateChecked(index){
	if(!$("#c2_"+index,navTab.getCurrentPanel()).prop("disabled")){
		$("#c2_"+index,navTab.getCurrentPanel()).attr('checked',true);
	}
}
function getAffirmor_ess3458(index){
	var htm = '';
	var applyNo = $("#c2_"+index,navTab.getCurrentPanel()).val();
	var personId = $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId');
	var otTypeCode = $("#OT_TYPE_CODE_NO_"+index,navTab.getCurrentPanel()).val();
	var applyLength = $("#OT_APPLY_HOUR_"+index,navTab.getCurrentPanel()).val();
	var dutyNo = $("#OT_DUTY_NO_"+index,navTab.getCurrentPanel()).val();

	$.ajax({
		type: 'POST',
		url: '/ess/infoApplyAttendance/getAffirmorByApplyNoList',
		data:[{ name: 'APPLY_NO', value: applyNo }],
		dataType:"json",
		cache: false,
		async:false,
		success: function(returnData){
			if(returnData.affirmorList.length>0){
				for(var i=0;i<returnData.affirmorList.length;i++){
					var count = $("#applyOtOverCount"+index,navTab.getCurrentPanel()).val();
					htm +='<tr id="rowIdApplyOtOver'+ index +'_'+ count +'"><td class="td_type" style="text-align: center" width="5%" id="rowIndex_'+ index +'_'+ count +'">'+(i+1)+'</td>';
					htm +='<td class="td_type" style="text-align: center" width="20%">';
					//htm +='<input type="hidden" id="approvType'+ index +'_'+ count +'" name="approvType" value="1" />';
					//htm +='<input type="hidden" name="approvTypeIndex" value="' + count + '" />';
					htm +='<input id="dwz.person.AFFIRMOR_IDApplyOt'+ index +'_'+ count +'" name="AFFIRMOR_ID" value="'+ returnData.affirmorList[i].AFFIRM_PERSON_ID +'" type="hidden"/>';
					htm +='<input id="dwz.person.InfoEMPINFOApplyOt'+ index +'_'+ count +'" value="'+returnData.affirmorList[i].LOCAL_NAME+'/'+returnData.affirmorList[i].POSITION_NAME+'/'+returnData.affirmorList[i].DEPTNAME+'"  type="text"  size="40" disabled="disabled"/>';
					htm +='</td>';
					htm +='<td class="td_type" style="text-align: center" width="20%">';
					htm +='<input id="dwz.person.EMPINFOApplyOt'+ index +'_'+ count +'" name="empid" value="'+returnData.affirmorList[i].EMPID+'" type="text" title="<spring:message code="evs.affirm.please_input_enter.e"/>" size="10" class="required" lookupGroup="person" onkeydown="submitKeyClick_applyOt(this,' + count + ',event)"/>';
					htm +='</td>';
					htm +='<td class="td_type" style="text-align: center" width="5%">';
					htm +='<select id="approvType'+ index +'_'+ count + '" name="approvType'+ index +'_'+ count + '">';
					htm +='<option value="1" ><!--审批 --><spring:message code="hr.contract.title.shenpi"/></option>';
					htm +='<option value="3" ><!--通知 --><spring:message code="ess.infoApply.gonggao"/></option> ';
					htm +='</td>';
					htm +='<td class="td_type" style="text-align: center" width="15%">';
					htm +='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
					htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyOtOver(' + index + ',' + count + ')"/>&nbsp;&nbsp;&nbsp;';
					htm +='<img src="/resources/images/-.gif" title="<spring:message code="button.delete"/>"';	
					htm +='border="0" align="absmiddle" style="cursor:hand" onclick="javaScript:document.all.addApplyOtOverAffirm_list_'+index+'.deleteRow(event.srcElement.parentElement.parentElement.rowIndex);changeApplyOtLevel('+index+');"/></td></tr>'; 

					$("#applyOtOverCount"+index,navTab.getCurrentPanel()).val(++count);
				}
				$("#addApplyOtOverAffirm_list_"+index,navTab.getCurrentPanel()).html(htm);
			}else{
				$.ajax({
					type: 'POST',
					url: '/ess/infoApplyAttendance/viewAffirmorByPersonIdListForOt',
					data:[{ name: 'applyTypeCode', value: otTypeCode },/* 审批线相同，无所谓 */
					      { name: 'applyLength', value: applyLength },
					      { name: 'applyTypeNo', value: '31' },
					      { name: 'personId', value: personId }],
					dataType:"json",
					cache: false,
					async:false,
					success: function(data){
						if(data.affirmorList.length>0){
							for(var i=0;i<data.affirmorList.length;i++){
								var count = $("#applyOtOverCount"+index,navTab.getCurrentPanel()).val();
								htm +='<tr id="rowIdApplyOtOver'+ index +'_'+ count +'"><td class="td_type" style="text-align: center" width="5%" id="rowIndex_'+ index +'_'+ count +'">'+(i+1)+'</td>';
								htm +='<td class="td_type" style="text-align: center" width="20%">';
								//htm +='<input type="hidden" id="approvType'+ index +'_'+ count +'" name="approvType" value="1" />';
								//htm +='<input type="hidden" name="approvTypeIndex" value="' + count + '" />';
								htm +='<input id="dwz.person.AFFIRMOR_IDApplyOt'+ index +'_'+ count +'" name="AFFIRMOR_ID" value="'+ data.affirmorList[i].AFFIRMOR_ID +'" type="hidden"/>';
								htm +='<input id="dwz.person.InfoEMPINFOApplyOt'+ index +'_'+ count +'" value="'+data.affirmorList[i].LOCAL_NAME+'/'+data.affirmorList[i].POSITION_NAME+'/'+data.affirmorList[i].DEPTNAME+'"  type="text"  size="40" disabled="disabled"/>';
								htm +='</td>';
								htm +='<td class="td_type" style="text-align: center" width="20%">';
								htm +='<input id="dwz.person.EMPINFOApplyOt'+ index +'_'+ count +'" name="empid" value="'+data.affirmorList[i].EMPID+'" type="text" title="<spring:message code="evs.affirm.please_input_enter.e"/>" size="10" class="required" lookupGroup="person" onkeydown="submitKeyClick_applyOt(this,' + count + ',event)"/>';
								htm +='</td>';
								htm +='<td class="td_type" style="text-align: center" width="5%">';
								htm +='<select id="approvType'+ index +'_'+ count + '" name="approvType'+ index +'_'+ count + '">';
								htm +='<option value="1" ><!--审批 --><spring:message code="hr.contract.title.shenpi"/></option>';
								htm +='<option value="3" ><!--通知 --><spring:message code="ess.infoApply.gonggao"/></option> ';
								htm +='</td>';
								htm +='<td class="td_type" style="text-align: center" width="15%">';
								htm +='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
								htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyOtOver(' + index + ',' + count + ')"/>&nbsp;&nbsp;&nbsp;';
								htm +='<img src="/resources/images/-.gif" title="<spring:message code="button.delete"/>"';	
								htm +='border="0" align="absmiddle" style="cursor:hand" onclick="javaScript:document.all.addApplyOtOverAffirm_list_'+index+'.deleteRow(event.srcElement.parentElement.parentElement.rowIndex);changeApplyOtLevel('+index+');"/></td></tr>'; 

								$("#applyOtOverCount"+index,navTab.getCurrentPanel()).val(++count);
							}
							$("#addApplyOtOverAffirm_list_"+index,navTab.getCurrentPanel()).html(htm);
						}else{
							var count = $("#applyOtOverCount"+index,navTab.getCurrentPanel()).val();
							htm +='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
							htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyOtOver(' + index + ',' + count + ')"/>&nbsp;&nbsp;&nbsp;';
							
							$("#addApplyOtOverAffirm_list_"+index,navTab.getCurrentPanel()).html(htm);
						}
					},
					error: DWZ.ajaxError
				});
			}
		},
		error: DWZ.ajaxError
	});
}

function addRowByIDApplyOtOver(index,currentRowID){
	var count = $("#applyOtOverCount"+index,navTab.getCurrentPanel()).val();
	var htm ='<tr id="rowIdApplyOtOver'+ index +'_'+ count +'"><td class="td_type" style="text-align: center" width="5%" id="rowIndex_'+ index +'_'+ count +'"></td>';
	htm +='<td class="td_type" style="text-align: center" width="20%">';
	//htm +='<input type="hidden" id="approvType'+ index +'_'+ count +'" name="approvType" value="1" />';
	//htm +='<input type="hidden" name="approvTypeIndex" value="' + count + '" />';
	htm +='<input id="dwz.person.AFFIRMOR_IDApplyOt'+ index +'_'+ count +'" name="AFFIRMOR_ID" value="" type="hidden"/>';
	htm +='<input id="dwz.person.InfoEMPINFOApplyOt'+ index +'_'+ count +'"  type="text"  size="40" disabled="disabled"/>';
	htm +='</td>';
	htm +='<td class="td_type" style="text-align: center" width="20%">';
	htm +='<input id="dwz.person.EMPINFOApplyOt'+ index +'_'+ count +'" name="empid" type="text" alt="<spring:message code="evs.affirm.please_input_enter.e"/>" title="<spring:message code="evs.affirm.please_input_enter.e"/>" size="10" class="required" lookupGroup="person" onkeydown="submitKeyClick_applyOt(this,' + count + ',event)"/>';	htm +='</td>';
	htm +='<td class="td_type" style="text-align: center" width="5%">';
	htm +='<select id="approvType'+ index +'_'+ count + '" name="approvType'+ index +'_'+ count + '">';
	htm +='<option value="1" ><!--审批 --><spring:message code="hr.contract.title.shenpi"/></option>';
	htm +='<option value="3" ><!--通知 --><spring:message code="ess.infoApply.gonggao"/></option> ';
	htm +='</td>';
	htm +='<td class="td_type" style="text-align: center" width="15%">';
	htm +='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
	htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyOtOver(' + index + ',' + count + ')"/>&nbsp;&nbsp;&nbsp;';
	htm +='<img src="/resources/images/-.gif" title="<spring:message code="button.delete"/>"';	
	htm +='border="0" align="absmiddle" style="cursor:hand" onclick="javaScript:document.all.addApplyOtOverAffirm_list_'+index+'.deleteRow(event.srcElement.parentElement.parentElement.rowIndex);changeApplyOtLevel('+index+');"/></td></tr>'; 

	var tb2 = document.getElementById("addApplyOtOverAffirm_list_"+index);
	var rowCount = tb2.rows.length;
	
   	//当前行之后插入一行
   	if(rowCount == 0){
   		$("#addApplyOtOverAffirm_list_"+index,navTab.getCurrentPanel()).html(htm);
   	}else{
   		$("#rowIdApplyOtOver"+ index + "_" + currentRowID).after(htm);
   	}
   	
  	//$("[id='dwz.person.EMPINFOApplyOt" + index + '_' + count + "']").inputAlert();
   	changeApplyOtLevel(index);
  	$("#applyOtOverCount"+index,navTab.getCurrentPanel()).val(++count) ;
}

/*修改裁决者等级*/
function changeApplyOtLevel(index){
	var tb2 = document.getElementById("addApplyOtOverAffirm_list_"+index);
	var rowCount = tb2.rows.length;
	for(var m=0;m<rowCount;m++){
		tb2.rows[m].cells[0].innerHTML = m+1;
	}
	if(rowCount == 0){
		var count = $("#applyOtOverCount"+index,navTab.getCurrentPanel()).val();
		var htm ='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
		htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyOtOver(' + index + ',' + count + ')"/>&nbsp;&nbsp;&nbsp;';
		$("#addApplyOtOverAffirm_list_"+index,navTab.getCurrentPanel()).html(htm);
	}
}

var keyCodeInit=0;
function submitKeyClick_applyOt(obj,index,event){
	var localName = '';
	var idcardNo = '';
	var navTabId = '';
 	var e= event ? event : window.event; 
 	var keyCode = e.which ? e.which : e.keyCode;
   	if(keyCode==13){
   		keyCodeInit=keyCode;
		var empid=obj.value.replace(/[ ]/g,"");		
		var empIdStr=obj.id.substring(11);
		var personIdStr="AFFIRMOR_IDApplyOt"+empIdStr.substring(14);
		var personInfoStr = "InfoEMPINFOApplyOt"+empIdStr.substring(14);
		if(empid == ''){
			obj.value=" ";
			document.getElementById("onckOt").href=encodeURI(encodeURI("/ar/attendanceMintenance/viewAddAffirmList?isEmployeement=1&firstFlag=1&limit=super&pageNum=1"
					+'&seach_KEY='+empid
					+'&empidStr='+empIdStr
					+'&personidStr='+personIdStr
					+'&personInfoStr='+personInfoStr					
					));
			document.getElementById("onckOt").click();
		}else{
	   		$.ajax({
				type: 'POST',
				url: encodeURI('/sys/affirm/getPersonCntByEmpid?EMPID='+empid ),
				dataType:"json",
				cache: false,
				success: function(jsonObject){
							if(jsonObject.perCnt != 1 ){
								document.getElementById("onckOt").href=encodeURI(encodeURI("/ar/attendanceMintenance/viewAddAffirmList?isEmployeement=1&limit=super&pageNum=1"
										+'&seach_KEY='+empid
										+'&empidStr='+empIdStr
										+'&personidStr='+personIdStr
										+'&personInfoStr='+personInfoStr				
										));
								document.getElementById("onckOt").click();
							}
							if(jsonObject.perCnt==1){
								$("[id='dwz.person.InfoEMPINFOApplyOt" + empIdStr.substring(14) + "']").val(jsonObject.empName+"/"+jsonObject.POSITION_NAME+"/"+jsonObject.deptName);
							  	$("[id='dwz.person.EMPINFOApplyOt" + empIdStr.substring(14) + "']").val(jsonObject.empId);
							  	$("[id='dwz.person.AFFIRMOR_IDApplyOt" + empIdStr.substring(14) + "']").val( jsonObject.personId);
							}
						},
				error: DWZ.ajaxError
			});
		}
    }
 }

function getOt_Totail(index){
	$.ajaxSettings.global = false;
	var APPLY_OT_DATE = $("#APPLY_OT_DATE_"+index,navTab.getCurrentPanel()).html();
	var APPLY_OT_DATE_FORMAT = APPLY_OT_DATE.substring(6,10)+"-"+APPLY_OT_DATE.substring(3,5)+"-"+APPLY_OT_DATE.substring(0,2);
	var PERSON_ID = $("#EMPID_"+index,navTab.getCurrentPanel()).attr('sysPersonId');
	$.ajax({
		type: 'POST',
		url: '/hrm/recruitManage/doSql',
		data:{sql:"select GET_AR_OT_TOTAIL(replace('" + APPLY_OT_DATE_FORMAT + "','-','/'),'${LoginUser.cpnyId}','" + PERSON_ID + "','200')  OT_TOTAIL," +
			"GET_AR_OT_TOTAIL(replace('" + APPLY_OT_DATE_FORMAT + "','-','/'),'${LoginUser.cpnyId}','" + PERSON_ID + "','30')  OT_TOTAIL_MONTH," +
			"TO_CHAR(TO_DATE(GET_AR_SHIFT_END_TIME('"+PERSON_ID+"','"+APPLY_OT_DATE_FORMAT+"','${LoginUser.cpnyId}'),'YYYY.MM.DD HH24:MI'),'YYYY/MM/DD HH24:MI') AR_SHIFT_END_TIME,"+
			"TO_CHAR(TO_DATE(GET_AR_SHIFT_START_TIME('"+PERSON_ID+"','"+APPLY_OT_DATE_FORMAT+"','${LoginUser.cpnyId}'),'YYYY.MM.DD HH24:MI'),'YYYY/MM/DD HH24:MI') AR_SHIFT_START_TIME," +
			"GET_AR_OT_LIMIT_VALUE(replace('" + APPLY_OT_DATE_FORMAT + "','-','.'),'" + PERSON_ID + "','MONTH')  OT_LIMIT_MONTH," +
			"GET_AR_OT_LIMIT_VALUE(replace('" + APPLY_OT_DATE_FORMAT + "','-','.'),'" + PERSON_ID + "','YEAR')  OT_LIMIT_YEAR" +
			" FROM DUAL"},
		dataType:"json",
		cache: false,
		success: function(data){
			
			var ot_totail = data.result[0].OT_TOTAIL;
			var ot_totail_month = data.result[0].OT_TOTAIL_MONTH;
			var ot_limit_month = data.result[0].OT_LIMIT_MONTH;
			var ot_limit_year = data.result[0].OT_LIMIT_YEAR;
			
			
			$("#OT_TOTAIL_"+index,navTab.getCurrentPanel()).html(ot_totail);
			$("#OT_TOTAIL_MONTH_"+index,navTab.getCurrentPanel()).html(ot_totail_month);
			$("#OT_LIMIT_MONTH_"+index,navTab.getCurrentPanel()).val(ot_limit_month);
			$("#OT_LIMIT_YEAR_"+index,navTab.getCurrentPanel()).val(ot_limit_year);
			$("#AR_SHIFT_END_TIME_"+index,navTab.getCurrentPanel()).val(data.result[0].AR_SHIFT_END_TIME);
			
		},
		error: DWZ.ajaxError
	});
	$.ajaxSettings.global = true;
}

function batchCheckedAndCallength(control){
	if(control.checked){
		$.each($("input[name='DEDUCT_YN']"),function(i, obj) {
			if (!obj.disabled) {
				obj.checked = true;
				var index = obj.id.substr(10);
				updateChecked(index);
		        otAffirm_callength(index,2);
			}
		});
    }else{
    	$.each($("input[name='DEDUCT_YN']"),function(i, obj) {
			if (!obj.disabled) {
				obj.checked = false;
				var index = obj.id.substr(10);
				updateChecked(index);
		        otAffirm_callength(index,2);
			}
		});
    }
}

function batchChecked(control){
	if(control.checked){
		$.each($("input[name='USECAR_YN']"),function(i, obj) {
			if (!obj.disabled) {
				obj.checked = true;
				var index = obj.id.substr(10);
				updateChecked(index);
		        
			}
		});
    }else{
    	$.each($("input[name='USECAR_YN']"),function(i, obj) {
			if (!obj.disabled) {
				obj.checked = false;
				var index = obj.id.substr(10);
				updateChecked(index);
		        
			}
		});
    }
}

function excelimport_ess3458(){
	$("#importExcelDialog_ess3458").attr('href','/pa/excelImport/importExcelData?importFunName=/importApplyOtOver');
	$("#importExcelDialog_ess3458").click();
}
function changeURL_ess3458(applyNo){
	var href = "/ess/infoApply/viewApprovaledOtOverInfo?seach_APPLY_NO=" + applyNo;
	$.pdialog.open(href,"ess3458", "<spring:message code='ar.viewApplyAttenanceManagentInfoList.MINGXICHAKAN.b' />", {width:1000,height:600,mask:true});//明细查看
}
</script>
<a id="importExcelDialog_ess3458"  href="#" target="dialog" mask="true"></a>
<a id="importExcel_ess3458" href="#" target="navTab" mask="true"><span style="display:none;"><!-- 导入结果 --><spring:message code="ess.title.DAORUJIEGUO" /></span></a>
<div   id="viewApplyOtOverBatch"  class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="/ess/infoApply/viewApplyOTBatchInfoHAE?firstFlag=N" method="post"
		id="viewApplyOTBatchInfoHAE" name="viewApplyOTBatchInfoHAE">
		 
		<div class="searchBar">
				<table class="searchContent">
				<tr>
					<td><!-- 社号/姓名 --><spring:message code="hrm.empinfo.nameAndEmpid" /></td>
					<td>
						<div style="float:left"><input type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"/></div>
					</td>
					<td><spring:message code="hr.viewPersonalInfo.title.DEPTNAME" /></td>
					<td>
						<ait:deptList name="seach_DEPTNO" cpnyId="${defaultCpny}" limit="manager" id="viewApplyOTBatchInfoHAE_seachDept" selected="${DEPTNO}"/>
						<ait:deptTreeIcon name="seach_DEPTNO" cpnyId="${defaultCpny}" limit="manager" id="viewApplyOTBatchInfoHAE_seachDept" selected="${DEPTNO}"/>
					</td>
					<td><!--日期--><spring:message code="org.title.DATE" /> </td>
					<td>
						<input type="text" id="seach_START_DATE" name="seach_START_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd.MM.yyyy',lang:'en'})" value="${START_DATE}"/>~
						<input type="text" id="seach_END_DATE" name="seach_END_DATE" class="Wdate" onClick="WdatePicker({dateFmt:'dd.MM.yyyy',lang:'en'})" value="${END_DATE}"/>
					</td>
				</tr>
				<tr>	
				    <td><!--班组类型--><spring:message code="ar.viewArBaseEmpInfoList.BANZULEIXING.b" /></td>
					<td>
						<%-- <ait:SelectSyCodeByCpnyID name="seach_SHIFT_NO" parentNo="400223" cnpyID="${LoginUser.cpnyId}" limit="all" selected="${SHIFT_NO }" /> --%>
						<select name="seach_SHIFT_NO" id="seach_SHIFT_NO">
							<option value=""><spring:message code="hr.viewCondSql.title.QINGXUANZE"/><!--请选择--></option>
							<c:forEach items="${shiftList}" var="result">
								<option value="${result.SHIFT_NAME}" name="${result.SHIFT_NAME}" <c:if test="${result.SHIFT_NAME eq SHIFT_NAME}">selected="selected"</c:if>>${result.SHIFT_NAME}</option>
							</c:forEach>
						</select>
					</td>				
					<td><!-- 加班类型 --><spring:message code="ess.infoApply.overtime_type" /></td>
					<td>
					<ait:SelectSyCodeByCpnyID name="seach_OT_TYPE_CODE" parentNo="31" selected="${OT_TYPE_CODE}" limit="ALL"/>
					</td>	
					<td><!--审批状态--><spring:message code="ess.infoApply.approval_status" /> </td>
					<td>
						<ait:SelectSyCodeByCpnyID name="seach_AFFIRM_FLAG" parentNo="14014304" selected="${AFFIRM_FLAG}" limit="ALL"/>
					</td>					
				</tr>
				<!--<tr>
					<td> 人事确认状态 <spring:message code="ess.title.RENSHIQUERENZHUANGTAI" /></td>
					<td>
					<select name="seach_CONFIRM_FLAG">
						<option value=""<c:if test="${CONFIRM_FLAG == null}">selected</c:if>> 全部 <spring:message code="org.title.ALL" /></option>
						<option value="0"<c:if test="${CONFIRM_FLAG == '0'}">selected</c:if>> 未确认<spring:message code="ess.title.WEIQUEREN" /></option>
						<option value="1"<c:if test="${CONFIRM_FLAG == '1'}">selected</c:if>> 通过<spring:message code="ess.infoApply.adopt" /></option>
						<option value="2"<c:if test="${CONFIRM_FLAG == '2'}">selected</c:if>> 否决<spring:message code="ess.infoApply.veto" /></option> 
					</select>
					</td>
				</tr>-->
			</table>
		</div>
	</form>
</div>
<div id="viewApplyAttenBatch" class="pageHeader" >
    <div class="searchBar">
			<table class="searchContent">
			    <tr>
			       <td><!--加班状态--><spring:message code="ess.title.JIABANZHUANGTAI" /></td>
				   <td>
						<ait:SelectSyCodeByCpnyID name="OT_TYPE_CODE" parentNo="31" disabled="true"/>	
				   </td>
				   <td><!--加班日期--><spring:message code="ess.infoApply.attendance_date" /> </td>
				   <td>
				       <input type="text" name="OT_FROM_DATE" id="OT_FROM_DATE"  class="Wdate" onClick="WdatePicker({dateFmt:'dd-MM-yyyy',lang:'en',onpicked:getDefaultOtTimeSST})" value=""/>
				   </td>
				   <td><!--开始时间--><spring:message code="ess.infoApply.title.startTime" /></td>
				   <td>
						<ait:time name="OT_FROM_TIME"  spacing="15"   selected=""/>
					</td>
					<td><!--结束时间--><spring:message code="ess.infoApply.end_time" /></td>
					<td>
						<ait:time name="OT_TO_TIME"  spacing="15"  selected=""/>
					</td>
					<td><!--原因--><spring:message code="hrm.empinfo.reason" /></td>
					<td>
						<input type="text" id="APPLY_OT_REMARK" name="APPLY_OT_REMARK"  value=""/>
					</td >
					
				</tr>
			</table>
			<div class="subBar">
				<ul class="toolBar">
	             <li>
	             <a class="buttonActive" onclick="otAffirm_fillItem();"><span><!--全部反应--><spring:message code="ess.message.all_reaction" /></span></a>
	             </li>
				</ul>
			</div>
	</div>
</div>
<div class="pageContent" >
<div class="formBar">
	<ul class="toolBar">
	    <li><a class="buttonActive" id="viewApplyOTBatchInfoHAE_Search" href="#"><span><!--查询--><spring:message code="org.title.SELECT" /></span></a></li>
	    <li><a class="buttonActive" onclick="addOtOverApplyAffirm()"><span><!--添加--><spring:message code="ess.empInfo.insert" /></span></a></li>
		<li><a class="buttonActive" onclick="delOtApplyCallback(0,'delOtApplyAffirmForm',DWZ.ajaxDone)"><span><!--删除--><spring:message code="ess.empInfo.Delete" /></span></a></li>
		<li><a class="buttonActive" onclick="saveApplyOTBatchInfo()"><span><!--保存--><spring:message code="ar.viewempcalender.title.save" /></span></a></li>
		<li><a class="buttonActive" href="/pa/excelExport/downloadExcelOtApply?file=OtApply_add" ><span><!--模板下载--><spring:message code="ess.message.template_download" /></span></a></li>
		<li><a class="buttonActive" onclick="excelimport_ess3458()"><span><!--Excel导入--><spring:message code="ess.infoApply.EXCEL_IN" /></span></a></li>
		<c:if test="${LoginUser.language ne 'ko'}">
			<li><a class="buttonActive" onclick="downloadExcel('viewApplyOTBatchInfoHAE','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=358','/ess/infoApply/viewApplyOTBatchInfoHAE?firstFlag=N')"><span><!--导出到Excel--><spring:message code="hrm.empinfo.EXPORT" /></span></a></li>	
		</c:if>
		<c:if test="${LoginUser.language eq 'ko'}">
			<li><a class="buttonActive" onclick="downloadExcel('viewApplyOTBatchInfoHAE','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=324','/ess/infoApply/viewApplyOTBatchInfoHAE?firstFlag=N')"><span><!--导出到Excel--><spring:message code="hrm.empinfo.EXPORT" /></span></a></li>	
		</c:if>
	</ul>
</div>
	<form name="delOtApplyAffirmForm" id="delOtApplyAffirmForm" method="post" action="/ess/infoApply/delLOvertimeApplyInBatch" 
	  onsubmit="return delOtApplyCallback(this, navTabAjaxDone);">      
	  <input type="hidden" id="nullOTTSTOAffirmListCnt" value="${nullOTTSTOAffirmListCnt}">
	  <%-- <div class="user_table" style="font:bold 12px/20px arial,sans-serif;">Total:${nullOTTSTOAffirmListCnt}</div>  --%>             
		<table class="orderList" width="3500px" id="otOverAffirmLBatchTable">
			<thead>
			    <tr>
				    <th rowspan="2" width="5px"><!--NO-->NO
					</th>
					<th rowspan="2" ><input type="checkbox" class="checkboxCtrl" group="c2" />
				    </th>
				    <th rowspan="2" width="200px"><!--姓名--><spring:message code="ess.infoApply.NAME" />
					</th >
				    <th rowspan="2" width="120px" class="titleColor"><!--社号--><spring:message code="ess.infoApply.EMPID" />
					</th>
					<th  rowspan="2" width="220px"><!--部门--><spring:message code="ess.infoApply.DEPT" />
					</th>
					<th  rowspan="2" width="140px"><!-- 班组 --><spring:message code="hr.viewPersonalInfo.title.banzu"/>
					</th>
					<th rowspan="2" width="120px" class="titleColor"><!--日期--><spring:message code="ess.infoApply.attendance_date" />
					</th>
					<th colspan="13" ><!--申请--><spring:message code="ess.infoApply.title.apply" />
					</th>
					<th rowspan="2"  width="300px" class="titleColor"><!--原因--><spring:message code="ess.infoApply.Reason" />
					</th>
					<th colspan="2"><!--加班累计--><spring:message code="ess.title.JIABANLEIJI" />
					</th>
					<%-- <th colspan="2">
						<!--加班上限--><spring:message code="ar.viewAdjustLeaveTSTOBatchList.JIABANSHANGXIAN.b" />
					</th> --%>
				    <th rowspan="2" width="560px"><!--审批者--><spring:message code="hrm.contractInfo.APPROVAL_PERSON" />
					</th>
					<th rowspan="2"  width="160px;"><!--审批状态--><spring:message code="ess.infoApply.approval_status" />
					</th>
					<th rowspan="2" width="220px"><!--创建者--><spring:message code="hrm.contract.creator" />
					</th>
				</tr>
				<tr>
					<%-- <th  width="160px">
						<!--上班时间--><spring:message code="ess.infoApply.work_time" />
					</th>
					<th  width="160px">
						<!--下班时间--><spring:message code="ess.infoApply.out_work_time" />
					</th> --%>
					<th  width="100px">
						<!--进门时间--><spring:message code="ess.infoApply.in_door_time" />
					</th>
					<th  width="100px">
						<!--出门时间--><spring:message code="ess.infoApply.out_door_time" />
					</th>
					<th  width="100px" class="titleColor">
						<!--开始日期--><spring:message code="public.title.startDate" />
					</th>
					<th  width="140px" class="titleColor">
						<!--开始时间--><spring:message code="ess.infoApply.title.startTime" />
					</th>
					<th  width="100px" class="titleColor">
					   <!--结束日期--><spring:message code="public.title.endDate" />
					</th>
					<th  width="140px" class="titleColor">
					   <!--结束时间--><spring:message code="ess.infoApply.end_time" />
					</th>
					<th width="120px">
					  <!--加班时长--><spring:message code="ess.infoApply.overtime_hours" />
					</th>
					<th width="80px" class="titleColor">
						<!--扣除吃饭--><spring:message code="ess.viewPiciOtAffirmLBatchList.DEDUCT_MEAL_TIME.b" />&nbsp;<input type="checkbox" group="DEDUCT_YN" onclick="batchCheckedAndCallength(this)" style="vertical-align:middle"/>
					</th>
					<th width="80px" class="titleColor">
						<!--跨天--><spring:message code="ess.title.KUATIAN" />
					</th>
					<th  width="80px" class="titleColor">
						<!-- 用车--><spring:message code="ess.title.USE_CAR"/>&nbsp;<input type="checkbox" group="USECAR_YN" onclick="batchChecked(this)" style="vertical-align:middle"/>
					</th>
					<th  width="80px" class="titleColor">
					<spring:message code="ess.title.NAME_CAR"/><!-- name car-->
					</th>
					<th  width="120px" class="titleColor">
					<spring:message code="ess.title.ADDRESS_CAR"/><!-- address car-->
					</th>
					<!--<th width="30px" class="titleColor">
					   调休<spring:message code="ar.viewArAnnualStandard.title.tiaoxiu" />
					</th>
					<th width="30px" class="titleColor">
						特殊<spring:message code="ess.title.TESHU" />
					</th>
					-->
					<th width="150px">
					        <!--加班状态--><spring:message code="ess.title.JIABANZHUANGTAI" />
					</th>
					<th  width="70px">
						<!--本年--><spring:message code="ess.viewPiciOtAffirmBatchList.BENNIAN.b" />
					</th>
					<th  width="80px">
						<!--本月--><spring:message code="ess.viewPiciOtAffirmBatchList.BENYUE.b" />
					</th>
				</tr>
			</thead>
			<tbody>
                 <c:forEach items="${nullOTTSTOAffirmList}" var="otApply" varStatus="i">
					<tr target="sid" rel="${admin.personId}">
					    <td  style="text-align: center">${i.count}</td>
					    <td  style="text-align: center">
					    <c:if test="${otApply.AFFIRM_FLAG ne '14014309' and otApply.AFFIRM_FLAG ne '14014310'}">
					         <input type="checkbox" id="c2_${i.index}" name="c2" value="${otApply.APPLY_NO}" />
					    </c:if>
					    <c:if test="${otApply.AFFIRM_FLAG eq '14014309' or otApply.AFFIRM_FLAG eq '14014310'}">
					         <input type="checkbox" id="c2_${i.index}" name="c2" value="${otApply.APPLY_NO}" disabled />
					    </c:if>
					    </td>
					    <td style="text-align: center; cursor: pointer; color: blue;" id="LOCAL_NAME_${i.index}" sysIndex="${i.index}" <c:if test='${otApply.PERSON_ID ne null}'> onclick='javascript:changeURL_ess3458(${otApply.APPLY_NO });'</c:if> >${otApply.LOCAL_NAME}</td>
					    <td style="text-align: center" id="EMPID_${i.index}" <c:if test='${otApply.PERSON_ID eq null}'>sysLog="lookUp"</c:if> sysIndex="${i.index}" sysPersonId="${otApply.PERSON_ID}" >${otApply.EMPID}</td>
					    <td style="text-align: center" id ="DEPT_NAME_${i.index}" sysIndex="${i.index}">${otApply.DEPTNAME}</td>
					    <td style="text-align: center" id ="SHIFT_NAME_${i.index}" sysIndex="${i.index}">${otApply.SHIFT_NAME} (${otApply.SHIFT_TIME })</td>
					     <input type="hidden" id="OT_POST_FAMILY_${i.index}" value="${otApply.POST_FAMILY}">
					    <td style="text-align: center;" sysLog="date" sysIndex="${i.index}" format="dd-MM-yyyy" id="APPLY_OT_DATE_${i.index}" sysFlag="2">${otApply.APPLY_OT_DATE}</td>
					    <%-- <td  style="text-align: center">
					      <span id="SHIFT_START_TIME_${i.index}">${otApply.SHIFT_START_TIME}</span> 
					    </td>
					    <td  style="text-align: center">
					       <span id="SHIFT_END_TIME_${i.index}">${otApply.SHIFT_END_TIME}</span>
					    </td> --%>
					    <td  style="text-align: center">
					      <span id="INDOOR_TIME_${i.index}">${otApply.INDOOR_TIME}</span>
					    </td>
					    <td  style="text-align: center">
					      <span id="OUTDOOR_TIME_${i.index}">${otApply.OUTDOOR_TIME}</span>
					    </td>
					    <td style="text-align: center;" sysLog="date" sysIndex="${i.index}" format="dd-MM-yyyy" id="OT_FROM_DATE_${i.index}" sysFlag="2">${otApply.OT_FROM_DATE}</td>
					    <td style="text-align: center;" sysLog="select" sysIndex="${i.index}" id="OT_FROM_TIME_${i.index}" sysValue="${TIME_STR}" sysFlag="OT_TIME">${otApply.OT_FROM_TIME}</td>
					    <td style="text-align: center;" sysLog="date" sysIndex="${i.index}" format="dd-MM-yyyy" id="OT_TO_DATE_${i.index}" sysFlag="2">${otApply.OT_TO_DATE}</td>
					    <td style="text-align: center;" sysLog="select" sysIndex="${i.index}" id="OT_TO_TIME_${i.index}" sysValue="${TIME_STR}" sysFlag="OT_TIME">${otApply.OT_TO_TIME}</td>
					   
					    <td  style="text-align: center" id="OT_APPLY_HOUR_TEXT_${i.index}">
					   		 ${otApply.OT_APPLY_HOUR}<!--小时-->&nbsp<spring:message code="ar.viewitemparameter.title.xiaoshi" />
					    </td>
					     <input type="hidden" id="OT_APPLY_HOUR_${i.index}" value="${otApply.OT_APPLY_HOUR}">
					    <td  style="text-align: center">
					       <input type="checkbox" id="DEDUCT_YN_${i.index}" name="DEDUCT_YN" onclick="updateChecked(${i.index});otAffirm_callength(${i.index},2);" <c:if test="${otApply.DEDUCT_YN eq 1}"> checked="checked"</c:if> value="${otApply.DEDUCT_YN}">
					    </td>
					    <td  style="text-align: center">
					       <input type="checkbox" id="OFFSET_YN_${i.index}" onclick="updateChecked(${i.index})" <c:if test="${otApply.OFFSET_YN eq 1}"> checked="checked"</c:if> value="${otApply.OFFSET_YN}">
					    </td>
					    <td  style="text-align: center">
					       <input type="checkbox" id="USECAR_YN_${i.index}" name="USECAR_YN" onclick="updateChecked(${i.index})" <c:if test="${otApply.USECAR_YN eq 1}"> checked="checked"</c:if> value="${otApply.USECAR_YN}">
					    </td>
					    <td style="text-align: center;" sysLog="select" sysIndex="${i.index}" id="CAR_ADDRESS_${i.index}" sysValue='${qwer}'>${otApply.CAR_ADDRESS_NAME }</td>
					    <td style="text-align: center;" sysLog="select" sysIndex="${i.index}" id="CAR_ADDRESS_DETAIL_${i.index}" sysValue='${acbd}'>${otApply.CAR_ADDRESS_DETAIL_NAME }</td>
					    <!--<td  style="text-align: center">
					       <input type="checkbox" id="ADJUST_YN_${i.index}"onclick="otAffirm_callength(${i.index},2)"<c:if test="${otApply.ADJUST_YN eq 1}">checked="checked"</c:if> value="${otApply.ADJUST_YN}">
					    </td>
					    <td  style="text-align: center">
					       <input type="checkbox" id="SPECIAL_YN_${i.index}" onclick="otAffirm_callength(${i.index},2)" <c:if test="${otApply.SPECIAL_YN eq 1}">checked="checked"</c:if> value="${otApply.SPECIAL_YN}">
					    </td>
					    -->
					    <td style="text-align: center;" id="OT_TYPE_CODE_${i.index}">${otApply.OT_TYPE_CODE_NAME}</td>
					    <input type="hidden" id="OT_TYPE_CODE_NO_${i.index}" value="${otApply.OT_TYPE_CODE}" />
					    <td sysLog="text" sysIndex="${i.index}" id="APPLY_OT_REMARK_${i.index}">${otApply.APPLY_OT_REMARK}</td> 
					    <td  style="text-align: center" id="OT_TOTAIL_${i.index}">
					      ${otApply.OT_TOTAIL}
					    </td>
					    <td  style="text-align: center" id="OT_TOTAIL_MONTH_${i.index}">
					      ${otApply.OT_TOTAIL_MONTH}
					    </td>
					    <input type="hidden" id="OT_LIMIT_MONTH_${i.index}" value="${otApply.OT_LIMIT_MONTH}">
					    <input type="hidden" id="OT_LIMIT_YEAR_${i.index}" value="${otApply.OT_LIMIT_YEAR}">
					    <input type="hidden" id="AR_SHIFT_END_TIME_${i.index}" value="${otApply.AR_SHIFT_END_TIME }">
					    <%-- <td  style="text-align: center" id="OT_TOTAIL_LIMIT_${i.index}">
					      200
					    </td>
					    <td  style="text-align: center" id="OT_TOTAIL_MONTH_LIMIT_${i.index}">
					      30
					    </td> --%>
					    <td  style="text-align: center" id="OT_AFFIRMOR_${i.index}">
					    	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="addApplyOtOverAffirm_list_${i.index}">
					        </table>
					    </td>
					    <input type="hidden" name="applyOtOverCount${i.index}" id="applyOtOverCount${i.index}" value="1">
					    <td  style="text-align: center">
					      ${otApply.AFFIRM_FLAG_NAME}
					      <%-- &nbsp;<c:if test="${otApply.CONFIRM_FLAG ne '1' and otApply.CONFIRM_FLAG ne '2' }"><!--人事未确认--><spring:message code="ess.title.WEIQUEREN" /></c:if><c:if test="${otApply.CONFIRM_FLAG eq '1' }"><!--人事通过--><spring:message code="ess.title.RENSHITONGGUO" /></c:if><c:if test="${otApply.CONFIRM_FLAG eq '2' }"><!--人事否决--><spring:message code="ess.title.RENSHITONGGUO" /></c:if> --%>
					    </td>	
					    <td  style="text-align: center">
					      ${otApply.CREATED_BY}
					    </td>
					    <input type="hidden" id="AFFIRM_FLAG_${i.index}" value="${otApply.AFFIRM_FLAG}">
					    <div id="modifyFlag_${i.index}" sysLog="modifyFlag" sysIndex="${i.index}" style="display:none;"></div>
					</tr>
				</c:forEach> 
			</tbody>
		</table>
		<a id="onckOt" name="onckOt"  href="" lookupGroup="person" rel="submitKeyClick_apply_Ot_affirm"></a>
	</form>
	<a id="onckSche" name="onckSche"  href="" lookupGroup="person"></a>
</div>