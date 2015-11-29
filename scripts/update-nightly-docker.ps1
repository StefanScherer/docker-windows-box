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

# tag the base images to latest if the tag got lost through update
if ("$(docker images windowsservercore:latest | wc -l)" -eq "1") {
  docker tag windowsservercore:10.0.10586.0 windowsservercore:latest
}
if ("$(docker images nanoserver:latest | wc -l)" -eq "1") {
  docker tag nanoserver:10.0.10586.0 nanoserver:latest
}

docker version
