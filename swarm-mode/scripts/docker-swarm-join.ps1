param ([String] $managerip, [String] $ip)

if ($ip -Eq "") {
  $ip=(Get-NetIPAddress -AddressFamily IPv4 `
     | Where-Object -FilterScript { $_.InterfaceAlias -Ne "vEthernet (HNS Internal NIC)" } `
     | Where-Object -FilterScript { $_.IPAddress -Ne "127.0.0.1" } `
     | Where-Object -FilterScript { $_.IPAddress -Ne "10.0.2.15" } `
     ).IPAddress
  Write-Host Using IP address $ip
}

if ($managerip -Eq "") {
  $managerip = $ip -Replace "\.\d+$", ".2";
  Write-Host Assuming manager IP address $managerip
}

Write-Host Fetching token from swarm manager
$token = $(docker -H tcp://${managerip}:2375 swarm join-token worker -q)

docker swarm join --token $token --listen-addr ${ip}:2377 --advertise-addr ${ip}:2377 ${managerip}:2377
