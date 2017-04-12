docker service create --name=askthem-default-dns --network=sample stefanscherer/askthem-windows:default-dns
docker service create --name=askthem-dnscache-disabled --network=sample stefanscherer/askthem-windows:dnscache-disabled
docker service create --name=askthem-ttl-5seconds --network=sample stefanscherer/askthem-windows:ttl-5seconds
