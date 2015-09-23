# install chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# install git + ssh
choco install -y git -params "/GitAndUnixToolsOnPath"

# Windows 2016 TP3: update to latest docker.exe
stop-service docker
wget https://master.dockerproject.org/windows/amd64/docker.exe -outfile C:\windows\system32\docker.exe
start-service docker

# Windows 10: install docker tools
# choco install -y docker -version 1.8.1
# choco install -y docker-machine -version 0.4.1

# Windows 10: you could also use builtin cmdlets
# Get-PackageProvider -Name chocolatey -forcebootstrap
# Install-Package docker -force
# Install-Package docker-machine -force

# install hyper-v
# Install-WindowsFeature -name hyper-v -IncludeManagementTools
# dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All /NoRestart

# enable UAC
# Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -Value 1

# alternatives:
# choco install -y virtualbox
# choco install -y vmwareworkstation

# setx CYGWIN nodosfilewarning
# $ENV:CYGWIN="nodosfilewarning"

# docker-machine create -d virtualbox dev
# docker-machine env dev
