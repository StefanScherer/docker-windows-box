Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
Set-Location ZoneMap\Domains
New-Item contoso.local
Set-Location contoso.local
New-ItemProperty . -Name http -Value 1 -Type DWORD
