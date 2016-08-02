stop-service docker
wget -outfile $env:ProgramFiles\docker\dockerd.exe -uri https://master.dockerproject.org/windows/amd64/dockerd.exe
wget -outfile $env:ProgramFiles\docker\docker.exe -uri https://master.dockerproject.org/windows/amd64/docker.exe

if (Test-Path "$($env:ProgramData)\docker\image\Windows filter storage driver") {
  ren "$($env:ProgramData)\docker\image\Windows filter storage driver" "$($env:ProgramData)\docker\image\windowsfilter"
}

start-service docker
