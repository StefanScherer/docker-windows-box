$ip = $(docker inspect --format '{{ json .NetworkSettings.Networks.nat.IPAddress }}' swarm-master)
docker run -d -p 9000:9000 portainer/portainer:windows -H tcp://$($ip):2375 --swarm
