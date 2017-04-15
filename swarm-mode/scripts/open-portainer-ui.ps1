$ErrorActionPreference = 'Stop';
start http://$(docker inspect -f '{{ .NetworkSettings.Networks.nat.IPAddress }}' $(docker ps -q --filter name=^/portainer)):9000
