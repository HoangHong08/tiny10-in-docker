Hướng dẫn chạy Windows Tiny10 trong GitHub Codespace (Có hỗ trợ Wwise)

Mục tiêu:

Chạy bản Windows Tiny10 (nhẹ, tương thích tốt với Wwise) trong Docker thông qua GitHub Codespace.


---

Step 1: Download Tiny10 ISO (Tải ISO Tiny10)

Trong terminal của Codespace, chạy lệnh:

curl -L -o custom.iso "https://archive.org/download/tiny-10-NTDEV/tiny10%20x64%20beta%202.iso"

> File sẽ được lưu với tên custom.iso, dung lượng ~2.5GB




---

Step 2: Tạo file setup.sh (tự động tải ISO nếu chưa có)

Tạo file setup.sh với nội dung:

#!/bin/bash

set -e

ISO_URL="https://archive.org/download/tiny-10-NTDEV/tiny10%20x64%20beta%202.iso"
ISO_FILE="custom.iso"

echo ">> Kiểm tra Docker..."
if ! command -v docker &> /dev/null; then
  echo "Lỗi: Docker chưa được cài!"
  exit 1
fi

if [ ! -f "$ISO_FILE" ]; then
  echo ">> Đang tải Tiny10 ISO..."
  curl -L -o "$ISO_FILE" "$ISO_URL"
else
  echo ">> Đã có file $ISO_FILE, bỏ qua tải."
fi

echo ">> Setup hoàn tất. Dùng ./start.sh để khởi chạy Windows Tiny10."

Cấp quyền chạy:

chmod +x setup.sh


---

Step 3: Tạo file start.sh (dùng để chạy Docker boot ISO)

#!/bin/bash

ISO_FILE="custom.iso"

if [ ! -f "$ISO_FILE" ]; then
  echo "Lỗi: Không tìm thấy file $ISO_FILE. Hãy chạy ./setup.sh trước."
  exit 1
fi

echo ">> Đang khởi động Windows Tiny10..."
docker run --rm -it \
  --device /dev/kvm \
  -p 8006:8006 -p 3389:3389 \
  -v "$(pwd):/storage" \
  -e MANUAL="Y" \
  dockurr/windows

Cấp quyền chạy:

chmod +x start.sh


---

Step 4: Cài đặt Windows Tiny10

1. Mở trình duyệt preview hoặc port 8006:

URL: http://localhost:8006



2. Làm theo các bước cài đặt Tiny10 như bình thường (Tạo tài khoản khi được hỏi)



> Lưu ý: Biến USERNAME và PASSWORD không có tác dụng khi dùng ISO tùy chỉnh. Windows sẽ hỏi lại.




---

Step 5: Cài Wwise sau khi vào Windows

1. Truy cập: https://www.audiokinetic.com/download/


2. Tải và cài Wwise Launcher


3. Cài phiên bản Wwise 2019.2 hoặc bản bạn cần




---

Ghi chú quan trọng:

Nếu Codespace báo đầy dung lượng, xóa ISO:


rm custom.iso

Kiểm tra dung lượng trống:


df -h

RAM mặc định là 4GB (bạn có thể giảm bằng cách thêm -e RAM_SIZE="2G" vào dòng docker run nếu cần)



---

Hoàn tất!

Bạn đã cài thành công Windows Tiny10 trong Docker ngay trên Codespace — chạy được cả Wwise!

> Bạn có thể tạo repo chia sẻ lại bộ này cho cộng đồng dùng nhanh hơn!



