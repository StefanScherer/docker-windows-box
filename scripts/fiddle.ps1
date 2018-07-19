iex (wget 'https://chocolatey.org/install.ps1' -UseBasicParsing)
choco install -y fiddler
setx /M HTTPS_PROXY https://localhost:8888
restart-service docker

Write-Host
Write-Host Next steps:
Write-Host 1. Open Fiddler $env:LOCALAPPDATA\Programs\Fiddler\Fiddler.exe
Write-Host 2. Open menu Tools -> Telerik Fiddler Options ...
Write-Host 3. Open HTTPS tab
Write-Host 4. Decrypt HTTPS traffic
Write-Host 5. Add root certificate as trusted cert
Write-Host 6. Run docker pull microsoft/nanoserver
