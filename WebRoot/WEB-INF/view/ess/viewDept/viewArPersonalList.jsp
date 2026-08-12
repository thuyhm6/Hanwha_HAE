<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage="" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
	$(document).ready(function() {
	$(".orderList", navTab.getCurrentPanel()).dataTable({
		"bPaginate" : true, //分页
		"bAutoWidth" : false,//表格宽度自动变化
		"bProcessing" : true,
		"lengthMenu" : [ [50,100,200, 500], [50,100,200, 500] ],
		"bLengthChange" : true, //按多少条记录显示下拉框
		"iDisplayLength" : 50, //默认每页显示的记录数
		"bFilter" : true, //开启快速过滤功能（过滤整个表，可以指定那些列过滤，或者不过滤），本功能默认是开启的，
		"searching" : true,//本地搜索
		"bSort" : true, //排序功能
		"bInfo" : true, //显示datatables的信息（底部的页数，条目数信息）
		"bScrollInfinite" : true,
		"orderClasses" : false,
		"order" : [],//初始化不用自动排序
		"scrollY" : $(document.body).height() - 340,
		"scrollCollapse" : false,
		"deferRender" : true,
		//"scroller":true,
		initComplete: function () {//列筛选
                         var api = this.api();
                         api.columns().indexes().flatten().each(function (i) {
                       	  if(i==1){//选中后，标记为需要提交的数据
                       		  var column = api.column(i);
                       		  column.on('change','tr',function(){
                       			  if($('#'+api.cell($(this).context._DT_RowIndex,1).node().children[0].id,navTab.getCurrentPanel()).attr('checked')=='checked'){
                       			  	api.cell($(this).context._DT_RowIndex,0).data('@willBeCommit@');
                       			     $(this).toggleClass('selected');
                       			  }else 
                       				api.cell($(this).context._DT_RowIndex,0).data(''); 
                       		  });
                       	  }
                             if (i==3||i==4) {//设定第几列有筛选框起始列是0
                                 var column = api.column(i);
                             	  //没有数据时，不需要列筛选
                             	  if(column.data().length == 0)
                             		  return;
                                 var $span = $('<span class="addselect"><div id="specailSele'+i+'" >▾</div></span>').appendTo($(column.header()));
                                 var select = $('<select><option value="">▾</option></select>')
                                         .appendTo($(column.header()))
                                         .on('click', function (evt) {
                                             evt.stopPropagation();
                                             var val = $.fn.dataTable.util.escapeRegex(
                                                     $(this).val()
                                             );
                                             column
                                                     .search(val ? '^' + val + '$' : '', true, false)
                                                     .draw();
                                         });
                                 select.on('change', function (evt) {
                                     var val = $.fn.dataTable.util.escapeRegex(
                                             $(this).val()
                                     );
                                     if(val == ''){
                                    	 $('#specailSele'+i,navTab.getCurrentPanel()).text("▾");
                                     }else{
                                    	 $('#specailSele'+i,navTab.getCurrentPanel()).text("*");
                                     }
                                 }); 
                                 column.data().unique().sort().each(function (d, j) {
                                     function delHtmlTag(str) {
                                         return str.replace(/<[^>]+>/g, "");//去掉html标签
                                     }
       
                                     d = delHtmlTag(d);
                                     select.append('<option value="' + d + '">' + d + '</option>');
                                     $span.append(select);
                                 });
       
                             }
                         });
       
                     },
		"oLanguage" : {//多语言配置
			//正在加载中......
			"sProcessing" : "<spring:message code='ess.message.loading' />",
			//查询不到相关数据！
			"sZeroRecords" : "<spring:message code='ess.message.NOT_FOUND_DATA' />",
			"sEmptyTable" : '<spring:message code="ess.infoApply.titel.messages200"/>',
			"sSearch" : '<spring:message code="hrm.alert.contractInfo.Rapid_screening"/>',
			"sLengthMenu" : '<spring:message code="ess.infoApply.titel.messages201"/> _MENU_ <spring:message code="ess.infoApply.titel.messages202"/>',
			"sInfo" : '<spring:message code="hrm.alert.contractInfo.START_END_TOTAL"/>',
			//(从 _MAX_ 条记录过滤)
			"sInfoFiltered" : "<spring:message code='ess.message.filter_from_max' />",
			"oPaginate" : {
				"sPrevious" : '<spring:message code="hrm.alert.contractInfo.Previous_page"/>',
				"sNext" : '<spring:message code="hrm.alert.contractInfo.NEXT_PAGE"/>'
			}
		},
		"sDom" : '<"top"r<"clear">fBl>t<"bottom"ip<"clear">>',
		"buttons" : []
	});
	});
	function changeURL(obj) {

		var STIMESS = $("#seach_STIME", navTab.getCurrentPanel()).val();
		STIMESS = STIMESS.substring(6, 10) + "/" + STIMESS.substring(3, 5) + "/" + STIMESS.substring(0, 2);

		var ETIMESS = $("#seach_ETIME", navTab.getCurrentPanel()).val();
		ETIMESS = ETIMESS.substring(6, 10) + "/" + ETIMESS.substring(3, 5) + "/" + ETIMESS.substring(0, 2);

		$.pdialog.open("/ess/viewDept/viewArPersonalSingleList?ITEM_NO=" + obj.name + "&PERSON_ID=" + obj.type
				+ "&STIME=" + STIMESS + "&ETIME=" + ETIMESS, "addAffirmWindow", obj.title, {
			width : 1200,
			height : 400,
			mask : true
		});
	}

	function exportExcle(a) {
		var $this = $(a);
		var title = $this.attr("title");
		var $from = $("#viewArVacationMonth");

		var url = "/ar/attendanceVacations/viewArVacationMonthExcel";
		alertMsg.confirm(title, {
			okCall : function() {
				window.location = url + (url.indexOf('?') == -1 ? "?" : "&") + $from.serialize();
			}
		});
	}
