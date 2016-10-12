# https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10
Set-ExecutionPolicy Bypass -scope Process

New-Item -Type Directory -Path "$($env:ProgramFiles)\docker"
$wc = New-Object net.webclient
$wc.Downloadfile("https://master.dockerproject.com/windows/amd64/docker-1.13.0-dev.zip", "$env:TEMP\docker-1.13.0-dev.zip")
Expand-Archive -Path $env:TEMP\docker-1.13.0-dev.zip -DestinationPath $env:ProgramFiles -Force
Remove-Item $env:TEMP\docker-1.13.0-dev.zip
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker

Start-Service Docker

Write-Host "Installing NanoServer docker image..."
docker pull microsoft/nanoserver:10.0.14393.321
docker pull microsoft/nanoserver
