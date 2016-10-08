$TOKEN=$(cat C:\vagrant\config\swarm-token | %{$_ -replace '\s',''})
docker run -d -p 3375:2375 --restart=always stefanscherer/swarm-windows:1.2.5 manage "token://$TOKEN"
