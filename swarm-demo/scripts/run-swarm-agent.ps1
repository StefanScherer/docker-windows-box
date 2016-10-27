$TOKEN=(cat C:\vagrant\config\swarm-token)
$ip=(Get-NetIPAddress -AddressFamily IPv4 `
   | Where-Object -FilterScript { $_.InterfaceAlias -Ne "vEthernet (HNS Internal NIC)" } `
   | Where-Object -FilterScript { $_.IPAddress -Ne "127.0.0.1" } `
   | Where-Object -FilterScript { $_.IPAddress -Ne "10.0.2.15" } `
   ).IPAddress

Write-Host "Adding host $($ip):2375 to swarm"
docker run --restart=always -d stefanscherer/swarm-windows:1.2.5-nano join "--addr=$($ip):2375" "token://$TOKEN"
