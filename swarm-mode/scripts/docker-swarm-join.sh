#!/bin/bash
managerip=$2
ip=$4

if [ -z $ip ]; then
  ip=$(ip -4 a | grep inet | grep -v docker | grep -v 127.0.0.1 | grep -v 10.0.2.15 | tail -1 | sed 's,.*inet ,,' | sed 's,/.*,,')
fi

if [ -z $managerip ]; then
  managerip="$(echo $ip | sed 's/\.[^.]*$//').2";
  Write-Host Assuming manager IP address $managerip
fi

echo 'Fetching token from swarm manager'
token=$(docker -H tcp://${managerip}:2375 swarm join-token worker -q)

docker swarm join --token $token --listen-addr "$ip:2377" --advertise-addr "$ip:2377" "$managerip:2377"
