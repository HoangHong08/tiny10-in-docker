#!/bin/bash

ISO_FILE="custom.iso"
DISK_MARKER="windows.base"     # Tệp đại diện cho Windows Tiny10 đã cài
PROJECT_DIR="$(pwd)/project"

echo ">> Kiểm tra thư mục dự án..."
# Tạo thư mục project nếu chưa có
if [ ! -d "$PROJECT_DIR" ]; then
  echo ">> Chưa có thư mục project/. Đang tạo..."
  mkdir -p "$PROJECT_DIR"
fi

echo ">> Đang khởi động Windows Tiny10..."

# Nếu đã có Windows được cài (dựa vào windows.base)
if [ -f "$DISK_MARKER" ]; then
  echo ">> Đã phát hiện hệ điều hành Tiny10. Khởi động từ ổ đĩa..."
  docker run --rm -it \
    --device /dev/kvm \
    -p 8006:8006 -p 3389:3389 \
    -v "$(pwd):/storage" \
    -v "$PROJECT_DIR:/project" \
    dockurr/windows

# Nếu chưa có hệ điều hành, cần ISO để cài
elif [ -f "$ISO_FILE" ]; then
  echo ">> Chưa phát hiện hệ điều hành. Cài đặt từ $ISO_FILE..."
  docker run --rm -it \
    --device /dev/kvm \
    -p 8006:8006 -p 3389:3389 \
    -v "$(pwd):/storage" \
    -v "$PROJECT_DIR:/project" \
    -e MANUAL="Y" \
    dockurr/windows

# Nếu không có ISO và cũng không có OS đã cài → KHÔNG khởi động gì cả
else
  echo "Lỗi: Không có ISO ($ISO_FILE) và cũng không phát hiện hệ điều hành đã cài."
  echo "→ Có thể bạn đã xóa ISO. Nếu bạn đã cài Tiny10 trước đó, hãy đảm bảo các file hệ điều hành như windows.base vẫn còn."
  echo "→ Nếu muốn cài lại, hãy chạy ./setup.sh để tải lại ISO."
  exit 1
fi
