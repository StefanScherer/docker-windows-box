
if ( "$(cat C:\programdata\docker\runDockerDaemon.cmd | sls 2375)" -Eq "") {
  stop-service docker

  cp C:\ProgramData\docker\runDockerDaemon.cmd C:\ProgramData\docker\runDockerDaemon.cmd.bak
  cat C:\ProgramData\docker\runDockerDaemon.cmd.bak `
    | %{$_ -replace '^dockerd -G docker -H npipe://\s*$','dockerd -G docker -H npipe:// -H 0.0.0.0:2375'} `
    | %{$_ -replace '^dockerd -H npipe://\s*$','dockerd -H npipe:// -H 0.0.0.0:2375'} `
    | Set-Content C:\ProgramData\docker\runDockerDaemon.cmd

  if (!(Get-NetFirewallRule | where {$_.Name -eq "Dockerinsecure2375"})) {
      New-NetFirewallRule -Name "Dockerinsecure2375" -DisplayName "Docker insecure on TCP/2375" -Protocol tcp -LocalPort 2375 -Action Allow -Enabled True
  }

  start-service docker
}

$TOKEN=(cat C:\vagrant\config\swarm-token)
$ip=( (Get-NetIPAddress | Where-Object -FilterScript { $_.InterfaceAlias -Eq "Ethernet 2" } | select-object IPAddress)[1].IPAddress)

Write-Host "Adding host $($ip):2375 to swarm"
docker run --restart=always -d stefanscherer/swarm-windows:1.2.1 join "--addr=$($ip):2375" "token://$TOKEN"
