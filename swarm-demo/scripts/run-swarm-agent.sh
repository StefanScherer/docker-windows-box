#!/bin/bash
TOKEN=$(cat /vagrant/config/swarm-token | sed 's/\s//g')
IP=$(ifconfig | grep "inet addr" | grep -v 172.17 | grep -v 10.0.2.15 | grep -v 127.0.0 | head -1 | cut -d : -f 2 | cut -d ' ' -f 1)
sudo docker run -d --restart=always swarm:1.2.2 join --addr=$IP:2375 "token://$TOKEN"
