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
