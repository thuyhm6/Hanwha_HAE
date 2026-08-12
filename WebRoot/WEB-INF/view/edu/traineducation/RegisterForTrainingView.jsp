<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$("#RegisterForTraining_save",$.pdialog.getCurrent()).click(function(){
		var $form = $("#RegisterForTraining_form",$.pdialog.getCurrent());
		//确定要保存吗？
		var affirmJsonData = '[';
		var tb2 = document.getElementById("addApplyLeaveAffirm_list");
	   	if(tb2.rows.length == 0){
	   		alertMsg.error("<spring:message code='alert.message.pleaseFirstSetRuler.b' />");//请先设置决裁者
			return false;
	   	}else{
            var affirms = $("[name ='ATT_AFFIRMOR_ID']",$.pdialog.getCurrent());
            for(var i=0;i<affirms.length;i++){
            	if (affirmJsonData.length > 1) {
            		affirmJsonData += ',{';
				} else {
					affirmJsonData += '{';
				}
               var rowId = affirms[i].id.substring(32);
               if(affirms[i].value == "" || affirms[i].value == null){
            	   alertMsg.error("<spring:message code='alert.message.Please_Affirmor_Complete.b' />");//请将裁决者信息补充完整!
                   return false;
               }
               affirmJsonData += ' "AFFIRMOR_ID": "' + affirms[i].value + '" ,';
               affirmJsonData += ' "APPROVE_STATE": "' + $("#APPROVE_STATE"+rowId,$.pdialog.getCurrent()).val() + '",';
               affirmJsonData += ' "AFFIRM_LEVEL": "' + $("#rowIndex_"+rowId,$.pdialog.getCurrent()).text() + '",';
               affirmJsonData += ' "AFFIRM_TYPE": "' + $("#approvType"+rowId,$.pdialog.getCurrent()).val() + '"';
               affirmJsonData += '}';
            }
		}
		affirmJsonData += ']';
        
		var jsonData = $form.serializeArray();
		jsonData.push({ name: 'affirmJsonData', value: affirmJsonData });
		alertMsg.confirm("<spring:message code='ess.message.confirm_sava'/>",
				{okCall:function(){
						$.ajax({
							type:'POST',
							url:$form.attr("action"),
							data:jsonData,
							dataType:"json",
							cache : false,
							success: dialogAjaxDone,
							error: DWZ.ajaxError
						});
					}});
		return false;
	});
	function finalLIAISON() {
		var check = $('#final').prop('checked');
		if (check == true) {
			$('#CAR_RETURN').attr('value', 'Y');
		} else {
			$('#CAR_RETURN').attr('value', 'N');
		}
		
	}
	function getAffirmor(){
		var applyTypeCode = $("#APPLY_TYPE_CODE",$.pdialog.getCurrent()).val();
		var applyLength = $("#shenqingshichang",$.pdialog.getCurrent()).val();
		var applyTypeNo = $("#APPLY_TYPE_NO",$.pdialog.getCurrent()).val();
		var htm = '';
		$.ajax({
			type: 'POST',
			url: '/ess/infoApplyAttendance/viewAffirmorList',
			data:[{ name: 'applyTypeCode', value: applyTypeCode },
				{ name: 'applyLength', value: applyLength },
				{ name: 'applyTypeNo', value: applyTypeNo }],
			dataType:"json",
			cache: false,
			async:false,
			success: function(data){
				if(data.affirmorList.length>0){
					for(var i=0;i<data.affirmorList.length;i++){
						var count = $("#applyLeaveCount").val();
						htm +='<tr id="rowIdApplyLeave'+ count +'"><td class="td_type" style="text-align: center" width="5%" id="rowIndex_'+ count +'"><span name="rowIndex">'+(i+1)+'</span></td>';
				        htm +='<td class="td_type" style="text-align: center" width="20%">';
				        htm +='<input id="dwz.person.AFFIRMOR_IDApplyLeave' + count + '" name="ATT_AFFIRMOR_ID" value="'+ data.affirmorList[i].AFFIRMOR_ID +'" type="hidden" />';
				        htm += data.affirmorList[i].LOCAL_NAME;
				        htm +='</td>';
						htm +='<td class="td_type" style="text-align: center" width="20%">';
						htm += data.affirmorList[i].EMPID;
						htm +='</td>';
						htm +='<td class="td_type" style="text-align: center" width="20%">';
						htm += data.affirmorList[i].DEPTNAME;
						htm +='</td>';
						htm +='<td class="td_type" style="text-align: center" width="20%">';
						htm += data.affirmorList[i].POSITION_NAME;
						htm +='</td>';
						<c:if test="${LoginUser.cpnyId eq 'HFSV'}">
						htm +='<td class="td_type" style="text-align: center" width="5%">';
						htm +='<select id="approvType' + count + '" name="approvType' + count + '">';
						htm +='<option value="1" ><!--审批 --><spring:message code="hr.contract.title.shenpi"/></option>';
						htm +='<option value="3" ><!--通知 --><spring:message code="ess.infoApply.gonggao"/></option> ';
						htm +='</td>';
						htm +='<td class="td_type" style="text-align: center" width="15%">';
						htm +='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
						htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyLeave(' + count + ')"/>&nbsp;&nbsp;&nbsp;';
						htm +='<img src="/resources/images/-.gif" title="<spring:message code="button.delete"/>"';	
						htm +='border="0" align="absmiddle" style="cursor:hand" onclick="javaScript:document.all.addApplyLeaveAffirm_list.deleteRow(event.srcElement.parentElement.parentElement.rowIndex);changeApplyLeaveLevel();"/></td>';
						</c:if>
						htm +='</tr>';
						$("#applyLeaveCount",$.pdialog.getCurrent()).val(++count) ;
					}
					$("#addApplyLeaveAffirm_list",$.pdialog.getCurrent()).html(htm);
				}else{
					$("#addApplyLeaveAffirm_list",$.pdialog.getCurrent()).html('');
				}
			},
			error: DWZ.ajaxError
		});
	}
	
	function addRowByIDApplyBusFirst(){
		var count = parseInt($("#applyLeaveCount").val());
		var htm  ='<tr id="rowIdApplyLeave'+ count +'"><td class="td_type" style="text-align: center" width="5%" id="rowIndex_'+ count +'"><span name="rowIndex">'+(i+1)+'</span></td>';
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.EMPNAMEApplyLeave' + count + '"  type="text" style="text-align: center"  size="24" disabled="disabled"/>';
		htm +='</td>';        
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.AFFIRMOR_IDApplyLeave' + count + '" name="ATT_AFFIRMOR_ID" value="" type="hidden"/>';
		htm +='<input id="dwz.person.EMPINFOApplyLeave' + count + '" name="empid" alt="<spring:message code="evs.affirm.please_input_enter.e"/>" type="text" style="text-align: center" size="25" class="required" lookupGroup="person" onkeydown="submitKeyClick_applyLeave(this,' + count + ',event)"/>';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.DEPTNAMEApplyLeave' + count + '"  type="text" style="text-align: center"  size="30" disabled="disabled"/>';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.POSITIONApplyLeave' + count + '"  type="text" style="text-align: center"  size="30" disabled="disabled"/>';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="5%">';
		htm +='<select id="approvType' + count + '" name="approvType">';
		htm +='<option value="1" ><!--审批 --><spring:message code="hr.contract.title.shenpi"/></option>';
		htm +='<option value="3" ><!--通知 --><spring:message code="ess.infoApply.gonggao"/></option> ';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="10%">';
		htm +='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
		htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyLeave(' + count + ')"/>&nbsp;&nbsp;&nbsp;';
		htm +='<img src="/resources/images/-.gif" title="<spring:message code="button.delete"/>"';	
		htm +='border="0" align="absmiddle" style="cursor:hand" onclick="javaScript:document.all.addApplyLeaveAffirm_list.deleteRow(event.srcElement.parentElement.parentElement.rowIndex);changeApplyLeaveLevel();"/></td></tr>';
	        
		var tb2 = document.getElementById("addApplyLeaveAffirm_list");
		if(tb2.rows.length == 0){
		$("#addApplyLeaveAffirm_list").html(htm);
	} else{
	   	   	//当前行之后插入一行
		$("#" + tb2.rows[0].id,$.pdialog.getCurrent()).before(htm);
	}
	$("[id='dwz.person.EMPINFOApplyLeave" + count + "']",$.pdialog.getCurrent()).inputAlert();
	changeApplyLeaveLevel();
	$("#applyLeaveCount").val(++count);
	}

	function addRowByIDApplyLeave(currentRowID){
		var count = parseInt($("#applyLeaveCount").val());
		var htm  ='<tr id="rowIdApplyLeave'+ count +'"><td class="td_type" style="text-align: center" width="5%" id="rowIndex_'+ count +'"><span name="rowIndex">'+(i+1)+'</span></td>';
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.EMPNAMEApplyLeave' + count + '"  type="text" style="text-align: center"  size="24" disabled="disabled"/>';
		htm +='</td>';        
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.AFFIRMOR_IDApplyLeave' + count + '" name="ATT_AFFIRMOR_ID" value="" type="hidden"/>';
		htm +='<input id="dwz.person.EMPINFOApplyLeave' + count + '" name="empid" type="text" style="text-align: center" alt="<spring:message code="evs.affirm.please_input_enter.e"/>" size="25" class="required" lookupGroup="person" onkeydown="submitKeyClick_applyLeave(this,' + count + ',event)"/>';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.DEPTNAMEApplyLeave' + count + '"  type="text" style="text-align: center"  size="30" disabled="disabled"/>';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="20%">';
		htm +='<input id="dwz.person.POSITIONApplyLeave' + count + '"  type="text" style="text-align: center"  size="30" disabled="disabled"/>';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="5%">';
		htm +='<select id="approvType' + count + '" name"approvType">';
		htm +='<option value="1" ><!--审批 --><spring:message code="hr.contract.title.shenpi"/></option>';
		htm +='<option value="3" ><!--通知 --><spring:message code="ess.infoApply.gonggao"/></option> ';
		htm +='</td>';
		htm +='<td class="td_type" style="text-align: center" width="10%">';
		htm +='<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>"';	
		htm +='border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyLeave(' + count + ')"/>&nbsp;&nbsp;&nbsp;';
		htm +='<img src="/resources/images/-.gif" title="<spring:message code="button.delete"/>"';	
		htm +='border="0" align="absmiddle" style="cursor:hand" onclick="javaScript:document.all.addApplyLeaveAffirm_list.deleteRow(event.srcElement.parentElement.parentElement.rowIndex);changeApplyLeaveLevel();"/></td></tr>';
	//当前行之后插入一行
	 $("#rowIdApplyLeave" + currentRowID,$.pdialog.getCurrent()).after(htm);
		$("[id='dwz.person.EMPINFOApplyLeave" + count + "']",$.pdialog.getCurrent()).inputAlert();
	 changeApplyLeaveLevel();
		$("#applyLeaveCount").val(++count) ;
	}

	function changeApplyLeaveLevel(){
			var tb2 = document.getElementById("addApplyLeaveAffirm_list");
		var rowCount = tb2.rows.length;
		for(var m=0;m<rowCount;m++){
		tb2.rows[m].cells[0].innerHTML = m+1;
	}
	}
	
	var keyCodeInit=0;
	function submitKeyClick_applyLeave(obj,index,event){
	var localName = '';
	var idcardNo = '';
	var navTabId = '';
	var e= event ? event : window.event; 
	var keyCode = e.which ? e.which : e.keyCode;
if(keyCode==13){
	keyCodeInit=keyCode;
var empid=obj.value;		
var empIdStr=obj.id.substring(11);
var personIdStr="AFFIRMOR_IDApplyLeave"+empIdStr.substring(17);
var empNameStr = "EMPNAMEApplyLeave"+empIdStr.substring(17);
var positionIdStr = "POSITIONApplyLeave"+empIdStr.substring(17);
var deptIdStr = "DEPTNAMEApplyLeave"+empIdStr.substring(17);
if(empid == ''){
	obj.value=" ";
	document.getElementById("onck").href=encodeURI(encodeURI("/ar/attendanceMintenance/viewAddAffirmList?isEmployeement=1&firstFlag=1&limit=super&pageNum=1"
			+'&seach_KEY='+empid
			+'&empidStr='+empIdStr
			+'&personidStr='+personIdStr
			+'&positionIdStr='+positionIdStr
			+'&deptIdStr='+deptIdStr
			+'&empNameStr='+empNameStr					
			));
	document.getElementById("onck").click();
}else{
		$.ajax({
		type: 'POST',
		url: encodeURI('/sys/affirm/getPersonCntByEmpid?EMPID='+empid ),
		dataType:"json",
		cache: false,
		success: function(jsonObject){
					if(jsonObject.perCnt != 1 ){
						document.getElementById("onck").href=encodeURI(encodeURI("/ar/attendanceMintenance/viewAddAffirmList?isEmployeement=1&limit=all&pageNum=1"
								+'&seach_KEY='+empid
								+'&empidStr='+empIdStr
								+'&personidStr='+personIdStr
								+'&positionIdStr='+positionIdStr
								+'&deptIdStr='+deptIdStr 
								+'&empNameStr='+empNameStr));
						document.getElementById("onck").click();
					}
					if(jsonObject.perCnt==1){
						$("[id='dwz.person.EMPNAMEApplyLeave" + index + "']").val(jsonObject.empName);
					  	$("[id='dwz.person.EMPINFOApplyLeave" + index + "']").val(jsonObject.empId);
					  	$("[id='dwz.person.AFFIRMOR_IDApplyLeave" + index + "']").val( jsonObject.personId);
					  	$("[id='dwz.person.POSITIONApplyLeave" + index + "']").val( jsonObject.POSITION_NAME);
					  	$("[id='dwz.person.DEPTNAMEApplyLeave" + index + "']").val( jsonObject.deptName);
					}
				},
		error: DWZ.ajaxError
	});
}
}
}
</script>
<div>
	<form id="RegisterForTraining_form" method="post" class="pageForm required-validate" action="/edu/traineducation/addRegisterForTraining">
		<input type="hidden" id="APPLY_TYPE"  name="APPLY_TYPE" value="1"/>
		<input type="hidden" id="AFFIRM_FLAG"  name="AFFIRM_FLAG" value="14014306"/>
		<input type="hidden" id="APPLY_AFFIRM_FLAG"  name="APPLY_AFFIRM_FLAG" value="14014306"/>
		<input type="hidden" id="APPLY_TYPE_NO"  name="APPLY_TYPE_NO" value="81006456"/>
		<input type="hidden" id="APPLY_TYPE_CODE"  name="APPLY_TYPE_CODE" value="81006456"/>
		<input type="hidden" id="APPLY_FLAG"  name="APPLY_FLAG" value="0"/>
		<input type="hidden" id="affirmorListCntTx" name="affirmorListCntTx" value="${affirmorListCntTx }"/>
		<input type="hidden" name="applyOtCountTx" id="applyOtCountTx" value="">

		<br/>
		<table id="eduTable" class="user_table" width="100%" border="1"
				cellpadding="2" cellspacing="1">
				<tr>
					<td class="td_title" width="1%">
						<spring:message code="ess.empInfo.apply_content"/> <spring:message code="hr.viewCondSql.title.PEIXUNXINXI"/>
					</td>
					<td class="td_type"  width="30%" colspan="3">
					<input type="text"  name="TRAINING_CONTENT" id="TRAINING_CONTENT" style="width:100%" >
					</td>
					</tr>
					<tr>
					<td class="td_title" width="1%">
						<spring:message code="hr.viewGoAbroad.title.PURPOSE"/> <spring:message code="hr.viewCondSql.title.PEIXUNXINXI"/>
					</td>
					<td class="td_type" width="30%" colspan="1" >
					<input type="text"  name="TRAINING_PURPOSE" id="TRAINING_PURPOSE"  style="width:100%">
					</td>
					<td class="td_title" width="1%">
						<spring:message code="edu.systemManager.PEIXUNLEIXING.a"/> <spring:message code="hr.viewCondSql.title.PEIXUNXINXI"/>
					</td>
					<td class="td_type" width="20%">
						<ait:SelectSyCodeByCpnyID name="TRAINING_TYPE" parentNo="1682" limit="all" />
					</td>
					</tr>
					<tr>
					<td class="td_type" width="1%" colspan="1" >
				       <spring:message code="empsubject.eduRm"/>
				    </td>
				   <td class="td_type"  width="20%" >
					<input type="text"  name="TRAINING_UNIT" id="TRAINING_UNIT"  style="width:100%" >
					</td>
					<td class="td_title" width="1%">
						<spring:message code="hr.viewTraining.title.INSTITUTION_NAME"/>
					</td>
					<td class="td_type"  width="20%" colspan="1" >
					<input type="text"  name="TRAINING_LOCATION" id="TRAINING_LOCATION"  style="width:100%" >
					</td>
				</tr>
				<tr>
					<td class="td_title" width="1%">
						<spring:message code="ess.infoApply.title.applyTime"/>
					</td>
					<td class="td_type" width="20%">
				        <input name="START_DATE" 
				        onClick="WdatePicker({dateFmt:'dd/MM/yyyy'})" id="START_DATE" type="text" value="" />
				    </td>
					<td class="td_title" width="1%">
						<spring:message code="ess.infoApply.title.endTime"/>
					</td>
					<td class="td_type" width="20%">
				        <input name="END_DATE" 
				        onClick="WdatePicker({dateFmt:'dd/MM/yyyy'})" id="END_DATE" type="text" value="" />
				    </td>
				</tr>
				<tr>
					<td class="td_title" width="1%">
					<spring:message code="ess.infoApply.withoutWork_days"/>
					</td>
					<td class="td_type"  width="20%" >
					<input type="text"  name="TRAIN_FEE" id="TRAIN_FEE"  >
					</td>
					<td class="td_title" width="1%">
						Unit/(VND/ USD)
					</td>
					<td class="td_type" width="20%">
						<select name="TRAIN_UNIT" id="TRAIN_UNIT">
							<option value="USD">
								USD
							</option>
							<option value="VND">
								VND
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="td_title" width="1%">
						Training Fee/Đơn giá 
					</td>
					<td class="td_type"  width="20%" >
					<input type="text"  name="TRAIN_PRICE" id="TRAIN_PRICE"  >
					</td>
					<td class="td_title" width="1%">
						Trainee Q'ty / Số lượng
					</td>
					<td class="td_type"  width="20%" >
					<input type="text"  name="TRAIN_TRAINEE" id="TRAIN_TRAINEE"  >
					</td>
				</tr>
				<tr>
					<td class="td_title" width="1%">
						Amount/ Thành tiền
					</td>
					<td class="td_type" width="20%">
						<input type="text" name="TRAIN_AMOUNT" id="TRAIN_AMOUNT"
							value="">
					</td>
					<td class="td_title" width="1%">
						Other fees/Chi phí khác
					</td>
					<td class="td_type" width="20%">
						<input type="text" name="TRAIN_FEES_OTHER"
							id="TRAIN_FEES_OTHER" value="" min="0">
					</td>
					
				</tr>
				<tr>
				<td class="td_title" width="1%">
					TOTAL FEES</td>
					<td class="td_type"  width="20%" >
					<input type="text"  name="TRAIN_FEES_TOTAL" id="TRAIN_FEES_TOTAL"  >
					</td>
				</tr>
				<tr>	
					<td class="td_title" width="1%">
						NOTE
					</td>
					<td class="td_type"  width="20%" colspan="3">
					<textarea class="textInput" style="width:600px;height:100px"  name="REMARK" id="REMARK"  ></textarea>
					</td>
				</tr>
			</table>

		<a id="oncksg" name="oncksg"  href="" lookupGroup="person"></a>
		<br/>
		<table class="user_table" width="100%">
				<tr>
					<td class="td_title"  style="text-align:center;" width="5%"><!--序号 --> <spring:message code="org.title.NO" /></td>
					<td class="td_title"  style="text-align:center;" width="20%"><!--决裁者 --> <spring:message code="sys.affirm.title.affirmPerson" /></td>
					<td class="td_title" style="text-align:center;" width="30%"><!--社号--> <spring:message code="hr.enpinfo.title.EMP.EMPNUMBER" /></td>
					<td class="td_title"  style="text-align:center;" width="15%"><!--部门 --> <spring:message code="hr.viewPersonalInfo.title.DEPTNAME" /></td>
					<td class="td_title" style="text-align:center;" width="30%"><!--职责 --> <spring:message code="hrm.contract.POSITION_NO" /></td>
					<c:if test="${LoginUser.cpnyId eq 'HAE'}">
									<td class="td_title" style="text-align:center;" width="5%"><!--决裁类型 --> <spring:message code="sys.affirm.title.affirmTypeNames" /></td>
								    <td class="td_title" style="text-align:center;" width="10%"><!--是否新增 --> <spring:message code="evs.viewRegPersonalProbation.SHIFOUXINZENG.a" />(<img src="/resources/images/+.gif" title="<spring:message code="button.add"/>" border="0" align="absmiddle" style="cursor:hand" onclick="addRowByIDApplyBusFirst()"/>)</td>
					</c:if>
				</tr>
				<tr>
					<td colspan="7">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" id="addApplyLeaveAffirm_list">
							<tbody id="rowIdApplyLeaveq">
							</tbody>
						</table>
				    	<input type="hidden" name="applyLeaveCount" id="applyLeaveCount" value="1">
				    	<a id="onck" name="onck"  href="" lookupGroup="person" rel="submitKeyClick_apply_Leave_affirm"></a>
				    				</td>
		    	</tr>
			</table>
		<div class="formBar">
			<ul>
				<li>
					<div class="button">
						<div class="buttonContent"><!--提交-->
							<button type="button" id="RegisterForTraining_save">
								<!--申请 --> <spring:message code="button.sys.affirm.save" />
							</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</form>
</div>