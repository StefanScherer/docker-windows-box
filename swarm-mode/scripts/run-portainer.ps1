$ip=(Get-NetIPAddress -AddressFamily IPv4 `
   | Where-Object -FilterScript { $_.InterfaceAlias -Eq "vEthernet (HNS Internal NIC)" } `
   ).IPAddress

docker service rm portainer

if (!(Test-Path C:\portainerdata)) {
  mkdir C:\portainerdata
}

if (Test-Path $env:USERPROFILE\.docker\ca.pem) {
    # --publish 9000:9000 `
  docker service create `
    --constraint 'node.role == manager' `
    --mount type=bind,src=$env:USERPROFILE\.docker,dst=C:\ProgramData\portainer\certs `
    --mount type=bind,src=C:\portainerdata,dst=C:\data `
    --name portainer portainer/portainer:1.11.3 `
    -H tcp://$($ip):2376 --tlsverify
} else {
    # --publish 9000:9000 `
  docker service create `
    --constraint 'node.role == manager' `
    --mount type=bind,src=C:\portainerdata,dst=C:\data `
    --name portainer portainer/portainer:1.11.3 `
    -H tcp://$($ip):2375
}
