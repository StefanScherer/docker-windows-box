$ProgressPreference = 'SilentlyContinue';

# Containers feature is already installed in Vagrant basebox
# Install-PackageProvider -Name NuGet -Force
# Install-Module -Name xNetworking -Force

$version="1.13.0-rc5"
Invoke-WebRequest -UseBasicParsing https://test.docker.com/builds/Windows/x86_64/docker-$($version).zip -OutFile docker-$($version).zip
Expand-Archive docker-$($version).zip -DestinationPath $env:ProgramFiles

$env:PATH = "$env:ProgramFiles\docker;" + $env:PATH
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH
Remove-Item -Path docker-$($version).zip
& dockerd --register-service -H tcp://0.0.0.0:2375 -H npipe://
New-NetFirewallRule -DisplayName 'Docker Insecure Port 2375' -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 2375
