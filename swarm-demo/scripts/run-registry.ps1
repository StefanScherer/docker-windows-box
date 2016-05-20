mkdir -p C:\registry-v2
docker run -d -p 5000:5000 -v "C:\registry-v2:C:\registry" stefanscherer/registry-windows:2.4.1
