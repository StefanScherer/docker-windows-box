# install chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# install git + ssh
choco install -y git -params "/GitAndUnixToolsOnPath"

# install docker tools
choco install -y docker -version 1.8.1

choco install -y docker-machine -version 0.3.0
curl -kL -o c:\ProgramData\chocolatey\bin\docker-machine.exe https://github.com/docker/machine/releases/download/v0.4.0/docker-machine_windows-amd64.exe


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
