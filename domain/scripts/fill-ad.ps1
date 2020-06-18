# http://technet.microsoft.com/de-de/library/dd378937%28v=ws.10%29.aspx
# http://blogs.technet.com/b/heyscriptingguy/archive/2013/10/29/powertip-create-an-organizational-unit-with-powershell.aspx

Import-Module ActiveDirectory

NEW-ADOrganizationalUnit -name "Locations"
NEW-ADOrganizationalUnit -name "HeadQuarter" -path "OU=Locations,DC=contoso,DC=local"
NEW-ADOrganizationalUnit -name "Users" -path "OU=HeadQuarter,OU=Locations,DC=contoso,DC=local"

Import-CSV -delimiter ";" c:\vagrant\config\users.csv | foreach {
  New-ADUser -SamAccountName $_.SamAccountName -GivenName $_.GivenName -Surname $_.Surname -Name $_.Name `
             -Path "OU=Users,OU=HeadQuarter,OU=Locations,DC=contoso,DC=local" `
             -AccountPassword (ConvertTo-SecureString -AsPlainText $_.Password -Force) -Enabled $true
  if ($_.Group -Ne "") {
    Add-ADGroupMember -Identity $_.Group -Members $_.SamAccountName
  }
  Add-ADGroupMember -Identity "Remote Desktop Users" -Members $_.SamAccountName
}
