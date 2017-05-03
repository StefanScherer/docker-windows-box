#!/bin/bash -x
ip=$2
docker swarm init --listen-addr "$ip:2377" --advertise-addr "$ip:2377"

echo "Warning: Do not insecure Docker port 2375 in production!"
sudo systemctl stop docker
sudo sed -i 's,-H fd://,-H tcp://0.0.0.0:2375 -H fd://,' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo systemctl start docker
