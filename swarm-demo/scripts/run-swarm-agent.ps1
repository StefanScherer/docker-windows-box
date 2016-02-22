docker pull registry:5000/swarm:1.1.0
docker tag  registry:5000/swarm:1.1.0 swarm:1.1.0
docker tag  registry:5000/swarm:1.1.0 swarm:latest

$TOKEN=(cat C:\vagrant\config\swarm-token)
$ip=( (Get-NetIPAddress | Where-Object -FilterScript { $_.InterfaceAlias -Eq "Ethernet 2" } | select-object IPAddress)[1].IPAddress)

Write-Host "Adding host $($ip):2375 to swarm"
docker run --restart=always -d swarm:1.1.0 join "--addr=$($ip):2375" "token://$TOKEN"
