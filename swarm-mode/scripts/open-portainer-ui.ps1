$ErrorActionPreference = 'Stop';
& netsh advfirewall firewall add rule name="Portainer helper" dir=in action=allow protocol=TCP localport=9000

start http://$(docker inspect -f '{{ .NetworkSettings.Networks.nat.IPAddress }}' $(docker ps -q --filter name=^/portainer)):9000
