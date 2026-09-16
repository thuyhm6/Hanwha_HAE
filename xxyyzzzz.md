căn cứ vào viewNoticeInfo.html, hãy tạo cho tôi 1 file mới có tên là viewFeedbackComplaints.html, nằm trong module /sys/notice/, với 3 tab: Trung tâm Góp ý/ Khiếu nại:, Hướng dẫn gửi khiếu nại/ góp ý:, Gửi góp ý/ khiếu nại:. như hình ảnh. nội dung cảu từng tab tham khảo hình ảnh (tham khảo giao diện viewEvsParamPanel.html về cấu trúc tab). Ở tab Gửi góp ý/ khiếu nại: có ô để người dùng nhập Tiêu đề và Chi tiết góp ý/Khiếu nại. sau khi người dùng bấm nút Gửi thư, nội dung sẽ được Lưu vào bảng sy_feedback với các trường như hình ảnh và hiển thị thông báo Bạn đã gửi góp ý/khiếu nại thành công hoặc thất bại.

căn cứ vào viewNoticeInfo.html, hãy tạo cho tôi 1 file mới có tên là viewFeedbackComplaintsList.html - Danh sách Góp ý/Khiếu nại, nằm trong module /sys/notice/, với các cột: STT, Tiêu đề, Loại góp ý/khiếu nại, Nội dung, Ngày gửi, Người gửi. Khi người dùng bấm vào 1 dòng trong danh sách sẽ hiển thị chi tiết của góp ý/khiếu nại đó. Điều kiện tìm kiếm : Tiêu đề, Loại góp ý/khiếu nại, Ngày gửi. dữ liệu lấy từ bảng sy_feedback. cột Loại góp ý/khiếu nại lấy từ function get_global_name(FEEDBACK_TYPE, #language:VARCHAR#).

ở bảnng sy_user, tôi mới thêm 3 trường mới: PERSONAL_DATA_CONFIRM_BY, PERSONAL_DATA_CONFIRM_DATE, PERSONAL_DATA_CONFIRM_IP. Khi người dùng đăng nhập, kiểm tra xem trường PERSONAL_DATA_CONFIRM_BY này có giá trị không. nếu không có giá trị, thì sẽ hiện lên một popup để người dùng xác nhận đồng ý với việc xử lý dữ liệu cá nhân. Nội dung popup tham khảo hình ảnh, có 2 nút: Đồng ý và Hủy. Nếu người dùng bấm Đồng ý, thì lưu thông tin người dùng vào các trường PERSONAL_DATA_CONFIRM_BY, PERSONAL_DATA_CONFIRM_DATE, PERSONAL_DATA_CONFIRM_IP trong bảng sy_user. Nếu người dùng bấm Hủy, thì đăng xuất khỏi hệ thống. Khi hiện lên popup, người dùng không thể thao tác với các chức năng khác của hệ thống. nếu đóng popup, thì cũng sẽ đăng xuất khỏi hệ thống. 
các trường thông tin của người dùng lấy từ bảng HR_EMPLOYEE với Họ và tên: LOCAL_NAME
ID: EMPID
Chức vụ: GET_GLOBAL_NAME(POSITION_NO, #interLanguage:VARCHAR#)
Team: GET_DEPT_NAME(GET_DEPT_NO_BY_LEVEL(DEPTNO, CPNY_ID, '2'),#interLanguage:VARCHAR#), Part: GET_DEPT_NAME(GET_DEPT_NO_BY_LEVEL(DEPTNO, CPNY_ID, '3'),#interLanguage:VARCHAR#)., Cell: GET_DEPT_NAME(GET_DEPT_NO_BY_LEVEL(DEPTNO, CPNY_ID, '4'),#interLanguage:VARCHAR#)


45170012/Buivande2961988!


Thêm cho tôi giao diện /sys/notice/viewPersonalDataConfirmList.jsp - Danh sách xác nhận đồng ý xử lý dữ liệu cá nhân, với các cột: STT, Họ và tên, ID, Chức vụ, Team, Part, Cell, Ngày xác nhận, Địa chỉ IP. Dữ liệu lấy từ bảng sy_user và bảng HR_EMPLOYEE. Khi người dùng bấm vào 1 dòng trong danh sách sẽ hiển thị ra cái nội dung giống với popup viewPersonalDataConfirm.