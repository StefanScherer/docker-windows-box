# install git tab completion (https://github.com/dahlbyk/posh-git)
#Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
#Install-Module posh-git -Scope CurrentUser

cd Documents
git clone https://github.com/dahlbyk/posh-git
cd posh-git
. .\install.ps1

# patch profile to make it work from winrm session, see PR https://github.com/dahlbyk/posh-git/pull/238
(Get-Content profile.example.ps1) |
Foreach-Object {$_ -replace '^Start-SshAgent -Quiet','If ((Test-Path env:\SESSIONNAME) -And ($env:SESSIONNAME -eq "Console")) {
  Start-SshAgent -Quiet
}'}  |
Out-File profile.example.ps1
