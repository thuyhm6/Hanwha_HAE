<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
$(document).ready(function(){
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
		                     { "orderable": false, "targets": [1] }
	                     ],
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
        "oLanguage": {//多语言配置
        	"sProcessing": "<spring:message code='hem.alert.empinfo.Is_loading'/>",//正在加载中......
            "sZeroRecords": "<spring:message code='hem.alert.empinfo.not_find_relevant_data'/>",//查询不到相关数据！
            "sEmptyTable": '<spring:message code="ess.infoApply.titel.messages200"/>',
            "sSearch": '<spring:message code="hrm.alert.contractInfo.Rapid_screening"/>',
            "sLengthMenu": '<spring:message code="ess.infoApply.titel.messages201"/> _MENU_ <spring:message code="ess.infoApply.titel.messages202"/>',
            "sInfo": '<spring:message code="hrm.alert.contractInfo.START_END_TOTAL"/>',
            "sInfoFiltered": "(<spring:message code='hrm.alert.contractInfo.Record_filter'/>)",//从 _MAX_ 条记录过滤
            "oPaginate": {
                "sPrevious": '<spring:message code="hrm.alert.contractInfo.Previous_page"/>',
                "sNext": '<spring:message code="hrm.alert.contractInfo.NEXT_PAGE"/>'
            }
        },
        "sDom":'<"top"r<"clear">fBl>t<"bottom"ip<"clear">>',
        "buttons": [
              ] 
		});
});

</script>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="/ess/infoApply/viewDeptOtApplyInfo?firstFlag=N" method="post"
		id="viewDeptOtApplyInfo" name="viewDeptOtApplyInfo">
		<input type="hidden" name='ADMIN_ID' value="${LoginUser.adminID }"/>
		<div class="searchBar">
			<table class="searchContent" style="height: 20px">
				<tr>
				    <td><!-- 月份 --><spring:message code="ar.excelexport.title.month" /></td>
					<td>
						<input type="text" id="AR_MONTH" name="seach_AR_MONTH" class="Wdate" onClick="WdatePicker({dateFmt:'yyyyMM',lang:'en'})" value="${AR_MONTH}"/>
					</td>
					<td>
						<!-- 社号/姓名： --> <spring:message
							code="hr.viewContractByInsert.title.EMPIDANDLOCALNAME" />
					</td>
					<td><input type="text" name="seach_KEY" value="${KEY}" /></td>
					<td><!-- 部门： --> <spring:message
						code="hr.viewPersonalInfo.title.DEPTNAME" /> 
					</td>
					<td>
						<!--<ait:deptList name="seach_DEPTNO" cpnyId="${defaultCpny}" limit="manager"  id="viewDeptOtApplyInfo_seachDept" selected="${DEPTNO}"/>
						<ait:deptTreeIcon name="seach_DEPTNO" cpnyId="${defaultCpny}" limit="manager"  id="viewDeptOtApplyInfo_seachDept" selected="${DEPTNO}"/>
					-->
						<ait:deptTreeMulti id="seach_DEPTNO_Multi" name="seach_DEPT_NAME" limit="manager" selectedNm="${DEPT_NAME}" selected="${DEPTNO_Multi}"></ait:deptTreeMulti>
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
				    <c:if test="${LoginUser.language ne 'ko'}">
					    <li>
					        <a class="buttonActive" onclick="downloadExcel('viewDeptOtApplyInfo','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=139','/ess/infoApply/viewDeptOtApplyInfo?firstFlag=N')"><span><!--导出到Excel--><spring:message code="ess.infoApply.export_to_Excel"/> </span></a>
					    <!--<c:if test="${LoginUser.cpnyId eq 'HAE'}">
					        <a class="buttonActive" onclick="downloadExcel('viewDeptOtApplyInfo','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=308','/ess/infoApply/viewDeptOtApplyInfo?firstFlag=N')"><span>导出到Excel<spring:message code="ess.infoApply.export_to_Excel"/> </span></a>
					    </c:if>-->
					    </li>
					</c:if>
					<c:if test="${LoginUser.language eq 'ko'}">
					    <li>
					        <a class="buttonActive" onclick="downloadExcel('viewDeptOtApplyInfo','/disc/autoExcel/exportLOtImportExcel?SQL_SEQMEAN=331','/ess/infoApply/viewDeptOtApplyInfo?firstFlag=N')"><span><!--导出到Excel--><spring:message code="ess.infoApply.export_to_Excel"/> </span></a>
					    </li>
					</c:if>
				</ul>
			</div>
		</div>
	</form>
</div>

