param ([String] $dns)

if ((gwmi win32_computersystem).partofdomain -eq $true) {
  Write-Host "Already domain joined"
} else {
  $subnet = $dns -replace "\.\d+$", ""

  $name = (Get-NetIPAddress -AddressFamily IPv4 `
     | Where-Object -FilterScript { ($_.IPAddress).StartsWith($subnet) } `
     ).InterfaceAlias

  if (!$name) {
    $name = (Get-NetIPAddress -AddressFamily IPv4 `
       | Where-Object -FilterScript { ($_.IPAddress).StartsWith("169.254.") } `
       ).InterfaceAlias
  }

  if ($name) {
    Write-Host "Set DNS server address to $dns of interface $name"
    & netsh.exe interface ipv4 add dnsserver "$name" address=$dns index=1
  } else {
    Write-Error "Could not find a interface with subnet $subnet.xx"
  }

  Write-Host "Join the domain"
  $domain = "contoso.local"

  $user = "$domain\vagrant"
  $pass = ConvertTo-SecureString "vagrant" -AsPlainText -Force
  $DomainCred = New-Object System.Management.Automation.PSCredential $user, $pass
  Add-Computer -DomainName $domain -credential $DomainCred -PassThru

  Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultDomainName -Value "CONTOSO"
}
