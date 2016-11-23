$ip=(Get-NetIPAddress -AddressFamily IPv4 `
   | Where-Object -FilterScript { $_.InterfaceAlias -Eq "vEthernet (HNS Internal NIC)" } `
   ).IPAddress
docker run -d -p 8080:8080 -e DOCKER_HOST=${ip}:2375 --name=visualizer stefanscherer/visualizer-windows
