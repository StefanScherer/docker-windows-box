$ip=(Get-NetIPAddress -AddressFamily IPv4 `
   | Where-Object -FilterScript { $_.InterfaceAlias -Eq "vEthernet (HNS Internal NIC)" } `
   ).IPAddress

if (Test-Path $env:USERPROFILE\.docker\ca.pem) {
  docker run -d -p 8080:8080 `
    -e DOCKER_HOST=${ip}:2376 -e DOCKER_TLS_VERIFY=1 `
    -v "$env:USERPROFILE\.docker:C:\Users\ContainerAdministrator\.docker" `
    --name=visualizer stefanscherer/visualizer-windows:allow-tls
} else {
  docker run -d -p 8080:8080 `
    -e DOCKER_HOST=${ip}:2375 --name=visualizer stefanscherer/visualizer-windows:allow-tls
}
