#!/bin/bash
TOKEN=$(cat /vagrant/config/swarm-token | sed 's/\s//g')
docker run -d -p 3375:2375 --restart=always swarm:1.1.0 manage "token://$TOKEN"

echo "... Redirect Port"
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3375 -j REDIRECT --to-port 3375
echo "... Save iptables"
iptables-save
