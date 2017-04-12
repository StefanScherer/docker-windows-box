while ($true) {
  (Invoke-WebRequest -UseBasicParsing http://whoami:8000).Content
  Start-Sleep 1
}
