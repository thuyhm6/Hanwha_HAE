<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<div class="pageContent" layouth="10">
<c:if test="${notice.COLOR_FLAG eq '1'}">
<div style="width:530px;height:30px;font-size:14px;text-align:center;padding:15px;color: red;">${notice.TITLE}</div>
</c:if>
<c:if test="${notice.COLOR_FLAG ne '1'}">
<div style="width:800px;height:10px;font-size:14px;text-align:center;padding:15px;">${notice.TITLE}</div>
</c:if>
<div style="width:800px;height:50px;font-size:12px;padding-right:15px;padding-left:15px;line-height:20px;margin-top:30px">${notice.CONTENT}</div>
<div>
	<c:forEach items="${notice.fileList}" var="item" varStatus="i">
		<tr>
		
		<c:if test="${item.FILE_NO eq '23821'}">
			<video id="myVideo" width="100%" height="360" controls>
			  <source src="/resources/temp/files/HAE/training_2.mp4" type="video/mp4">
			</video>
		</c:if>
		<c:if test="${item.FILE_NO ne '23821'}">
			<iframe src="${item.FILE_URL}#toolbar=0" width="100%" height="900px"></iframe>
		</c:if>
			
		</tr>
	</c:forEach>
</div>
</div>
<script>
    /* document.querySelector("iframe").addEventListener("contextmenu", function(e) {
        e.preventDefault();
    }); */
    
    const iframe = document.querySelector("iframe");
    if (iframe) {
        iframe.addEventListener("contextmenu", function(e) {
            e.preventDefault();
        });
    }

    const video = document.getElementById('myVideo');
    if (video) {
        video.addEventListener('play', function () {
            const startTime = new Date();
            /* console.log('Video bắt đầu được xem vào:', startTime.toLocaleString());
            console.log('Người xem là:', '${LoginUser.adminID}'); */
            $.ajax ({
        		type: 'POST',
        		url:"/sys/notice/addViewVideoCount",
        		data:[],
        		dataType:"json",
        		cache:false,
        		success: function() {
        			console.log('Video bắt đầu được xem vào:', startTime.toLocaleString());
        		},
        		error:DWZ.ajaxError
        	});
        });
    }
</script>