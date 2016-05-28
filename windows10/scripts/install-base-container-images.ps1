# https://msdn.microsoft.com/de-de/virtualization/windowscontainers/quick_start/quick_start_windows_10
Set-ExecutionPolicy Bypass -scope Process
Install-PackageProvider ContainerImage -Force
Install-ContainerImage -Name NanoServer
Restart-Service docker
. 'C:\Program Files\docker\docker' tag nanoserver:10.0.14300.1010 nanoserver:latest
