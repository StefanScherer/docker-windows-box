$ip=(Get-NetIPAddress -AddressFamily IPv4 `
   | Where-Object -FilterScript { $_.InterfaceAlias -Eq "vEthernet (HNS Internal NIC)" } `
   ).IPAddress

docker kill portainer
docker rm -vf portainer

if (!(Test-Path C:\portainerdata)) {
  mkdir C:\portainerdata
}

if (Test-Path $env:USERPROFILE\.docker\ca.pem) {
  docker run -d -p 8000:9000 `
    -v C:\portainerdata:C:\data `
    -v $env:USERPROFILE\.docker:C:\certs `
    --name portainer portainer/portainer:1.11.3 `
    -H tcp://$($ip):2376 --tlsverify
} else {
  docker run -d -p 8000:9000 `
    -v C:\portainerdata:C:\data `
    --name portainer portainer/portainer:1.11.3 -H tcp://$($ip):2375
}
