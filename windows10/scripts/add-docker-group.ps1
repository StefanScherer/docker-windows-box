net localgroup docker /add
net localgroup docker vagrant /add

@{group="docker"} | ConvertTo-Json | Out-File -Encoding ascii C:\ProgramData\docker\config\daemon.json

restart-service docker
# logoff and logon again
