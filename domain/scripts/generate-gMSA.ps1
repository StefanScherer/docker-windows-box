# https://github.com/Microsoft/Virtualization-Documentation/pull/592
# https://github.com/Microsoft/Virtualization-Documentation/tree/804008c172b80a4f354a92cd4d12a4e23e1d4328/windows-server-container-tools/ServiceAccounts
Add-WindowsFeature RSAT-AD-PowerShell,RSAT-AD-AdminCenter
Add-KDSRootKey -EffectiveTime ((get-date).addhours(-11))
Get-KdsRootKey
New-ADServiceAccount -name WebApplication1 -DnsHostName Host1.contoso.local  -ServicePrincipalNames http/Host1.contoso.local -PrincipalsAllowedToRetrieveManagedPassword Host1$
Install-AdServiceAccount WebApplication1
Test-AdServiceAccount WebApplication1

Invoke-WebRequest -OutFile CredentialSpec.psm1 -Uri https://raw.githubusercontent.com/Microsoft/Virtualization-Documentation/live/windows-server-container-tools/ServiceAccounts/CredentialSpec.psm1 -UseBasicParsing
Import-Module ActiveDirectory
Import-Module ./CredentialSpec.psm1
New-CredentialSpec -Name WebApplication1 -AccountName WebApplication1
Get-CredentialSpec

docker run --security-opt "credentialspec=file://WebApplication1.json" microsoft/windowsservercore nltest.exe /parentdomain


# get-adserviceaccount -filter {Name -like 'WebApplication1'} | remove-serviceaccount
