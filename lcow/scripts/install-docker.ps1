Set-ExecutionPolicy Bypass -scope Process
$ProgressPreference = 'SilentlyContinue';

Write-Host "Downloading LCOW LinuxKit ..."
Invoke-WebRequest -OutFile "$env:TEMP\linuxkit-lcow.zip" "https://23-111085629-gh.circle-artifacts.com/0/release.zip"
Expand-Archive -Path "$env:TEMP\linuxkit-lcow.zip" -DestinationPath "$env:ProgramFiles\Linux Containers" -Force
Remove-Item "$env:TEMP\linuxkit-lcow.zip"

Write-Host "Downloading docker nightly ..."
Invoke-WebRequest -OutFile "$env:TEMP\docker-master.zip" "https://master.dockerproject.com/windows/x86_64/docker.zip"
Expand-Archive -Path "$env:TEMP\docker-master.zip" -DestinationPath $env:ProgramFiles -Force
Remove-Item "$env:TEMP\docker-master.zip"

$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
Write-Host "Registering docker service ..."
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker --experimental
Start-Service Docker
