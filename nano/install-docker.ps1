Install-PackageProvider -Name NuGet -Force
Install-Module -Name xNetworking -Force
$handler = New-Object System.Net.Http.HttpClientHandler
$client = New-Object System.Net.Http.HttpClient($handler)
$client.Timeout = New-Object System.TimeSpan(0, 30, 0)
$cancelTokenSource = [System.Threading.CancellationTokenSource]::new()
$responseMsg = $client.GetAsync([System.Uri]::new('https://download.docker.com/components/engine/windows-server/cs-1.12/docker.zip'), $cancelTokenSource.Token)
$responseMsg.Wait()
$downloadedFileStream = [System.IO.FileStream]::new('C:\docker.zip', [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
$response = $responseMsg.Result
$copyStreamOp = $response.Content.CopyToAsync($downloadedFileStream)
$copyStreamOp.Wait()
$downloadedFileStream.Close()
[System.IO.Compression.ZipFile]::ExtractToDirectory('C:\docker.zip',$env:ProgramFiles)
$env:PATH = "$env:ProgramFiles\docker;" + $env:PATH
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH
Remove-Item -Path c:\docker.zip
& dockerd --register-service -H tcp://0.0.0.0:2375 -H npipe://
& netsh advfirewall firewall add rule name="Docker Insecure Port 2375" dir=in action=allow protocol=TCP localport=2375
