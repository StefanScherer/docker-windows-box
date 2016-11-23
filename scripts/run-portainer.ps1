$ip=(Get-NetIPAddress -AddressFamily IPv4 `
   | Where-Object -FilterScript { $_.InterfaceAlias -Eq "vEthernet (HNS Internal NIC)" } `
   ).IPAddress

docker kill portainer
docker rm -vf portainer

if (Test-Path $env:USERPROFILE\.docker\ca.pem) {
  docker run -d -p 8000:9000 `
    -v $env:USERPROFILE\.docker:C:\certs --name portainer portainer/portainer:windows `
    -H tcp://$($ip):2376 --tlsverify
} else {
  docker run -d -p 8000:9000 --name portainer portainer/portainer:windows -H tcp://$($ip):2375
}
