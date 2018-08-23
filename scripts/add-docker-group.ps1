Write-Host "Creating group docker"
net localgroup docker /add
Write-Host "Adding user vagrant to group docker"
net localgroup docker $env:COMPUTERNAME\vagrant /add

Write-Host "Stopping docker service"
Stop-Service docker

Write-Host "Adding group to daemon.json"
$daemonJson = "$env:ProgramData\docker\config\daemon.json"
$config = @{}
if (Test-Path $daemonJson) {
  $config = (Get-Content $daemonJson) -join "`n" | ConvertFrom-Json
}
$config = $config | Add-Member(@{ 'group' = 'docker' }) -Force -PassThru
$config | ConvertTo-Json | Set-Content $daemonJson -Encoding Ascii

Write-Host "Starting docker service"
Start-Service docker
