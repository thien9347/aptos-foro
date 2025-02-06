
# AptosForo

**Decentralised Prediction Market built on Optimistic Oracles**

AptosForo (tên kết hợp từ “Aptos” và “Foro” – tiếng Latin nghĩa “market”) là một nền tảng thị trường dự đoán phi tập trung cho phép giao dịch trên nhiều chủ đề tranh cãi như sự kiện hiện tại, chính trị và xu hướng tiền điện tử. Người dùng có thể chuyển dự đoán của mình thành tài sản có thể giao dịch, từ đó kiếm lợi nhuận và xây dựng trí tuệ tập thể về xác suất các kết quả xảy ra.

## Quy Trình Hoạt Động

1.  **Tạo Mới Thị Trường:**  
    Người dùng khởi tạo thị trường với 2 kết quả (ví dụ: Có/Không) và cung cấp phần thưởng để khuyến khích việc đưa ra kết quả đúng.
    
2.  **Khởi Tạo Bể Thanh Khoản:**  
    Người dùng cung cấp thanh khoản ban đầu (đáp ứng mức tối thiểu) và nhận được token LP, đại diện cho cổ phần của cả hai kết quả.
    
3.  **Giao Dịch Outcome Tokens:**  
    Người dùng có thể mua/bán token kết quả thông qua bể thanh khoản với mức phí giao dịch nhỏ. Giá của token được xác định dựa trên tỷ lệ giữa số dư của token đó và tổng số dư trong bể.
    
4.  **Giải Quyết Thị Trường:**
    
    -   Người dùng đặt cọc một khoản bond và khẳng định kết quả của thị trường.
    -   Trong thời gian “liveness” (ví dụ: 2 giờ), người dùng khác có thể phản đối khẳng định đó.
    -   Nếu không có phản đối, kết quả được xác nhận và người khẳng định nhận lại bond cùng với phần thưởng của thị trường.
    -   Nếu có phản đối, cơ chế “Escalation Manager” can thiệp và admin sẽ ra quyết định cuối cùng. Người thắng cuộc sẽ lấy lại bond và nhận thêm phần trăm từ bond của đối thủ (sau khi trừ phí).
5.  **Hoạt Động Sau Khi Giải Quyết Thị Trường:**  
    Sau khi thị trường được xác nhận, các hoạt động giao dịch trên bể thanh khoản dừng lại. Người dùng vẫn có thể đổi token LP lấy các outcome tokens, sau đó quy đổi để nhận lại tài sản ban đầu dựa trên tỷ lệ thắng thua của token.
    

## Kiến Trúc Kỹ Thuật

-   **Tích hợp chức năng:**  
    Các chức năng của Optimistic Oracle, Liquidity Pool, Automated Market Maker (AMM) và thị trường dự đoán được tích hợp trong một module duy nhất cùng với module Escalation Manager.
    
-   **Lưu Trữ Dữ Liệu:**  
    Sử dụng mô hình đối tượng của Aptos, các đối tượng thị trường, khẳng định và bể thanh khoản được lưu trữ trên tài khoản của người dùng, giúp phân tán dữ liệu, tối ưu hóa chi phí gas và tăng khả năng mở rộng.
    
-   **Mã ID Đơn Giản:**  
    Các ID của thị trường và khẳng định sử dụng số nguyên (u64) thay vì hàm băm, giúp dễ dàng truy xuất và quản lý dữ liệu.
    

## Các Điểm Nổi Bật

-   **Tích hợp Ví:** Cho phép người dùng kết nối ví Aptos để tương tác với nền tảng.
-   **Giao Dịch Thông Minh:** Mô hình AMM sử dụng công thức tỷ lệ để đảm bảo tổng giá trị luôn bằng 1, khác với công thức x * y = k truyền thống.
-   **Quản Lý Khẳng Định:** Tích hợp cơ chế Escalation Manager cho phép admin quản lý và giải quyết tranh chấp khi có khẳng định sai lệch hoặc gian lận.
-   **Thanh Khoản và LP Tokens:** Người dùng có thể nạp và rút thanh khoản thông qua token LP, nhận lại tài sản tương ứng với tỷ lệ trong bể thanh khoản.

## Các Điểm Cần Lưu Ý Cho Admin

-   **Cài Đặt Chính Sách:** Admin có thể cập nhật các chính sách khẳng định như chặn khẳng định, kiểm tra người khẳng định hay phản đối.
-   **Quyết Định Tranh Chấp:** Trong trường hợp tranh chấp, admin có quyền ra quyết định cuối cùng thông qua cơ chế Escalation Manager.

## Quy Trình Triển Khai và Kiểm Thử

-   **Biên dịch và Triển khai:**  
    Các lệnh để biên dịch và triển khai module được thiết kế để đảm bảo quá trình cập nhật nhanh chóng và an toàn.
    
-   **Kiểm Thử:**  
    Mã nguồn của AptosForo đã được kiểm thử toàn diện với 100% độ bao phủ, đảm bảo tính ổn định và độ tin cậy của hệ thống.
    

## Kế Hoạch Phát Triển Tương Lai

-   **Tích Hợp Gnosis Conditional Tokens:** Cho phép tạo các kết quả kết hợp linh hoạt hơn cho các thị trường phức tạp.
-   **Liquidity Mining:** Cung cấp phần thưởng cho người nạp thanh khoản nhằm tăng độ sâu thị trường.
-   **Giao Diện Nâng Cao:** Phát triển giao diện với phân tích và biểu đồ tiên tiến để hỗ trợ người dùng theo dõi dự đoán.
-   **Quản Trị Cộng Đồng:** Triển khai mô hình quản trị cộng đồng cho phép người dùng tham gia vào việc quyết định các chính sách của nền tảng.
