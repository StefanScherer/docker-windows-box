# from https://stefanscherer.github.io/protecting-a-windows-2016-docker-engine-with-tls/
$externalIp = "1.2.3.4" # eg. edge gateway IP / public IP address

if (!(Test-Path $env:USERPROFILE\.docker)) {
  mkdir $env:USERPROFILE\.docker
}

$ips = ((Get-NetIPAddress -AddressFamily IPv4).IPAddress) -Join ','
Write-Host "Creating certs for $ips,$externalIp"

docker run --rm `
  -e SERVER_NAME=$(hostname) `
  -e IP_ADDRESSES=$ips,$externalIp `
  -v "C:\ProgramData\docker:C:\ProgramData\docker" `
  -v "$env:USERPROFILE\.docker:C:\Users\ContainerAdministrator\.docker" `
  stefanscherer/dockertls-windows

# get rid of old -H options that would conflict with daemon.json
stop-service docker
dockerd --unregister-service
dockerd --register-service

# add group docker in daemon.json as it got lost with the unregister-service call
$daemonJson = "C:\ProgramData\docker\config\daemon.json"
$config = (Get-Content $daemonJson) -join "`n" | ConvertFrom-Json
$config = $config | Add-Member(@{ `
  group = "docker" `
  }) -Force -PassThru
Write-Host "`n=== Creating / Updating $daemonJson"
$config | ConvertTo-Json | Set-Content $daemonJson -Encoding Ascii

start-service docker

& netsh advfirewall firewall add rule name="Docker TLS" dir=in action=allow protocol=TCP localport=2376
