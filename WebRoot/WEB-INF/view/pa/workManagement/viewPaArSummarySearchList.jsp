<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<script type="text/javascript">

function pa1302_searchPop(flag) {
	var name = encodeURI(encodeURI($("#seach_KEY", navTab.getCurrentPanel())
			.val()));
	$("#pa1302_searchPop", navTab.getCurrentPanel())
			.attr(
					'href',
					'/pa/workManagement/viewEmpForPopList?pageNum=1&numPerPage=10&limit=pa&seach_KEY=' + name
			//+'&refreshUrl='+refreshUrl+'&refreshMenuCode='+refreshMenuCode+'&refreshMenuName='+refreshMenuName
			);
	if (flag == 'onkeyup')
		$("#pa1302_searchPop", navTab.getCurrentPanel()).click();
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
			} else {
				return false;
			}
		}
	} else {
		target = event.target; //针对遵循w3c标准的浏览器，如Firefox  
		code = event.keyCode;
		if (code == 13) {
			tag = target.tagName;
			if (tag == "INPUT") {
				return false;
			} else {
				return true;
			}
		}
	}
}

function viewPaArSummarySearchReport(){
      $("#viewPaArSummarySearchList").attr("action","/pa/workManagement/viewPaArSummarySearchListReport");
      $("#viewPaArSummarySearchList").attr("onsubmit","");
      
      $("#viewPaArSummarySearchList").submit();
      
      $("#viewPaArSummarySearchList").attr("action","/pa/workManagement/viewPaArSummarySearchList");
      $("#viewPaArSummarySearchList").attr("onsubmit","return navTabSearch(this);");
	
}
</script>



<div class="pageHeader" style="z-index: 20">
	<form id="viewPaArSummarySearchList"
		onsubmit="return navTabSearch(this);"
		action="/pa/workManagement/viewPaArSummarySearchList" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<!-- 工号/姓名： -->
						<spring:message
							code="hr.viewContractByInsert.title.EMPIDANDLOCALNAME" />
					</td>
					<td>
						<input type="text" name="seach_KEY" id="seach_KEY" value="${KEY}"
							onkeydown="javascript:if(event.keyCode == 13)pa1302_searchPop('onkeyup');" />
					</td>
					<td>
						<a class="btnLook" id="pa1302_searchPop"
							onclick="pa1302_searchPop()" href="#" lookupGroup="person"> </a>
					</td>
					<td colspan="3">
						<input id="dwz.person.empInfo" type="text" readonly
							lookupGroup="person" size="60" value="${empInfo}" />

						</a>
					</td>
				</tr>
				<tr>
					<td>
						工资支付计划:
					</td>
					<td>
						<select id="PAY_SCHEDULE_NO" name="PAY_SCHEDULE_NO">
							<c:forEach items="${paPayScheduleList}" var="paySchedule"
								varStatus="i">
								<c:choose>
									<c:when
										test="${PAY_SCHEDULE_NO == paySchedule.PAY_SCHEDULE_NO }">
										<option syslong="${paySchedule.PA_CONFIRM_FLAG }"
											value="${paySchedule.PAY_SCHEDULE_NO }" selected="selected">
											${paySchedule.PAY_DATE } -${paySchedule.SALARY_DISTIN }
										</option>
									</c:when>
									<c:otherwise>
										<option syslong="${paySchedule.PA_CONFIRM_FLAG }"
											value="${paySchedule.PAY_SCHEDULE_NO }">
											${paySchedule.PAY_DATE } -${paySchedule.SALARY_DISTIN }
										</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>


					<td>
						部门:
					</td>
					<td>
						<ait:deptList name="seach_DEPT_NO" cpnyId="${defaultCpny}"
							limit="ar" id="viewpa1302_seachDept" selected="${DEPT_NO}" />
						<ait:deptTreeIcon name="seach_DEPTNO" cpnyId="${defaultCpny}"
							limit="ar" id="viewpa1302_seachDept" selected="${DEPT_NO}" />
					</td>

				</tr>

			</table>
			<div class="subBar">
				<ul>

					<li>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">
									<spring:message code="public.title.search" />
									<!--检索-->
								</button>
							</div>
						</div>
					</li>
					<c:if test="${LoginUser.cpnyId eq 'TSTO'}">
						<li>
							<a class="buttonActive" onclick="viewPaArSummarySearchReport();"
								href="#"> <span>导出到Excel</span> </a>
						</li>
					</c:if>

				</ul>
			</div>
		</div>
	</form>
</div>

<div class="pageContent">

	<table id="ViewPaArSummaryForManageTable" width="150%" layoutH="100"
		class="orderList">
		<thead>
			<tr>
				<th>
					No
				</th>
				<th>
					姓名
				</th>
				<th>
					工号
				</th>
				<th>
					部门
				</th>
				<th>
					职级
				</th>
				<c:forEach items="${viewPaArSummaryList}" var="itemT" varStatus="i">
					<c:forEach items="${itemT}" var="item" varStatus="is">
						<c:set var="VALUESS" value="VALUE${is.count}">
						</c:set>
						<th width="20px">
							${itemT[VALUESS]}
						</th>
						<c:set var="VALUESS" value=""></c:set>
					</c:forEach>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${viewPaArSummarySearchList}" var="itemT"
				varStatus="i">
				<tr>
					<td width="20px">
						${i.count}
					</td>
					<td width="20px">
						${itemT.LOCAL_NAME}
					</td>
					<td width="20px">
						${itemT.EMPID}
					</td>
					<td width="20px">
						${itemT.DEPT_NAME}
					</td>
					<td width="20px">
						${itemT.POST_GRADE}
					</td>
					<c:forEach items="${itemT}" var="item" varStatus="is">
						<c:set var="VALUESS" value="VALUE${is.count}">
						</c:set>
						<td width="20px">
							${itemT[VALUESS]}
						</td>
						<c:set var="VALUESS" value=""></c:set>
					</c:forEach>
				</tr>
			</c:forEach>
		</tbody>
	</table>


</div>
