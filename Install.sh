#!/bin/bash

ISO_FILE="custom.iso"
PROJECT_DIR="$(pwd)/project"

if [ ! -f "$ISO_FILE" ]; then
  echo "Lỗi: Không tìm thấy $ISO_FILE"
  echo "→ Hãy chạy ./setup.sh trước để tải ISO Tiny10."
  exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
  echo ">> Tạo thư mục project..."
  mkdir -p "$PROJECT_DIR"
fi

echo ">> Khởi động trình cài đặt Tiny10 từ $ISO_FILE..."

docker run --rm -it \
  --device /dev/kvm \
  -e MANUAL="Y" \
  -p 8006:8006 -p 3389:3389 \
  -v "$(pwd):/storage" \
  -v "$PROJECT_DIR:/project" \
  dockurr/windows
  
