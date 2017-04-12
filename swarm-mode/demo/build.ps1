docker build -t stefanscherer/askthem-windows:default-dns -f Dockerfile.default-dns .
docker build -t stefanscherer/askthem-windows:dnscache-disabled -f Dockerfile.dnscache-disabled .
docker build -t stefanscherer/askthem-windows:ttl-5seconds -f Dockerfile.ttl-5seconds .
