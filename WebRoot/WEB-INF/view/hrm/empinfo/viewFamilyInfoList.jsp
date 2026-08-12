<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<head>
</head>
<div class="pageContent">
<script type="text/javascript">
// 初始调用
$(document).ready(function() {
});
</script>

		<table class="table" width="100%" layoutH="50">
			<thead>
				<tr>
					<th>
						No.
					</th>
					<th>
						<!-- 姓名 --><spring:message code="ess.infoApply.NAME" />
					</th>
					<th>
						<!-- 社号 --><spring:message code="ess.infoApply.EMPID" />
					</th>
					<th>
						<!-- 部门 --><spring:message code="ess.infoApply.DEPT" />
					</th>
					<th>
						<!-- 职级 --><spring:message code="hrm.empinfo.LANGUAGE_GRADE" />
					</th>
					<th>
						<!-- 主要业务 --><spring:message code="hrm.empinfo.family_name" />
					</th>
					<th>
						<!-- 员工类型 --><spring:message code="ess.empInfo.relationship" />
					</th>
					<th>
						<!-- 状态 --><spring:message code="hr.viewCondSql.title.YUANGONGNIANLING" />
					</th>
					<th>
						<!-- DAY TO WORK --><spring:message code="ess.empInfo.birth" />
					</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${familyEmpidList}" var="item"
					varStatus="i">

					<tr>
						<td style="text-align: center">
							${i.count}
							<span id="isSelectRow_${i.count}"></span>
						</td>
						<td style="text-align: center">
							${item.LOCAL_NAME}
						</td>
						<td style="text-align: center">
							${item.EMPID}
						</td>
						<td style="text-align: center">
							${item.DEPT_NAME}
						</td>
						<td style="text-align: center">
							${item.POST_GRADE}
						</td>
						<td style="text-align: center">
							${item.FAM_NAME}
						</td>
						<td style="text-align: center">
							${item.FAM_TYPE_CODE_NAME}
						</td>
						<td style="text-align: center">
							${item.FAM_AGE}
						</td>
						<td style="text-align: center">
							${item.FAM_BORNDATE}
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</div>
