# https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10
Set-ExecutionPolicy Bypass -scope Process

New-Item -Type Directory -Path "$($env:ProgramFiles)\docker"
$wc = New-Object net.webclient
$wc.Downloadfile("https://get.docker.com/builds/Windows/x86_64/docker-1.13.1.zip", "$env:TEMP\docker-1.13.1.zip")
Expand-Archive -Path $env:TEMP\docker-1.13.1.zip -DestinationPath $env:ProgramFiles -Force
Remove-Item $env:TEMP\docker-1.13.1.zip
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker --label os=windows

Start-Service docker
