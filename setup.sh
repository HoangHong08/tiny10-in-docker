#!/bin/bash
set -e

ISO_URL="https://archive.org/download/tiny-10-NTDEV/tiny10%20x64%20beta%202.iso"
ISO_FILE="custom.iso"

echo ">> Kiểm tra Docker..."
if ! command -v docker &>/dev/null; then
  echo "Lỗi: Docker chưa được cài!"
  exit 1
fi

echo ">> Kiểm tra curl..."
if ! command -v curl &>/dev/null; then
  echo "Lỗi: curl chưa được cài!"
  exit 1
fi

if [ ! -f "$ISO_FILE" ]; then
  echo ">> Đang tải Tiny10 ISO..."
  curl -L -o "$ISO_FILE" "$ISO_URL"
else
  echo ">> Đã có file $ISO_FILE, bỏ qua bước tải."
fi

echo ">> Setup hoàn tất. Dùng ./start.sh để khởi chạy Windows Tiny10."
