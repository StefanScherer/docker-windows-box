# from https://medium.com/lucjuggery/docker-daemon-metrics-in-prometheus-7c359c7ff550
# ported to Windows

Write-Host "Stopping docker service"
Stop-Service docker

Write-Host "Enable metrics and experimental features"
$daemonJson = "$env:ProgramData\docker\config\daemon.json"
$config = @{}
if (Test-Path $daemonJson) {
  $config = (Get-Content $daemonJson) -join "`n" | ConvertFrom-Json
}
$config = $config | Add-Member(@{ `
  experimental = $true; `
  'metrics-addr' = '0.0.0.0:9999'; `
  debug = $true; `
   }) -Force -PassThru
$config | ConvertTo-Json | Set-Content $daemonJson -Encoding Ascii

Write-Host "Starting docker service"
Start-Service docker

& netsh advfirewall firewall add rule name="Docker Metrics" dir=in action=allow protocol=TCP localport=9999

$ip=(Get-NetIPAddress -AddressFamily IPv4 `
   | Where-Object -FilterScript { $_.InterfaceAlias -Eq "vEthernet (HNS Internal NIC)" } `
   ).IPAddress

mkdir C:\prom\data

Get-Content prom.yml | % { $_ -Replace "\[DOCKER_HOST\]", $ip} | Set-Content C:\prom\prom.yml -Encoding Ascii

docker container run -d -p 9090:9090 `
  -v "C:\prom\data:C:\prometheus" -v "C:\prom:C:\config" `
  stefanscherer/prometheus-windows '-config.file=/config/prom.yml' `
  '-storage.local.path=/prometheus' `
  '-web.console.libraries=/etc/prometheus/console_libraries' `
  '-web.console.templates=/etc/prometheus/consoles'
