$ErrorActionPreference = 'Stop';
cd $PSScriptRoot
start http://$(docker inspect -f '{{ .NetworkSettings.Networks.nat.IPAddress }}' portainer):9000
