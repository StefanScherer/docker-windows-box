Write-Host "Add Registry to hosts"
$ip = "192.168.36.2"
# I know this could be done with vagrant-hostmanager
Add-Content C:\Windows\system32\drivers\etc\hosts "`r`n$ip registry"

Write-Host "Add Docker Registry"
$path = (Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Services\docker -Name ImagePath).ImagePath
$path += ' --insecure-registry registry:5000'
Set-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Services\docker -Name ImagePath -Value $path -Force

Write-Host "Restarting docker"
Restart-Service docker
