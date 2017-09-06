Write-Host "Add Registry to hosts"
$ip = "192.168.36.2"
# I know this could be done with vagrant-hostmanager
Add-Content C:\Windows\system32\drivers\etc\hosts "`r`n$ip registry"

Write-Host "Stopping docker service"
Stop-Service docker

Write-Host "Adding insecure registry"
$daemonJson = "$env:ProgramData\docker\config\daemon.json"
$config = @{}
if (Test-Path $daemonJson) {
  $config = (Get-Content $daemonJson) -join "`n" | ConvertFrom-Json
}
$config = $config | Add-Member(@{ 'insecure-registries' = @( 'registry:5000' ) }) -Force -PassThru
$config | ConvertTo-Json | Set-Content $daemonJson -Encoding Ascii

Write-Host "Starting docker service"
Start-Service docker
