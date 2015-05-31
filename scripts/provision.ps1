iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y virtualbox
choco install -y docker
choco install -y docker-machine

setx CYGWIN nodosfilewarning
$ENV:CYGWIN="nodosfilewarning"

docker-machine create -d virtualbox dev
docker-machine env dev
