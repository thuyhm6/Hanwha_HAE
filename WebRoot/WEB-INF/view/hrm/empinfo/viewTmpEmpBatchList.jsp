<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="script/jquery.js"></script>
<script type="text/javascript" src="script/jquery.easydrag.js"></script>
<script>
	function tempEmpApplyCallback(OP_FLAG,form,callback) {
		$("#BATCH_EMP_OP_FLAG").val(OP_FLAG);
		var $form=null;
		if($('#'+form).length>0)
			$form=$('#'+form);
		else
	 		$form = $(form);
		
		if (!$form.valid()) {
			return false;
		}
	    var checked=false;
		var ids= document.getElementsByName("tempEmpCheck");
		for(var i=0;i<ids.length;i++){
			if(ids[i].checked){
				checked=true;
			}
		}
		if(!checked){
			alertMsg.error('<spring:message code="alert.message.ess.affirmApply.chooseApplyRecordFirstForBatch"/>'); 
			return false;
		}
	    $form.attr("action","/hrm/empinfo/tempEmpApplyInBatch");
	    var msg = "确定要删除吗？";
	    if(OP_FLAG == 1){
	        var msg = "确定要提交吗？";
	    }
	    alertMsg.confirm(msg,{okCall:function(){
	    	if(OP_FLAG == 1){
	    		viewTempEmpBatchReq();
	    	}else{
				$.ajax({
					type: form.method || 'POST',
					url:$form.attr("action"), 
					data:$form.serializeArray(),
					dataType:"json",
					cache: false,
					success: function(data){ //请求成功后处理函数。
						if(data.statusCode=="200"){
							navTabSearch("viewTmpEmpBatchList");
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
	    	}
	        }});
		return false;
	}
	
	function expEmpBatchExcel(){
		var url = "/hrm/empinfo/expEmpBatchTemp?navTabId=hr0517";
		document.getElementById("expEmpBatchExcel").href=encodeURI(url);
	}
	
	function impTmpEmpBatch(){
		$("#importExcelDialog_hr0517").attr('href','/pa/excelImport/importExcelData?importFunName=/impTmpEmpBatch');
		$("#importExcelDialog_hr0517").click();
	}

	function viewTempEmpBatchReq(){
		var params = $("#viewTmpEmpBatch").serialize();
		$("#hr0517Link").html("临时职人员批量申请");
		$("#dialog_hr0517").attr('href', "/hrm/empinfo/viewTempEmpBatchReqList?" + params+"&pageNum=1");
		$("#dialog_hr0517").attr('height', "600");
		$("#dialog_hr0517").attr('width', "1000");
		$("#dialog_hr0517").click();
	}
	
</script>

<a id="importExcelDialog_hr0517" href="#" target="dialog" mask="true"></a>
<a id="importExcel_ess0517" href="#" target="navTab" mask="true">
	<span style="display:none;">临时职导入结果</span>
</a>
<a id="dialog_hr0517" href="#" width="400" height="200" target="dialog" mask="true"><span
		id="hr0517Link" style="display: none"></span></a>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="/hrm/empinfo/viewTmpEmpBatchList" rel="pagerForm" method="post"
		id="viewTmpEmpBatchList" name="viewTmpEmpBatchList">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<c:if test="${authority ne '1'}">
					<td>申请人</td>
					<td>
						${admin.empID }/${admin.localName }
						<input type="hidden" id="seach_REQ_BY" name="seach_REQ_BY" value="${admin.personId }"/>
					</td>
					<td>
						部门
					</td>
					<td>
						${admin.content }
					</td>
					</c:if>
					<c:if test="${authority eq '1'}">
					<td>
						申请人
					</td>
					<td><input
						type="text" name="seach_REQ_BY" value="${searchMap.REQ_BY}" /></td>
					<td><!-- 部门： --> <spring:message
						code="hr.viewPersonalInfo.title.DEPTNAME" /> 
					</td>
					<td>
						<ait:deptList name="seach_DEPTNO" cpnyId="${defaultCpny}" id="viewApplyLeaveInfoList_seachDept"/>
						<ait:deptTreeIcon name="seach_DEPTNO" cpnyId="${defaultCpny}"   limit="hr" id="viewApplyLeaveInfoList_seachDept" selected="${searchMap.DEPTNO}"/></td>
					</c:if>
					<td><!-- 决裁状态 -->
						 审批状态
					</td>
					<td>
						 <select id="seach_AFFIRM_FLAG" name="seach_AFFIRM_FLAG">
							 <option value="">全部</option>
							 <option value="-1" <c:if test="${searchMap.AFFIRM_FLAG eq '-1'}">selected</c:if>>提交</option>
							 <option value="4" <c:if test="${searchMap.AFFIRM_FLAG eq '4'}">selected</c:if>>审批中</option>
							 <option value="1" <c:if test="${searchMap.AFFIRM_FLAG eq '1'}">selected</c:if>>通过</option>
							 <option value="2" <c:if test="${searchMap.AFFIRM_FLAG eq '2'}">selected</c:if>>否决</option>
						 </select>
					</td>
					<td>批次号</td>
					<td>
						<input type="text" id="seach_BATCH_NO" name="seach_BATCH_NO" value="${searchMap.BATCH_NO }"/>
						<input type="hidden" id="seach_FIRST_FLAG" name="seach_FIRST_FLAG" value="1" />
					</td>
				</tr>
				<tr>
					<td>
						申请日期
					</td>		
			    <td>
			        <input type="text" name="seach_FROM_TIME" class="date" format="yyyy-MM-dd" readonly="true" value="${searchMap.FROM_TIME}"/>
				    <a class="inputDateButton" href="javascript:;"></a>			   
			    </td>
                <td>
					~
                </td>                			     
				<td>
				    <input type="text" name="seach_TO_TIME" class="date" format="yyyy-MM-dd" readonly="true" value="${searchMap.TO_TIME}"/>
				    <a class="inputDateButton" href="javascript:;"></a>
				</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent">
					    <button type="submit">
					       <spring:message code="public.title.search"/>
					    </button>
				        </div>
				        </div>
				    </li>
				</ul>
			</div>
		</div>
	</form>
</div>

<div class="pageContent" >
<div class="formBar">
	<ul class="toolBar">
		<li>
		    <a class="buttonActive" id ="expEmpBatchExcel" onclick="expEmpBatchExcel();" href="#">
		    <span><spring:message code="pa.insurance.title.downloadImportTemplate"/><!--下载导入模板--></span>
		    </a>
		</li>
		<li>
		    <a class="buttonActive" onclick="impTmpEmpBatch();">
		    <span><spring:message code="ar.addempshift.title.excelimport"/><!-- EXCEL导入 --></span>
		    </a>
		</li>
		<li><a class="buttonActive" onclick="tempEmpApplyCallback(0,'viewTmpEmpBatch',DWZ.ajaxDone)"><span>删除</span></a></li>
		<li><a class="buttonActive" onclick="tempEmpApplyCallback(1,'viewTmpEmpBatch',DWZ.ajaxDone)"><span>提交</span></a></li>
	</ul>
</div>
	<form name="viewTmpEmpBatch" id="viewTmpEmpBatch" method="post"> 
		<table class="table" width="100%" layoutH="240" nowrapTD="false">
			<thead>
				<tr>
					<th width="20">
				    	<input type="checkbox" class="checkboxCtrl" group="tempEmpCheck" />
				    </th>
				    <th width="40" style="text-align: center"><!--工号-->
						批次号
					</th>
				    <th width="40" style="text-align: center"><!--申请人-->
						申请人
					</th>
					<th width="60" style="text-align: center"><!--申请日期-->
						申请日期
					</th>
					<th width="100" style="text-align: center"><!--申请日期-->
						申请部门
					</th>
					<th width="60" style="text-align: center"><!--详细查看-->
						审批详细
					</th>
					<th width="60" style="text-align: center"><!--决裁情况-->
						审批状态
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${tmpEmpAffirmList}" var="item" varStatus="i">			
					<tr target="sid" rel="${admin.personId}">
					    <td style="text-align: center">
					    	<c:if test="${item.AFFIRM_FLAG eq null}">
					        	<input type="checkbox" id="tempEmpCheck" name="tempEmpCheck" value="${item.BATCH_NO}" />
					        </c:if>
					    </td>
					    <td style="text-align: center">
							${item.BATCH_NO}
					    </td>
					    <td style="text-align: center">${item.LOCAL_NAME}</td>
					    <td style="text-align: center">${item.REQ_DATE}</td>
					    <td style="text-align: center">${item.DEPT_NAME}</td>
						<td style="text-align: center">
					    	<c:if test="${item.AFFIRM_FLAG ne null}">
							<a rel="leaveApplyAffirm" href="/hrm/empinfo/viewTempEmpBatchAffirmList?BATCH_NO=${item.BATCH_NO}&APPLY_NO=${item.REQ_ID}&pageNum=1" title="决裁详情"
					          target="navTab" rel="viewTempEmpBatchAffirmInfo">查看</a>
						    </c:if>
					    </td>
						<td style="text-align: center">
							<c:if test="${item.AFFIRM_FLAG eq null}">
								<font color="blue">暂存</font>
							</c:if>
							<c:if test="${item.AFFIRM_FLAG eq '-1'}">
								<font color="back">提交</font>
							</c:if>
							<c:if test="${item.AFFIRM_FLAG eq '1'}">
								<font color="green">通过</font>
							</c:if>
							<c:if test="${item.AFFIRM_FLAG eq '2'}">
								<font color="red">否决</font>
							</c:if>
							<c:if test="${item.AFFIRM_FLAG eq '4'}">
								<font color="grey">审批中</font>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<input type="hidden" id="BATCH_EMP_OP_FLAG" name="BATCH_EMP_OP_FLAG" value="0" />
	</form>
    <c:set value="/hrm/empinfo/viewTmpEmpBatchList" var="pageUrl"/>
	<%@ include file="/WEB-INF/view/inc/initPagination2.jsp"%>
</div>