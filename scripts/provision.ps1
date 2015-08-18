# install chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# install git + ssh
choco install -y git -params "/GitAndUnixToolsOnPath"

# install docker tools
choco install -y docker -version 1.8.1
choco install -y docker-machine -version 0.4.1

# Windows 10: you could also use builtin cmdlets
# Get-PackageProvider -Name chocolatey -forcebootstrap
# Install-Package docker -force
# Install-Package docker-machine -force

# install hyper-v
# Install-WindowsFeature -name hyper-v -IncludeManagementTools
# dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All /NoRestart

# enable UAC
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -Value 1

# alternatives:
choco install -y virtualbox
# choco install -y vmwareworkstation

# setx CYGWIN nodosfilewarning
# $ENV:CYGWIN="nodosfilewarning"

# docker-machine create -d virtualbox dev
# docker-machine env dev
