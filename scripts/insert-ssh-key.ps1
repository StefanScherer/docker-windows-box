if (Test-Path C:\vagrant\resources\.ssh) {
  Write-Host "Inserting SSH config and keys into userprofile"
  mkdir $env:USERPROFILE\.ssh
  copy C:\vagrant\resources\.ssh\* $env:USERPROFILE\.ssh
}
