"Updating docker engine"
docker version
"Stopping docker service"
stop-service docker
if (!(Test-Path C:\windows\system32\docker-orig.exe)) {
  "Saving docker original docker engine"
  copy-item C:\windows\system32\docker.exe C:\windows\system32\docker-orig.exe
}
"Downloading nightly build of docker engine"
wget https://master.dockerproject.org/windows/amd64/docker.exe -outfile C:\windows\system32\docker.exe
"Starting docker service"
start-service docker
docker version
