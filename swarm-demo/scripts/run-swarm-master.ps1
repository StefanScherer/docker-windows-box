$TOKEN=$(cat C:\vagrant\config\swarm-token | %{$_ -replace '\s',''})
docker run -d -p 3375:2375 --restart=always stefanscherer/swarm-windows:1.2.2 manage "token://$TOKEN"
