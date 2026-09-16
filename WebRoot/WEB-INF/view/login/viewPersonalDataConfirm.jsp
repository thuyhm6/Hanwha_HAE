<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ include file="/WEB-INF/view/inc/initTaglibs.jsp"%>
<jsp:useBean id="pdcNow" class="java.util.Date" />
<style type="text/css">
.pdcPage { max-width:720px; margin:0 auto; background:#fff; padding:20px 26px; }
.pdcPage h2 { text-align:center; font-size:16px; margin:0 0 14px 0; }
.pdcPage h4 { font-size:12.5px; font-weight:bold; margin:12px 0 5px 0; color:#111; }
.pdcPage ul { margin:0 0 6px 18px; padding:0; }
.pdcPage ul li { margin:3px 0; line-height: 18px;}
.pdcPage p { margin:6px 0; line-height:1.6; font-size:12.5px; color:#222; }
.pdcHeader { margin-bottom:10px; font-size:12.5px; }
.pdcHeader .pdcField { margin:3px 0; }
.pdcCheckboxLine { margin-top:10px; }
.pdcCheckboxLine label { font-weight:normal; cursor:pointer; }
.pdcCheckboxLine input[type=radio] { vertical-align:middle; margin-right:2px; cursor:pointer; }
.pdcSign { margin-top:22px; text-align:right; font-size:12.5px; }
.pdcSign > div { margin:2px 0; }
.pdcSignRole { font-weight:bold; margin-top:6px !important; }
@media print {
	@page { size: A4; margin:20mm; }
	.formBar { display:none; }
	.pageContent { overflow:visible !important; height:auto !important; }
	.pdcPage { max-width:none; padding:0; }
}
</style>
<script type="text/javascript">
function personalDataConfirmAgree(){
	var pdcChoice = $("input[name='pdcAgreeChoice']:checked").val();
	if(!pdcChoice){
		alertMsg.error("Vui lòng chọn \"Có\" hoặc \"Không\" trước khi bấm Đồng ý");
		return false;
	}
	if(pdcChoice == "no"){
		location.href = "/login/out";
		return false;
	}
	$.ajax({
		type: 'POST',
		url: '/login/updatePersonalDataConfirm',
		cache: false,
		success: function(data){
			if(data == "1"){
				location.reload();
			}
		},
		error: DWZ.ajaxError
	});
	return false;
}
function personalDataConfirmCancel(){
	location.href = "/login/out";
	return false;
}
</script>
<div class="pageContent" layoutH="10">
<div class="pdcPage">
	<h2>PHIẾU ĐỒNG Ý XỬ LÝ DỮ LIỆU CÁ NHÂN</h2>

	<div class="pdcHeader">
		<div class="pdcField"><b>Họ và tên:</b> ${LoginUser.localName}</div>
		<div class="pdcField"><b>ID:</b> ${LoginUser.empID}</div>
		<div class="pdcField"><b>Chức vụ:</b> ${LoginUser.positionNoName}</div>
		<div class="pdcField"><b>Team:</b> ${LoginUser.team}, <b>Part:</b> ${LoginUser.part}, <b>Cell:</b> ${LoginUser.cell}</div>
	</div>

	<p>Nhằm tuân thủ các quy định pháp luật về bảo vệ dữ liệu cá nhân, đồng thời xác lập cơ sở pháp lý để Công ty thực hiện công tác quản lý nhân sự, bảo đảm các quyền lợi cho Người lao động, Tôi tự nguyện cung cấp và cho phép Công ty xử lý dữ liệu cá nhân của tôi theo các nội dung sau:</p>

	<h4>1. Loại dữ liệu cá nhân được xử lý</h4>
	<ul>
		<li> - Dữ liệu cá nhân cơ bản: Họ và tên, ngày tháng năm sinh, giới tính, số điện thoại, địa chỉ email, địa chỉ liên hệ, hình ảnh cá nhân, thông tin CMND/CCCD/Hộ chiếu...</li>
		<li> - Dữ liệu cá nhân nhạy cảm (nếu có): Hình ảnh thẻ căn cước, thông tin sức khỏe (nếu có yêu cầu)...</li>
	</ul>

	<h4>2. Phương thức xử lý dữ liệu:</h4>
	<p>Dữ liệu cá nhân có thể được thu thập, phân tích, lưu trữ, mã hóa, cung cấp, chuyển giao, hoặc các hành động khác có liên quan theo quy định pháp luật.</p>

	<h4>3. Mục đích xử lý dữ liệu cá nhân</h4>
	<ul>
		<li> - Quản lý quan hệ lao động, thực hiện hợp đồng, đánh giá hiệu suất</li>
		<li> - Kê khai, tham gia bảo hiểm xã hội (BHXH)</li>
		<li> - Mở tài khoản, chi trả lương qua ngân hàng</li>
		<li> - Đăng ký mã số thuế TNCN, người phụ thuộc</li>
		<li> - Tham gia bảo hiểm nhóm Hanwha Life và quản lý các chế độ ốm đau, thai sản, tai nạn lao động, khám sức khỏe định kỳ</li>
		<li> - Đào tạo nâng cao trình độ chuyên môn, đào tạo cấp các loại chứng chỉ theo yêu cầu của pháp luật</li>
		<li> - Tuân thủ quy định pháp luật như: phục vụ thanh tra, kiểm tra và báo cáo cơ quan nhà nước</li>
		<li> - Liên hệ khẩn cấp, truyền thông nội bộ</li>
		<li> - Cấp, quản trị tài khoản truy cập hệ thống Groupware/Mail/ERP/MES</li>
		<li> - Chia sẻ, chuyển dữ liệu cho công ty mẹ tại Hàn Quốc nhằm phục vụ quản trị trong tập đoàn</li>
	</ul>
	<p class="pdcCheckboxLine">
		<b>Tôi đồng ý với điều khoản nêu trên</b>
		&nbsp;&nbsp;<label><input type="radio" name="pdcAgreeChoice" value="yes"> Có</label>
		&nbsp;&nbsp;<label><input type="radio" name="pdcAgreeChoice" value="no"> Không</label>
	</p>

	<h4>4. Thời gian bắt đầu và kết thúc xử lý dữ liệu</h4>
	<ul>
		<li> - Thời gian bắt đầu: Kể từ ngày tôi ký xác nhận vào Giấy đồng ý này.</li>
		<li> - Thời gian kết thúc: Cho đến khi Hợp đồng lao động chấm dứt và Công ty đã hoàn tất toàn bộ các nghĩa vụ pháp lý, lưu trữ hồ sơ theo quy định của pháp luật (Thuế, BHXH, Lưu trữ quốc gia), trừ trường hợp có yêu cầu khác của cơ quan nhà nước.</li>
	</ul>

	<h4>5. Quyền và nghĩa vụ của Người lao động</h4>
	<ul>
		<li> - Quyền hạn: Tôi có quyền được biết, truy cập, chỉnh sửa, yêu cầu xóa dữ liệu, hạn chế hoặc phản đối xử lý dữ liệu, rút lại sự đồng ý (bằng văn bản) và các quyền khác quy định tại Nghị định 13/2023/NĐ-CP.</li>
		<li> - Lưu ý về rút lại sự đồng ý: Tôi hiểu rằng việc rút lại sự đồng ý không làm ảnh hưởng đến tính hợp pháp của việc xử lý dữ liệu đã thực hiện trước đó, và Công ty vẫn có quyền tiếp tục xử lý các dữ liệu bắt buộc theo quy định của pháp luật về lao động, thuế, bảo hiểm và các bộ luật có liên quan khác.</li>
		<li> - Nghĩa vụ: Tôi cam kết cung cấp thông tin/dữ liệu chính xác, trung thực và thông báo kịp thời cho Công ty khi có sự thay đổi.</li>
	</ul>

	<p>Tôi xác nhận đã đọc, hiểu rõ và đầy đủ toàn bộ nội dung của Biểu mẫu này. Tôi tự nguyện đưa ra sự đồng ý đối với các nội dung đã tích chọn ở trên.</p>

	<div class="pdcSign">
		<div><i><fmt:formatDate value="${pdcNow}" pattern="'Hà Nội, ngày' dd 'tháng' MM 'năm' yyyy"/></i></div>
		<div class="pdcSignRole">Chủ thể dữ liệu cá nhân</div>
		<div><i>(Ký, ghi rõ họ tên)</i></div>
		<div><b>${LoginUser.localName}</b></div>
	</div>

	<div class="formBar">
		<ul>
			<li>
				<div class="buttonActive">
					<div class="buttonContent">
						<button type="button" onclick="return personalDataConfirmAgree();">Đồng ý</button>
					</div>
				</div>
			</li>
			<li>
				<div class="button">
					<div class="buttonContent">
						<button type="button" onclick="return personalDataConfirmCancel();">Hủy</button>
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>
</div>
