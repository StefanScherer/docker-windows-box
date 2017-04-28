#!/bin/bash
managerip=$2
ip=$4
token=$(cat /vagrant/resources/worker-token)

docker swarm join --token $token --listen-addr "$ip:2377" --advertise-addr "$ip:2377" "$managerip:2377"
