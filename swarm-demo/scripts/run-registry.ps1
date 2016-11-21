if (!(Test-Path C:\vagrant\registry-v2)) {
  mkdir -p C:\vagrant\registry-v2
}
docker run --restart=always -d -p 5000:5000 -v "C:\vagrant\registry-v2:C:\data" sixeyed/registry:nanoserver
