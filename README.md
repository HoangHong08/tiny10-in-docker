
Hướng Dẫn Sử Dụng Môi Trường Windows Tiny10 & Wwise trên GitHub Codespace (Từ Kho Lưu Trữ Đã Chuẩn Bị Sẵn)
Mục tiêu: Nhanh chóng triển khai và sử dụng một môi trường Windows Tiny10 (đã tối ưu cho Wwise) bên trong Docker, thông qua GitHub Codespace, bằng cách sử dụng kho lưu trữ đã được cấu hình sẵn các kịch bản cần thiết.
!! BẮT BUỘC: Bước 0 - Fork (Sao Chép) Kho Lưu Trữ Này Về Tài Khoản GitHub Của Bạn !!
Đây là bước đầu tiên và quan trọng nhất để bạn có thể làm việc độc lập và hiệu quả:
 * Trên trang GitHub của kho lưu trữ này (kho lưu trữ mà bạn đang xem, do người cung cấp hướng dẫn này tạo ra), hãy tìm nút "Fork" ở góc trên bên phải.
 * Nhấp vào nút "Fork" để tạo một bản sao đầy đủ của kho lưu trữ này về tài khoản GitHub cá nhân của bạn.
 * Sau khi quá trình fork hoàn tất, hãy đi đến kho lưu trữ bạn vừa fork trên tài khoản của mình.
 * Từ trang kho lưu trữ đã fork của bạn, khởi tạo và mở một GitHub Codespace mới.
Lý do forking: Việc này đảm bảo bạn làm việc trên một bản sao của riêng mình, cho phép Codespace lưu trữ các thay đổi, cài đặt Windows và các ứng dụng mà không ảnh hưởng đến kho lưu trữ gốc hoặc công việc của người khác. Đây là cách làm việc chuẩn khi sử dụng các dự án mẫu trên GitHub.
Step 1: Mở Codespace và Chạy Kịch Bản Thiết Lập Ban Đầu (setup.sh)
Sau khi Codespace của bạn đã khởi động từ kho lưu trữ đã fork:
 * Các kịch bản đã sẵn sàng: Kho lưu trữ này đã cung cấp sẵn cho bạn hai kịch bản quan trọng là setup.sh và start.sh. Bạn không cần phải tạo lại chúng.
   * setup.sh: Kịch bản này sẽ tự động kiểm tra xem Docker có sẵn không và tải xuống file ISO của Windows Tiny10 (tên là custom.iso, khoảng 2.5GB) nếu nó chưa có trong thư mục làm việc của Codespace.
 * Mở Terminal: Trong giao diện Codespace, mở một cửa sổ dòng lệnh (terminal).
 * Cấp quyền thực thi cho các kịch bản: Để đảm bảo bạn có thể chạy các kịch bản, hãy cấp quyền thực thi cho chúng bằng lệnh sau (chỉ cần làm một lần):
 #  chmod +x setup.sh
#chmod +x start.sh

 * Chạy kịch bản setup.sh: Thực thi kịch bản để chuẩn bị môi trường:
  # ./setup.sh

   Theo dõi các thông báo trên terminal. Quá trình tải ISO có thể mất một chút thời gian tùy thuộc vào tốc độ mạng của Codespace.
Step 2: Khởi Chạy Máy Ảo Windows Tiny10 (start.sh)
Khi setup.sh đã hoàn tất và file custom.iso đã có sẵn:
 * Kịch bản start.sh: Kịch bản này sẽ sử dụng Docker để khởi động máy ảo Windows từ file custom.iso. Nó đã được cấu hình sẵn các thông số cần thiết như RAM, CPU, và ánh xạ cổng.
 * Chạy kịch bản start.sh: Trong terminal, thực thi lệnh:
 #  ./start.sh

   Lệnh này sẽ khởi động container Docker chứa Windows. Quá trình này có thể mất vài phút.
Step 3: Cài Đặt Windows Tiny10 Lần Đầu (Tương Tác Qua Trình Duyệt)
 * Truy cập giao diện cài đặt:
   * Sau khi chạy ./start.sh, GitHub Codespace sẽ tự động chuyển tiếp (forward) port 8006.
   * Một thông báo có thể xuất hiện ở góc dưới bên phải màn hình, hỏi bạn có muốn mở port đó trong trình duyệt không. Hãy đồng ý.
   * Hoặc, bạn có thể vào tab "PORTS" trong giao diện Codespace, tìm port 8006 và nhấp vào biểu tượng quả địa cầu (Open in Browser) bên cạnh nó (nếu nó bắt đăng nhập thì phải chuyển nó qua public).
 * Thực hiện các bước cài đặt Windows:
   * Bạn sẽ thấy màn hình cài đặt Windows trong tab trình duyệt mới. Hãy làm theo các hướng dẫn trên màn hình.
   * Ngôn ngữ, định dạng, bàn phím: Chọn tùy chọn phù hợp.
   * Product Key: Nhấp vào "I don't have a product key".
   * Phiên bản Windows: Chọn phiên bản Tiny10 được liệt kê.
   * Loại cài đặt: Chọn "Custom: Install Windows only (advanced)".
   * Nơi cài đặt: Chọn ổ đĩa chưa được phân bổ (thường là "Drive 0 Unallocated Space") và nhấn "Next".
   * Windows sẽ bắt đầu quá trình cài đặt. Sau khi hoàn tất, máy ảo sẽ tự khởi động lại.
 * Hoàn tất thiết lập và tạo tài khoản: Sau khi khởi động lại, Windows sẽ yêu cầu bạn thực hiện một số thiết lập cuối cùng và tạo một tài khoản người dùng cục bộ (local account) cùng mật khẩu. Hãy tạo và ghi nhớ thông tin này để đăng nhập vào Windows.
Các Ghi Chú Quan Trọng và Mẹo:
 * Kho lưu trữ đã Fork: Luôn nhớ rằng bạn đang làm việc trên Codespace của kho lưu trữ đã fork. Mọi thay đổi, file dự án Wwise (nên lưu trong thư mục được ánh xạ /storage) có thể được commit và push lên kho lưu trữ forked của bạn.
 * Thư mục chia sẻ /storage: Kịch bản start.sh được cấu hình để ánh xạ một thư mục từ Codespace của bạn (thường là $(pwd)/shared_storage hoặc $(pwd)) vào bên trong máy ảo Windows dưới dạng ổ đĩa /storage. Đây là nơi lý tưởng để lưu trữ file dự án và chia sẻ dữ liệu giữa Codespace và Windows. Kiểm tra lại nội dung file start.sh để biết chính xác thư mục nào được ánh xạ.
 * Kiểm tra dung lượng trống: Dùng lệnh df -h trong terminal Codespace.
 * Tài nguyên máy ảo: Các kịch bản start.sh đã định sẵn các thông số RAM, CPU. Nếu cần thiết và bạn hiểu rõ, bạn có thể chỉnh sửa file start.sh (trong kho lưu trữ forked của mình) để thay đổi các giá trị này (ví dụ: RAM_SIZE, CPU_CORES)!
 * Khởi động lại Windows: Nếu bạn đóng Codespace và mở lại, chỉ cần chạy lại ./start.sh để khởi động máy ảo Windows đã cài đặt.
Hoàn Tất!
Giờ đây bạn đã có một môi trường Windows Tiny10 sẵn sàng, được triển khai nhanh chóng từ một kho lưu trữ đã được chuẩn bị sẵn. Chúc bạn làm việc hiệu quả!
