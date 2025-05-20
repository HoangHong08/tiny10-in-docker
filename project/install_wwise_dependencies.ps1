Write-Host ">>> Bắt đầu kiểm tra và cài đặt các gói cần thiết cho Wwise..." -ForegroundColor Cyan
$TempDir = "$env:TEMP\wwise_setup"
New-Item -ItemType Directory -Force -Path $TempDir | Out-Null
Set-Location $TempDir

# 1. .NET Framework 4.8
Write-Host "`n>> Kiểm tra .NET Framework 4.8..."
$netfx = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction SilentlyContinue
if ($netfx.Release -ge 528040) {
    Write-Host ">>> .NET 4.8 đã được cài." -ForegroundColor Green
} else {
    Write-Host ">>> Cài .NET 4.8..."
    Invoke-WebRequest "https://download.visualstudio.microsoft.com/download/pr/9e66fba1-d5bc-4307-87ff-eced09f89c5d/92d0e8c15b2c3b4db9eb0a45850735e6/ndp48-web.exe" -OutFile "ndp48-web.exe"
    Start-Process -FilePath ".\ndp48-web.exe" -ArgumentList "/q /norestart" -Wait
}

# 2. Visual C++ Redistributables
Write-Host "`n>> Kiểm tra Visual C++ Redistributables..."
$vcred = Get-WmiObject Win32_Product | Where-Object { $_.Name -like "*Visual C++*2015*" -and $_.Name -like "*x64*" }
if ($vcred) {
    Write-Host ">>> Visual C++ Redistributable đã được cài." -ForegroundColor Green
} else {
    Write-Host ">>> Cài VC++ Redistributable..."
    Invoke-WebRequest "https://aka.ms/vs/17/release/vc_redist.x64.exe" -OutFile "vc_redist.x64.exe"
    Start-Process -FilePath ".\vc_redist.x64.exe" -ArgumentList "/quiet /norestart" -Wait
}

# 3. DirectX
Write-Host "`n>> Kiểm tra DirectX..."
if (Test-Path "$env:WINDIR\System32\d3dx9_43.dll") {
    Write-Host ">>> DirectX End-User Runtime đã có." -ForegroundColor Green
} else {
    Write-Host ">>> Cài DirectX Runtime..."
    Invoke-WebRequest "https://download.microsoft.com/download/1/1C/1C6A3E4E-5C58-427A-8AC4-1BD0A6A32580/directx_Jun2010_redist.exe" -OutFile "directx_redist.exe"
    Start-Process ".\directx_redist.exe" -ArgumentList "/Q /T:dx_tmp" -Wait
    Start-Process ".\dx_tmp\DXSETUP.exe" -ArgumentList "/silent" -Wait
}

# 4. VB-Audio (tùy chọn)
Write-Host "`n>> Kiểm tra VB-Audio Virtual Cable..."
$vbDriver = Get-PnpDevice | Where-Object { $_.FriendlyName -like "*VB-Audio*" }
if ($vbDriver) {
    Write-Host ">>> VB-Audio đã cài." -ForegroundColor Green
} else {
    Write-Host ">>> Cài VB-Audio..."
    Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VBCABLE_Setup_x64.exe" -OutFile "VBCABLE_Setup_x64.exe"
    Start-Process -FilePath ".\VBCABLE_Setup_x64.exe" -ArgumentList "/S" -Wait
}

Write-Host "`n>>> Hoàn tất. Có thể khởi động lại trước khi dùng Wwise." -ForegroundColor Yellow
