#!/bin/bash -x
ip=$2
docker swarm init --listen-addr "$ip:2377" --advertise-addr "$ip:2377"

# use Vagrant shared folder to transfer token to other managers and workers
if [ ! -d /vagrant/resources ]; then
  mkdir -p /vagrant/resources
fi

docker swarm join-token manager -q >/vagrant/resources/manager-token
docker swarm join-token worker -q >/vagrant/resources/worker-token
