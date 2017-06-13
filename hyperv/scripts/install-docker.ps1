$version = "17.06.0-ce-rc3"
New-Item -Type Directory -Path "$($env:ProgramFiles)\docker"
$wc = New-Object net.webclient
Write-Host Downloading Docker $version
$wc.DownloadFile("https://download.docker.com/win/static/test/x86_64/docker-$version-x86_64.zip", "$env:TEMP\docker-$version.zip")
Expand-Archive -Path "$env:TEMP\docker-$version.zip" -DestinationPath $env:ProgramFiles -Force
Remove-Item "$env:TEMP\docker-$version.zip"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375
Start-Service docker
& netsh advfirewall firewall add rule name="Docker insecure TCP" dir=in action=allow protocol=TCP localport=2375
Write-Host Docker Service running, listening on port 2375
