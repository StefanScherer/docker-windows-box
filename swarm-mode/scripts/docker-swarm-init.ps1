param ([String] $ip)

docker swarm init --listen-addr ${ip}:2377 --advertise-addr ${ip}:2377
