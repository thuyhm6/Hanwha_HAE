<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@page import="com.ait.sys.service.ToolMenuSer"%>
<%@page import="com.ait.sys.service.impl.ToolMenuSerImpl"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">
	var quanOrgno="";
	var quanOrg="";
	function xiugaiOrg(){
			if(quanOrgno!=""){
				$('#updateOrg').attr('href','/edu/traineducation/courseSubjectsInfo?SUBJECT_ID='+quanOrgno);
		}else{
			alert("<spring:message code='edu.systemManager.QINGXUANZEQIZHONGYIXIANG.a'/>");//请选择其中一项!
		}
	}
	function xuanzhongOrg(no,nono){
		var count="${courseSubjectsListCount}";
		for(var i=1;i<=count;i++){
			$('#listOrg_'+i).attr('style','');
		}
		$('#listOrg_'+no).attr('style','background:#aaccf6');
		$('#updateOrg').attr('href','/edu/traineducation/courseSubjectsInfo?SUBJECT_ID='+nono);
		$('#yinOrg').attr('style','display:none');
		$('#xianOrg').attr('style','');
		quanOrg=no;
		quanOrgno=nono;
	}
	function shanchuOrg(){
		if(quanOrgno!=""){
			$('#deleteOrg').attr('href','/edu/traineducation/deletecourseSubjects?SUBJECT_ID='+quanOrgno);
	}else{
		$('#deleteOrg').attr('href','/edu/traineducation/deletecourseSubjects?{Org}');
	}
  }
	function sousuoOrg(){
		$('#courseSubjects').submit();
	}
	
	$("#viewInfoTable",navTab.getCurrentPanel()).dataTable({"bPaginate": true,    //关闭分页
	    "bAutoWidth":false,//表格宽度不自动变化
	    "bProcessing":true,
	    "bLengthChange": true,  //关闭按多少条记录显示下拉框
	    "bFilter": true,   //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
	    "bSort": true,   //关闭排序功能
	    "bInfo": true,   //不显示datatables的信息（底部的页数，条目数信息）
	    "iDisplayLength": 50, //默认每页显示的记录数
	    "bScrollInfinite":true,
	    "scrollY": true,
	    "scrollX": true,
	    "orderClasses": false,
	    "order":[],//初始化不用自动排序
	    "scrollY": $(document.body).height() - 270,
	    "scrollCollapse": false,
	    "deferRender":true,
	    "fixedColumns":false,
	    "oLanguage": {//多语言配置
	        "sProcessing": "<spring:message code="hem.alert.empinfo.Is_loading"/>",//正在加载中......
	        "sZeroRecords": "<spring:message code="hem.alert.empinfo.not_find_relevant_data"/>",//查询不到相关数据！
	        "sEmptyTable": "<spring:message code="hrm.alert.empinfo.No_data_in_table"/>",//表中无数据存在！
	        "sSearch": "<spring:message code="hrm.alert.contractInfo.Rapid_screening"/>",//快速筛选
	        "sLengthMenu": "<spring:message code="hrm.alert.contractInfo.Record_page"/>",//每页 _MENU_ 条记录
	        "sInfo": "<spring:message code="hrm.alert.contractInfo.START_END_TOTAL"/>",//从 _START_ 到 _END_ /共 _TOTAL_ 条数据
	        "sInfoFiltered": "(<spring:message code="hrm.alert.contractInfo.Record_filter"/>)",//从 _MAX_ 条记录过滤
	        "oPaginate": {
	            "sPrevious": "<spring:message code="hrm.alert.contractInfo.Previous_page"/>",//上一页
	            "sNext": "<spring:message code="hrm.alert.contractInfo.NEXT_PAGE"/>"//下一页
	        }
	    }
});
function changeURL_courseSubjects(SUBJECTNo){
	var href = "/edu/traineducation/singlecourseSubjectsInfo?SUBJECT_NO=" + subjectNo;
	$.pdialog.open(href,"edu0106", "<spring:message code='pa.ins.alert.message.title.clickForDetail' />", {width:800,height:600,mask:true});//查看课程表
}
</script>
<form id="courseSubjects" onsubmit="return navTabSearch(this);" action="/edu/traineducation/courseSubjects" method="post">
<div class="pageHeader" >
<div class="searchBar">
<div  style="width: 97%;margin-left:auto;margin-right:auto;" >
	<table class="user_table" style="text-align:center" width="100%" border="1" cellpadding="2" cellspacing="1">
		<tr>
		<td class="td_title" width="4%"><spring:message code="edu.studentEvaluate.SUBJECT_NO.a"/></td><!--主题号--><td class="td_type" width="4%">
		<input type="text" name="SUBJECT_NO" id="SUBJECT_NO" value="${SUBJECT_NO }">
		</td>
		<td class="td_title" width="4%"><spring:message code="edu.studentEvaluate.SUBJECT_NAME.a"/></td><!--主题名称--><td class="td_type" width="4%">
		<input type="text" name="SUBJECT_NAME" id="SUBJECT_NAME" value="${SUBJECT_NAME }">
		</td>
		<td class="td_title"><spring:message code="hrm.empinfo.MAIN_BUSINESS_NAME" /><!-- 主要业务 --></td>
		<td class="td_type"><ait:SelectSyCodeByCpnyID id="MAIN_BUSINESS" name="MAIN_BUSINESS" selected="${MAIN_BUSINESS}" parentNo="14013573" limit="all" />
		</td>
	</table>
