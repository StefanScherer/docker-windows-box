$ErrorActionPreference = 'Stop'

if (1) { # }!(Get-VMSwitch -Name ext)) {
  Write-Host Create external virtual switch
  $ethernet = Get-NetAdapter -Name ethernet*
  New-VMSwitch -Name ext -NetAdapterName $ethernet.Name -AllowManagementOS $true
  Start-Sleep 15
}

Write-Host Create win-on-lin hyperv machine
docker-machine create -d hyperv `
  --hyperv-virtual-switch ext `
  --engine-label os=linux `
  --hyperv-boot2docker-url https://github.com/boot2docker/boot2docker/releases/download/v17.03.0-ce/boot2docker.iso `
  lin-on-win

Write-Host Initialize Linux swarm
$machine = "lin-on-win"
docker-machine env $machine | iex
docker swarm init

$ip=$(docker-machine ip $machine)
$token=$(docker swarm join-token manager -q)

Write-Host Open swarm ports
& netsh advfirewall firewall add rule name="Docker swarm-mode cluster management TCP" dir=in action=allow protocol=TCP localport=2377
& netsh advfirewall firewall add rule name="Docker swarm-mode node communication TCP" dir=in action=allow protocol=TCP localport=7946
& netsh advfirewall firewall add rule name="Docker swarm-mode node communication UDP" dir=in action=allow protocol=UDP localport=7946
& netsh advfirewall firewall add rule name="Docker swarm-mode overlay network TCP" dir=in action=allow protocol=TCP localport=4789
& netsh advfirewall firewall add rule name="Docker swarm-mode overlay network UDP" dir=in action=allow protocol=UDP localport=4789

Write-Host Join Windows to swarm
docker-machine env -unset | iex
docker swarm join --token $token ${ip}:2377

Write-Host List all nodes
docker node ls
