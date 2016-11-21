mkdir -p C:\registry-v2
docker run --restart=always -d -p 5000:5000 -v "C:\registry-v2:C:\data" sixeyed/registry:nanoserver
