stop-service docker
wget -outfile $env:TEMP\docker-1.12.0.zip https://get.docker.com/builds/Windows/x86_64/docker-1.12.0.zip
Expand-Archive -Path $env:TEMP\docker-1.12.0.zip -DestinationPath $env:TEMP -Force
copy $env:TEMP\docker\*.exe $env:ProgramFiles\docker

if (Test-Path "$($env:ProgramData)\docker\image\Windows filter storage driver") {
  ren "$($env:ProgramData)\docker\image\Windows filter storage driver" "$($env:ProgramData)\docker\image\windowsfilter"
}

start-service docker
