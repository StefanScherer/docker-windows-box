$ErrorActionPreference = 'Stop'

Write-Host Create external virtual switch
$ethernet = Get-NetAdapter -Name ethernet*
New-VMSwitch -Name ext -NetAdapterName $ethernet.Name -AllowManagementOS $true

Write-Host Create win-on-lin hyperv machine
docker-machine create -d hyperv `
  --hyperv-virtual-switch ext `
  --engine-label linux `
  --hyperv-boot2docker-url https://github.com/boot2docker/boot2docker/releases/download/v1.13.0-rc4/boot2docker.iso `
  lin-on-win

Write-Host Initialize Linux swarm
$machine = "lin-on-win"
docker-machine env $machine | iex
docker swarm init

$ip=$(docker-machine ip $machine)
$token=$(docker swarm join-token manager -q)

Write-Host Join Windows to swarm
docker-machine env -unset | iex
docker swarm join --token $token ${ip}:2377

Write-Host List all nodes
docker node ls