</div>
</div>
<div class="subBar" style="margin-top: 10px; float: right; padding-right: 10px;">
		<ul style="width: 250px;">
            <li>
				<a class="buttonActive" href="#" onclick="sousuoOrg()" width="800" height="100" >
					<span><spring:message code="hrm.empinfo.SEARCH"/></span><!--搜索	--></a>
			</li>
			<li>
				<a class="buttonActive" href="/edu/traineducation/addCourseSubjects" target="dialog" mask="true" width="800" height="500" >
					<span><spring:message code="button.add"/></span><!--添加	--></a>
			</li>
			<li id="yinOrg" style="">
				<a class="buttonActive"  onclick="xiugaiOrg()" href="#"  width="800" height="100">
					<span><spring:message code="button.update"/></span><!--修改--></a>
			</li>
			<li id="xianOrg" style="display:none">
				<a class="buttonActive" id="updateOrg" onclick="xiugaiOrg()" href="#" target="dialog" mask="true"  width="800" height="500">
					<span><spring:message code="button.update"/></span><!--修改--></a>
			</li>
			<li>
				<a class="buttonActive" title="<spring:message code="edu.systemManager.QUEDINGSHIFOUSHANCHU.a"/>"   id="deleteOrg" onclick="shanchuOrg()" href="#" callback="doAjaxDoneWithForm" target="ajaxTodo">
				<!--确定是否删除?-->
				<span><spring:message code="button.delete"/></span><!--删除--></a>
			</li>
		</ul>
</div>
<div style="width: 100%; padding-top: 30px;">
	<table id="viewInfoTable" class="list" >
	<thead>
		<tr >
		    <th  width="1%">NO.</th>
		    <th  width="3%"><spring:message code="edu.studentEvaluate.SUBJECT_NO.a"/></th><!--主题号-->
		    <th  width="15%"><spring:message code="edu.studentEvaluate.SUBJECT_NAME.a"/> </th><!--主题名称-->
		    <th  width="25%"><spring:message code="hrm.empinfo.MAIN_BUSINESS_NAME" /><!-- 主要业务 --> </th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${courseSubjectsList}" var="s" varStatus="i">
		<tr target="Org" id="listOrg_${i.count }" onclick="xuanzhongOrg('${i.count }','${s.SUBJECT_ID }')" >
		   <td class="td_type" width="1%" style="text-align:center;">${i.count }.</td>
           <td class="td_type" width="3%">${s.SUBJECT_NO }</td>
           <td class="td_type" width="15%" style="text-align: left">${s.SUBJECT_NAME }</td>
           <td class="td_type" width="25%" style="text-align: left">${s.MAIN_BUSINESS_NAME }</td>
		   
		</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</div>
</form>