<div class="pageContent" >
<div class="formBar">
<!--<div style="font: 12px/ 20px arial, sans-serif; float: left; height: 30px; line-height: 30px;">Total:${fn:length(otDeptList)}</div>-->
</div>
	<form name="delLeaveApplyAffirmForm" id="delLeaveApplyAffirmForm" method="post" action="/ess/infoApplyLeave/delLeaveApplyInBatch" 
	  onsubmit="return delLeaveApplyCallback(this, navTabAjaxDone);"> 
		<table class="orderList" width="2000px">   
			<thead>
				<tr>
					<th rowspan="2" width="5px;" ><!--NO-->NO</th>
					<th rowspan="2" width="100px;" >
						<!--工号--><spring:message code="ess.infoApply.EMPID"/> 
					</th>
					<th rowspan="2" width="180px;" >
				    	<!--姓名--><spring:message code="ess.infoApply.NAME"/> 
				    </th>
					<th rowspan="2" width="200px;" >
						<!--部门--><spring:message code="ess.infoApply.DEPT"/> 
					</th>
					<th rowspan="2" width="180px;" >
						<!--职级--><spring:message code="ess.infoApply.Rank"/> 
					</th>
					<th rowspan="2" width="50px;" >
						<!--职级--><spring:message code="ess.infoApply.subtotal"/> 
					</th>
					<th colspan="31" >
						<!--日期--><spring:message code="display.mutual.month"/> ${AR_MONTH} 
					</th>
					
				</tr>
				<tr>
					<th><!--1-->1</th>
					<th><!--1-->2</th>
					<th><!--1-->3</th>
					<th><!--1-->4</th>
					<th><!--1-->5</th>
					<th><!--1-->6</th>
					<th><!--1-->7</th>
					<th><!--1-->8</th>
					<th><!--1-->9</th>
					<th><!--1-->10</th>
					<th><!--1-->11</th>
					<th><!--1-->12</th>
					<th><!--1-->13</th>
					<th><!--1-->14</th>
					<th><!--1-->15</th>
					<th><!--1-->16</th>
					<th><!--1-->17</th>
					<th><!--1-->18</th>
					<th><!--1-->19</th>
					<th><!--1-->20</th>
					<th><!--1-->21</th>
					<th><!--1-->22</th>
					<th><!--1-->23</th>
					<th><!--1-->24</th>
					<th><!--1-->25</th>
					<th><!--1-->26</th>
					<th><!--1-->27</th>
					<th><!--1-->28</th>
					<th><!--1-->29</th>
					<th><!--1-->30</th>
					<th><!--1-->31</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${otDeptList}" var="otApply" varStatus="i">	
					<tr target="sid" rel="${personInfo.PERSON_ID}">
					    <td style="text-align: center">${i.count}</td>
						<td style="text-align: center">${otApply.EMPID}</td>
					    <td style="text-align: center">${otApply.LOCAL_NAME}</td>
						<td style="text-align: center">${otApply.DEPT_NAME}</td>
						<td style="text-align: center">${otApply.POST_GRADE_NAME}</td>
						<td style="text-align: center">${otApply.OT_TOTAIL_MONTH}</td>
						<td style="text-align: center">${otApply.DAY_OT_1 + otApply.NIGHT_OT_1}</td>
						<td style="text-align: center">${otApply.DAY_OT_2 + otApply.NIGHT_OT_2}</td>
						<td style="text-align: center">${otApply.DAY_OT_3 + otApply.NIGHT_OT_3}</td>
						<td style="text-align: center">${otApply.DAY_OT_4 + otApply.NIGHT_OT_4}</td>
						<td style="text-align: center">${otApply.DAY_OT_5 + otApply.NIGHT_OT_5}</td>
						<td style="text-align: center">${otApply.DAY_OT_6 + otApply.NIGHT_OT_6}</td>
						<td style="text-align: center">${otApply.DAY_OT_7 + otApply.NIGHT_OT_7}</td>
						<td style="text-align: center">${otApply.DAY_OT_8 + otApply.NIGHT_OT_8}</td>
						<td style="text-align: center">${otApply.DAY_OT_9 + otApply.NIGHT_OT_9}</td>
						<td style="text-align: center">${otApply.DAY_OT_10 + otApply.NIGHT_OT_10}</td>
						<td style="text-align: center">${otApply.DAY_OT_11 + otApply.NIGHT_OT_11}</td>
						<td style="text-align: center">${otApply.DAY_OT_12 + otApply.NIGHT_OT_12}</td>
						<td style="text-align: center">${otApply.DAY_OT_13 + otApply.NIGHT_OT_13}</td>
						<td style="text-align: center">${otApply.DAY_OT_14 + otApply.NIGHT_OT_14}</td>
						<td style="text-align: center">${otApply.DAY_OT_15 + otApply.NIGHT_OT_15}</td>
						<td style="text-align: center">${otApply.DAY_OT_16 + otApply.NIGHT_OT_16}</td>
						<td style="text-align: center">${otApply.DAY_OT_17 + otApply.NIGHT_OT_17}</td>
						<td style="text-align: center">${otApply.DAY_OT_18 + otApply.NIGHT_OT_18}</td>
						<td style="text-align: center">${otApply.DAY_OT_19 + otApply.NIGHT_OT_19}</td>
						<td style="text-align: center">${otApply.DAY_OT_20 + otApply.NIGHT_OT_20}</td>
						<td style="text-align: center">${otApply.DAY_OT_21 + otApply.NIGHT_OT_21}</td>
						<td style="text-align: center">${otApply.DAY_OT_22 + otApply.NIGHT_OT_22}</td>
						<td style="text-align: center">${otApply.DAY_OT_23 + otApply.NIGHT_OT_23}</td>
						<td style="text-align: center">${otApply.DAY_OT_24 + otApply.NIGHT_OT_24}</td>
						<td style="text-align: center">${otApply.DAY_OT_25 + otApply.NIGHT_OT_25}</td>
						<td style="text-align: center">${otApply.DAY_OT_26 + otApply.NIGHT_OT_26}</td>
						<td style="text-align: center">${otApply.DAY_OT_27 + otApply.NIGHT_OT_27}</td>
						<td style="text-align: center">${otApply.DAY_OT_28 + otApply.NIGHT_OT_28}</td>
						<td style="text-align: center">${otApply.DAY_OT_29 + otApply.NIGHT_OT_29}</td>
						<td style="text-align: center">${otApply.DAY_OT_30 + otApply.NIGHT_OT_30}</td>
						<td style="text-align: center">${otApply.DAY_OT_31 + otApply.NIGHT_OT_31}</td>
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
	<div style="visibility: hidden">
    <%--<c:set value="/ess/infoApplyAttendance/viewApplyAttendanceInfoList?firstFlag=N" var="pageUrl"/>
	<%@ include file="/WEB-INF/view/inc/initPagination2.jsp"%>--%>
	</div>
</div>