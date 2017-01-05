#!/bin/bash
echo Spinning up Vagrant basebox
vagrant up --provider virtualbox
port=2985
echo Installing Windows Updates
winrm -port $port 'powershell -Command $sess = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession ; Invoke-CimMethod -InputObject $sess -MethodName ApplyApplicableUpdates ; Restart-Computer -Force'
sleep 30
echo Installing Docker
winrm -port $port "powershell -Command \$ProgressPreference = 'SilentlyContinue' ; \$version='1.13.0-rc5' ; Invoke-WebRequest -UseBasicParsing https://test.docker.com/builds/Windows/x86_64/docker-\$(\$version).zip -OutFile docker-\$(\$version).zip ; Expand-Archive docker-\$(\$version).zip -DestinationPath \$env:ProgramFiles ; \$dockerdir = ('{0}\\docker' -f \$env:ProgramFiles) ; \$env:PATH = \$dockerdir + ';' + \$env:PATH ; Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment\\' -Name Path -Value \$env:PATH ; Remove-Item -Path docker-\$(\$version).zip ; . dockerd.exe --register-service -H tcp://0.0.0.0:2375 -H npipe:// ; New-NetFirewallRule -DisplayName 'Docker Insecure Port 2375' -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 2375 ; Stop-Computer -Force"
sleep 5
echo Package nanoserver_docker box
vagrant package --output nanoserver_docker_virtualbox.box --vagrantfile vagrantfile-package
vagrant destroy -f
