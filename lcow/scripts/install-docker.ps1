Set-ExecutionPolicy Bypass -scope Process
$ProgressPreference = 'SilentlyContinue';

Write-Host "Downloading docker preview with Linux containers ..."
Invoke-WebRequest -OutFile "$env:TEMP\docker-17.10.0-ee-preview-3.zip" "https://download.docker.com/components/engine/windows-server/preview/docker-17.10.0-ee-preview-3.zip"
Expand-Archive -Path "$env:TEMP\docker-17.10.0-ee-preview-3.zip" -DestinationPath $env:ProgramFiles -Force
Remove-Item "$env:TEMP\docker-17.10.0-ee-preview-3.zip"

Write-Host "Downloading docker nightly ..."
Invoke-WebRequest -OutFile "$env:TEMP\docker-master.zip" "https://master.dockerproject.com/windows/x86_64/docker.zip"
Expand-Archive -Path "$env:TEMP\docker-master.zip" -DestinationPath $env:ProgramFiles -Force
Remove-Item "$env:TEMP\docker-master.zip"

$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
Write-Host "Registering docker service ..."
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker --experimental
Start-Service Docker
