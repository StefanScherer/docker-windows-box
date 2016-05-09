stop-service docker
wget -outfile C:\Windows\System32\dockerd.exe -uri https://master.dockerproject.org/windows/amd64/dockerd.exe
wget -outfile C:\Windows\System32\docker.exe -uri https://master.dockerproject.org/windows/amd64/docker.exe
start-service docker
