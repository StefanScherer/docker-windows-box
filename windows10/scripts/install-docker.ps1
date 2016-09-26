# https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10
Set-ExecutionPolicy Bypass -scope Process

Set-ItemProperty -Path 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers' -Name VSmbDisableOplocks -Type DWord -Value 1 -Force

New-Item -Type Directory -Path "$($env:ProgramFiles)\docker"
Invoke-WebRequest "https://master.dockerproject.com/windows/amd64/docker-1.13.0-dev.zip" -OutFile "$env:TEMP\docker-1.13.0-dev.zip" -UseBasicParsing
Expand-Archive -Path $env:TEMP\docker-1.13.0-dev.zip -DestinationPath $env:ProgramFiles -Force
Remove-Item $env:TEMP\docker-1.13.0-dev.zip
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker

Start-Service Docker

Write-Host "Installing NanoServer docker image..."
docker pull microsoft/nanoserver:10.0.14393.206
docker pull microsoft/nanoserver
