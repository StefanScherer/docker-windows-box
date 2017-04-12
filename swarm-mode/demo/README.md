# Demo for Windows Server 2016 overlay network

On Windows 10 Creators Update or Windows Server 2016 with latest Windows Updates (10.0.14393.1066) you can use Docker Swarm with overlay network.

See blog post [Getting started with Docker Swarm-mode on Windows 10](https://stefanscherer.github.io/docker-swarm-mode-windows10/)

```powershell
./create-network.ps1
./start-whoami.ps1
./start-askthem.ps1
docker service logs askthem-default-dns
docker service logs askthem-dnscache-disabled
docker service logs askthem-ttl-5seconds
docker service scale whoami=3
docker service logs askthem-dnscache-disabled
```