</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);"
		action="/ess/viewDept/viewArPersonalList" method="post"
		id="viewArPersonalList" name="viewArPersonalList">
		<input type="hidden" name='CODE_NO' />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<!-- 部门： --> <spring:message
							code="hr.viewPersonalInfo.title.DEPTNAME" />
					</td>
					<td><ait:deptList name="seach_DEPT_NO" cpnyId="${defaultCpny}"
							limit="manager" id="viewApplyLeaveInfoList_seachDept" /> </td>
					<td>
						<!-- 社号/姓名： --> <spring:message
							code="hr.viewContractByInsert.title.EMPIDANDLOCALNAME" />
					</td>
					<td><input type="text" name="seach_KEY" value="${KEY}" /></td>
					<td width="10%">
						<!--员工类型--> <spring:message code="ess.infoApply.employee_type" />
					</td>
					<td width="20%"><ait:SelectSyCodeByCpnyID
							id="seach_EMP_TYPE_CODE" name="seach_EMP_TYPE_CODE"
							parentNo="13864" selected="${EMP_TYPE_CODE}"
							cnpyID="${LoginUser.cpnyId}" limit="all" /></td>
				</tr>
				<tr>
					<td>
						<!-- 开始日期 --> <spring:message code="public.title.startDate" />
					</td>
					<td><input type="text" id="seach_STIME" name="seach_STIME"
						value="${STIME}" class="Wdate"
						onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})" /></td>
					<td>
						<!-- 结束日期 --> <spring:message code="public.title.endDate" />
					</td>
					<td><input type="text" id="seach_ETIME" name="seach_ETIME"
						class="Wdate"
						onClick="WdatePicker({dateFmt:'dd/MM/yyyy',lang:'en'})"
						value="${ETIME}" /></td>
					<td>
						<!--班组--> <spring:message code="hr.viewPersonalInfo.title.banzu" />
					</td>
					<td><ait:SelectSyCodeByCpnyID name="seach_SHIFT_NO"
							id="seach_SHIFT_NO" limit="all" parentNo="400223"
							selected="${SHIFT_NO}" cnpyID="${LoginUser.cpnyId}" /></td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">
									<spring:message code="public.title.search" />
								</button>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</form>
</div>

