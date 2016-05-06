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

if (Test-Path C:\vagrant\resources\.docker) {
  if (!(Test-Path "$env:USERPROFILE\.docker")) {
    Write-Host "Inserting docker config into userprofile"
    mkdir $env:USERPROFILE\.docker
    copy C:\vagrant\resources\.docker\* $env:USERPROFILE\.docker
  }
}
