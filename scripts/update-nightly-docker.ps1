stop-service docker
wget -outfile $env:ProgramFiles\docker\dockerd.exe -uri https://master.dockerproject.org/windows/amd64/dockerd.exe
wget -outfile $env:ProgramFiles\docker\docker.exe -uri https://master.dockerproject.org/windows/amd64/docker.exe
start-service docker
