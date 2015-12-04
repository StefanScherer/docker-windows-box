if (Test-Path C:\vagrant\resources\.ssh) {
  if (!(Test-Path "$env:USERPROFILE\.ssh")) {
    Write-Host "Inserting SSH config and keys into userprofile"
    mkdir $env:USERPROFILE\.ssh
    copy C:\vagrant\resources\.ssh\* $env:USERPROFILE\.ssh
  }
}

if (Test-Path C:\vagrant\resources\.gitconfig) {
  if (!(Test-Path "$env:USERPROFILE\.gitconfig")) {
    copy C:\vagrant\resources\.gitconfig $env:USERPROFILE\.gitconfig
  }
}
