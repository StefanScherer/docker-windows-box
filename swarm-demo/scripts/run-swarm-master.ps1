$TOKEN=$(cat C:\vagrant\config\swarm-token | %{$_ -replace '\s',''})
docker run -d -p 3375:2375 --name=swarm-master --restart=always stefanscherer/swarm-windows:1.2.5-nano manage "token://$TOKEN"
