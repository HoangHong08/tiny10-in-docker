#!/bin/bash

WINDOWS_FILES=("windows.base" "windows.boot" "windows.rom" "windows.vars")
ALL_PRESENT=true

PROJECT_DIR="$(pwd)/project"
if [ ! -d "$PROJECT_DIR" ]; then
  echo ">> Tạo thư mục project..."
  mkdir -p "$PROJECT_DIR"
fi

echo ">> Kiểm tra file hệ điều hành..."

for file in "${WINDOWS_FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo ">> Thiếu: $file"
    ALL_PRESENT=false
  fi
done

if [ "$ALL_PRESENT" = true ]; then
  echo ">> Khởi động Tiny10 từ ổ đĩa..."
  docker run --rm -it \
    --device /dev/kvm \
    -e MANUAL="N" \
    -e NO_DOWNLOAD="1" \
    -p 8006:8006 -p 3389:3389 \
    -v "$(pwd):/storage" \
    -v "$PROJECT_DIR:/project" \
    dockurr/windows
else
  echo
  echo ">>> DỪNG: Không đủ file hệ điều hành. KHÔNG cài lại, KHÔNG tải ISO."
  echo ">>> Nếu muốn cài Tiny10, dùng ./install.sh và đảm bảo custom.iso đã có."
  exit 1
fi
