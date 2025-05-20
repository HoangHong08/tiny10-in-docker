# Tiny10 in Docker (Works in GitHub Codespace)

This project lets you run a lightweight Windows (Tiny10) inside Docker — perfect for running Wwise, testing apps, or using Windows on Linux/cloud.

## How to Use

```bash
git clone https://github.com/HoangHong08/tiny10-in-docker.git
cd tiny10-in-docker
chmod +x setup.sh start.sh
./setup.sh     # Download Tiny10 ISO
./start.sh     # Boot Tiny10 in Docker

Open http://localhost:8006 to begin installing Tiny10.

Why?

No need for Windows, WSL, or VirtualBox

Fully offline & lightweight

Works in Codespace (Linux-based cloud)


Notes

ISO: Tiny10 x64 beta 2 (~2.5GB)

Disk size: Default 64GB (dynamic)

After install, you can RDP into Windows via port 3389
