iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y curl
choco install -y virtualbox

curl -k -L -o C:\programdata\chocolatey\bin\docker-machine.exe https://github.com/docker/machine/releases/download/v0.2.0-rc3/docker-machine_windows-amd64.exe
curl -k -L -o C:\programdata\chocolatey\bin\docker.exe https://master.dockerproject.com/windows/amd64/docker.exe

setx CYGWIN nodosfilewarning
