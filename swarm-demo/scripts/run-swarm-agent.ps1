$TOKEN=(cat C:\vagrant\config\swarm-token)
$ip=( (Get-NetIPAddress | Where-Object -FilterScript { $_.InterfaceAlias -Eq "Ethernet 2" } | select-object IPAddress)[1].IPAddress)

if (! $ip) {
  $ip=( (Get-NetIPAddress | Where-Object -FilterScript { $_.InterfaceAlias -Eq "Ethernet1" } | select-object IPAddress)[1].IPAddress)  
}
Write-Host "Adding host $($ip):2375 to swarm"
docker run --restart=always -d stefanscherer/swarm-windows:1.2.5 join "--addr=$($ip):2375" "token://$TOKEN"