<div class="pageContent">
	<div class="formBar">
		<ul class="toolBar">

			<li><c:if test="${LoginUser.cpnyId eq 'HTSV'}">

					<c:if test="${LoginUser.language ne 'ko'}">
						<a class="buttonActive"
							onclick="downloadExcel('viewArPersonalList','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=146&CPNY=${LoginUser.cpnyId}','/ess/viewDept/viewArPersonalList')"><span>
								<!--导出到Excel --> <spring:message
									code="ess.infoApply.export_to_Excel" />
						</span> </a>
					</c:if>
					<c:if test="${LoginUser.language eq 'ko'}">
						<a class="buttonActive"
							onclick="downloadExcel('viewArPersonalList','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=336&CPNY=${LoginUser.cpnyId}','/ess/viewDept/viewArPersonalList')"><span>
								<!--导出到Excel --> <spring:message
									code="ess.infoApply.export_to_Excel" />
						</span> </a>
					</c:if>
				</c:if> <c:if test="${LoginUser.cpnyId eq 'HAE'}">
					<c:if test="${LoginUser.language ne 'ko'}">
						<a class="buttonActive"
							onclick="downloadExcel('viewArPersonalList','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=309&CPNY=${LoginUser.cpnyId}','/ess/viewDept/viewArPersonalList')"><span>
								<!--导出到Excel --> <spring:message
									code="ess.infoApply.export_to_Excel" />
						</span> </a>
					</c:if>
					<c:if test="${LoginUser.language eq 'ko'}">
						<a class="buttonActive"
							onclick="downloadExcel('viewArPersonalList','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=336&CPNY=${LoginUser.cpnyId}','/ess/viewDept/viewArPersonalList')"><span>
								<!--导出到Excel --> <spring:message
									code="ess.infoApply.export_to_Excel" />
						</span> </a>
					</c:if>
				</c:if></li>

		</ul>
	</div>
	<form name="delLeaveApplyAffirmForm" id="delLeaveApplyAffirmForm"
		method="post" action="/ess/viewDept/viewArPersonalSingleList"
		onsubmit="return delLeaveApplyCallback(this, navTabAjaxDone);"
		target="dialog">

		<table class="orderList" border="1" width="100%" >
			<thead>
				<tr>
					<th>NO</th>
					<th>
						<!--工号 --> <spring:message code="ess.infoApply.EMPID" />
					</th>
					<th>
						<!--姓名 --> <spring:message code="public.title.empName" />
					</th>
					<th>
						<!--部门名 --> <spring:message code="ess.infoApply.DEPT_NAME" />
					</th>
					<th>
						<!--职级 --> <spring:message code="ess.infoApply.Rank" />
					</th>
					<%-- <th>
						<!--班组--> <spring:message code="hr.viewPersonalInfo.title.banzu" />
					</th> --%>
					<th>
						<!--合计 --> <spring:message code="ess.viewpersonalpainfo.heji" />
					</th>
					<th>
						<!--年假 --> <spring:message code="ar.viewArNavigationPage.NIANJIA.b" />
					</th>
					<th>
						<!--事假 --> <spring:message code="ess.viewpersonalpainfo.shijia" />
					</th>
					<th>
						<!--一般病假 --> <spring:message code="ess.viewArPersonalList.YIBANBINGJIA.b" />
					</th>
					<th>
						<!--孩子病假 --> <spring:message code="ess.viewArPersonalList.HAIZIBINGJIA.b" />
					</th>
					<th>
						<!--长期病假 --> <spring:message
							code="ess.viewArPersonalList.CHANGQIBINGJIA.b" />
					</th>
					<th>
						<!--个人婚假 --> <spring:message
							code="ess.viewArPersonalList.GERENHUNJIA.b" />
					</th>
					<th>
						<!--孩子婚假 --> <spring:message
							code="ess.viewArPersonalList.HAIZIHUNJIA.b" />
					</th>
					<th>
						<!--工伤假 --> <spring:message code="ar.menu.title.gongshangjia" />
					</th>
					<th>
						<!--有薪丧假 --> <spring:message
							code="ess.viewArPersonalList.YOUXINSANGJIA.b" />
					</th>
					<th>
						<!--产假 --> <spring:message code="ar.menu.title.chanjia" />
					</th>
					<th>
						<!--陪产假 --> <spring:message code="ar.menu.title.peichanjia" />
					</th>
					<th>
						<!--哺乳假--> <spring:message code="ar.menu.title.purujia" />
					</th>
					<th>
						<!--产前检查假--> <spring:message
							code="ar.arForDeptCountInfoList.CHANQIANJIANCHAJIA.b" />
					</th>
					<th>
						<!--出差--> <spring:message code="ar.menu.title.chuchai" />
					</th>
					<th>
						<!--迟到--> <spring:message code="ar.monthwork.title.Lateness" />
					</th>
					<th>
						<!--早退--> <spring:message code="ess.infoApply.leave_early" />
					</th>
					<th>
						<!--旷工--> <spring:message code="ar.monthwork.title.kuanggong" />
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${personList}" var="personList" varStatus="i">
					<tr target="sid" rel="${personList.PERSON_ID}">
						<td style="text-align: center">${i.count}</td>
						<td style="text-align: center">${personList.EMPID}</td>
						<td style="text-align: center">${personList.LOCAL_NAME}</td>
						<td style="text-align: center">${personList.DEPT_NAME}</td>
						<td style="text-align: center">${personList.POST_GRADE_NAME}</td>
						<%-- <td style="text-align: center">${personList.SHIFT_NAME}</td> --%>
						<td style="text-align: center">${personList.HEJI}</td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" onclick='javascript:changeURL(this);'
							name="141456" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.viewArNavigationPage.NIANJIA.b' />">
								<span>${personList.NIANJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" onclick='javascript:changeURL(this);'
							name="141454" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.viewpersonalpainfo.shijia' />">
								<span>${personList.SHIJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.viewArPersonalList.YIBANBINGJIA.b' />"
							onclick='javascript:changeURL(this);' name="141464"> <span>${personList.YIBANBINGJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.viewArPersonalList.HAIZIBINGJIA.b' />"
							onclick='javascript:changeURL(this);' name="90000286"> <span>${personList.HAIZIBINGJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.viewArPersonalList.CHANGQIBINGJIA.b' />"
							onclick='javascript:changeURL(this);' name="90000287"> <span>${personList.CHANGQIBINGJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.viewArPersonalList.GERENHUNJIA.b' />"
							onclick='javascript:changeURL(this);' name="90000289"> <span>${personList.GERENHUNJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.viewArPersonalList.HAIZIHUNJIA.b' />"
							onclick='javascript:changeURL(this);' name="90000290"> <span>${personList.HAIZIHUNJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.menu.title.gongshangjia' />"
							onclick='javascript:changeURL(this);' name="90000288"> <span>${personList.GONGSHANGJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.viewArPersonalList.YOUXINSANGJIA.b' />"
							onclick='javascript:changeURL(this);' name="90000291"> <span>${personList.YOUXINSANGJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.menu.title.chanjia'/>"
							onclick='javascript:changeURL(this);' name="141461"> <span>${personList.CHANJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.menu.title.peichanjia'/>"
							onclick='javascript:changeURL(this);' name="90000292"> <span>${personList.PEICHANJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.menu.title.purujia'/>"
							onclick='javascript:changeURL(this);' name="90000293"> <span>${personList.BURUJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.arForDeptCountInfoList.CHANQIANJIANCHAJIA.b'/>"
							onclick='javascript:changeURL(this);' name="141460"> <span>${personList.CHANQIANJIANCHAJIA}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.menu.title.chuchai'/>"
							onclick='javascript:changeURL(this);' name="90000294"> <span>${personList.CHUCHAI}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.monthwork.title.Lateness'/>"
							onclick='javascript:changeURL(this);' name="141441"> <span>${personList.CHIDAO}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ess.infoApply.leave_early'/>"
							onclick='javascript:changeURL(this);' name="141442"> <span>${personList.ZAOTUI}</span>
						</a></td>
						<td style="text-align: center"><a style="cursor: pointer;"
							id="codeChange" type="${personList.PERSON_ID}"
							title="<spring:message code='ar.monthwork.title.kuanggong'/>"
							onclick='javascript:changeURL(this);' name="141443"> <span>${personList.KUANGGONG}</span>
						</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
	<%--<c:set value="/ess/viewDept/viewArPersonalList" var="pageUrl" />
	<%@ include file="/WEB-INF/view/inc/initPagination.jsp"%>--%>
</div>
