#!/bin/bash
curl https://get.docker.com | sh
sudo usermod -aG docker vagrant

sudo sed -i 's/^DOCKER_OPTS=.*$//' /etc/default/docker
echo "DOCKER_OPTS=\"-H unix:// -H 0.0.0.0:2375\"" | sudo tee -a /etc/default/docker
sudo service docker restart

sleep 10
