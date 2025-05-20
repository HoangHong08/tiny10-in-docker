#!/bin/bash

ISO_FILE="custom.iso"
DISK_MARKER="windows.base"
PROJECT_DIR="$(pwd)/project"

echo ">> Kiểm tra thư mục dự án..."
# Tạo thư mục project nếu chưa có
if [ ! -d "$PROJECT_DIR" ]; then
  echo ">> Chưa có thư mục project/. Đang tạo..."
  mkdir -p "$PROJECT_DIR"
fi

echo ">> Đang khởi động Windows Tiny10..."

# Nếu đã cài Windows rồi
if [ -f "$DISK_MARKER" ]; then
  echo ">> Đã phát hiện hệ điều hành. Khởi động từ ổ đĩa..."
  docker run --rm -it \
    --device /dev/kvm \
    -p 8006:8006 -p 3389:3389 \
    -v "$(pwd):/storage" \
    -v "$PROJECT_DIR:/project" \
    dockurr/windows
else
  if [ ! -f "$ISO_FILE" ]; then
    echo "Lỗi: Không có file ISO ($ISO_FILE) để cài đặt. Vui lòng chạy ./setup.sh trước."
    exit 1
  fi

  echo ">> Chưa có hệ điều hành. Cài đặt từ ISO..."
  docker run --rm -it \
    --device /dev/kvm \
    -p 8006:8006 -p 3389:3389 \
    -v "$(pwd):/storage" \
    -v "$PROJECT_DIR:/project" \
    -e MANUAL="Y" \
    dockurr/windows
fi
