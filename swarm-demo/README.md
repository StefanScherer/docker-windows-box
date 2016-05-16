# Windows Docker Swarm demo

This is a local setup using Vagrant with VirtualBox to demonstrate a Windows Docker Swarm with a private (insecure) registry. This work was done for the blog post [Run a local Windows Docker Swarm](https://stefanscherer.github.io/build-your-local-windows-docker-swarm/). In the meantime the setup is updated to run the registry and swarm master on Windows as well.

![Windows Docker Swarm demo](images/windows_swarm_demo.png)

## Vagrant boxes

There are four VM's with the following internal network and IP addresses:

| VM        | IP address     | Memory |
|-----------|----------------|--------|
| registry  | 192.168.38.100 | 2GB    |
| sw-win-01 | 192.168.38.101 | 2GB    |
| sw-win-02 | 192.168.38.102 | 2GB    |
| sw-win-03 | 192.168.38.103 | 2GB    |

Depending on your host's memory you can spin up one or more Windows Server VM's.

### registry

A Windows Server 2016 TP5 machine with Docker and two containers running:

1. The [swarm](https://github.com/StefanScherer/dockerfiles-windows/tree/master/swarm) manager using a token in `config/swarm-token`
2. A [registry](https://github.com/StefanScherer/dockerfiles-windows/tree/master/registry) using the `registry-v2` folder on your host (TBD) to store the Docker images

### sw-win-01 ...

The Windows Server 2016 TP5 machines that spin up a Swarm container to join the Docker Swarm.
The Docker Engine has connection to the insecure registry running at `registry:5000`.

## Create the boxes

You need Vagrant, VirtualBox and the [windows_2016_docker](https://github.com/StefanScherer/packer-windows) Vagrant box on your host.
This demo is tested on OSX with VirtualBox 5.0.20.

First create a new swarm token and overwrite the file `config/swarm-token`.
Then just run

```
vagrant up --provider virtualbox
```

and all the four VM's will be created.

## Registry storage

The storage of the private Docker Registry will be in the `registry-v2/docker` directory. On each Windows machine the Docker image `stefanscherer/swarm-windows:1.2.2` will be pulled.

It is save to destroy all the VM's as your Docker images are stored on your host.
Just recreate the registry and one of the Windows Servers and you can pull your own images again.

## Use the Windows Docker swarm

Connect from your host to the Swarm manager which runs in the `registry` VM with the IP address `192.168.38.100`.

```
$ unset DOCKER_TLS_VERIFY DOCKER_CERT_PATH
$ docker -H tcp://192.168.38.100:3375 info
Containers: 3
 Running: 3
 Paused: 0
 Stopped: 0
Images: 9
Server Version: swarm/1.2.2
Role: primary
Strategy: spread
Filters: health, port, containerslots, dependency, affinity, constraint
Nodes: 3
 sw-win-01: 192.168.38.101:2375
  └ ID: 7GSP:7HJ7:XT6L:SCLE:657O:SUZ4:JOES:AIJN:FNRY:WF6A:54U7:RRSN
  └ Status: Healthy
  └ Containers: 1
  └ Reserved CPUs: 0 / 2
  └ Reserved Memory: 0 B / 2.1 GiB
  └ Labels: executiondriver=, kernelversion=10.0 14300 (14300.1016.amd64fre.rs1_release_svc.160428-1819), operatingsystem=Windows Server 2016 Datacenter Technical Preview 5, storagedriver=windowsfilter
  └ Error: (none)
  └ UpdatedAt: 2016-05-16T11:47:46Z
  └ ServerVersion: 1.12.0-dev
 sw-win-02: 192.168.38.102:2375
  └ ID: ZKUV:D7MI:E2NR:UREE:NWEY:6GAV:MUMP:5AMZ:3Z35:ZVDP:USK2:M5CL
  └ Status: Healthy
  └ Containers: 1
  └ Reserved CPUs: 0 / 2
  └ Reserved Memory: 0 B / 2.1 GiB
  └ Labels: executiondriver=, kernelversion=10.0 14300 (14300.1016.amd64fre.rs1_release_svc.160428-1819), operatingsystem=Windows Server 2016 Datacenter Technical Preview 5, storagedriver=windowsfilter
  └ Error: (none)
  └ UpdatedAt: 2016-05-16T11:47:41Z
  └ ServerVersion: 1.12.0-dev
 sw-win-03: 192.168.38.103:2375
  └ ID: U4KK:MKSD:66RL:JXKC:URPS:T2L2:ER4Q:GGHG:NIV4:6MBA:B3E5:TMSX
  └ Status: Healthy
  └ Containers: 1
  └ Reserved CPUs: 0 / 2
  └ Reserved Memory: 0 B / 2.1 GiB
  └ Labels: executiondriver=, kernelversion=10.0 14300 (14300.1016.amd64fre.rs1_release_svc.160428-1819), operatingsystem=Windows Server 2016 Datacenter Technical Preview 5, storagedriver=windowsfilter
  └ Error: (none)
  └ UpdatedAt: 2016-05-16T11:48:14Z
  └ ServerVersion: 1.12.0-dev
Plugins:
 Volume:
 Network:
Kernel Version: 6.2 9200 (14300.1000.amd64fre.rs1_release_svc.160324-1723)
Operating System: windows
Architecture: amd64
CPUs: 6
Total Memory: 6.299 GiB
Name: WIN-DE6U4068NAF
Docker Root Dir:
Debug mode (client): false
Debug mode (server): false
WARNING: No kernel memory limit support
```
