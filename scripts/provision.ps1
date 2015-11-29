# install chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# install git + ssh
choco install -y git -params "/GitAndUnixToolsOnPath"

# install docker tools
choco install -y docker-machine -version 0.5.1
choco install -y docker-compose -version 1.5.1

# docker-machine -D create -d hyperv dev
