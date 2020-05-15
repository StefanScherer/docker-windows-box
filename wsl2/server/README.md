# Windows Server, version 2004 and Docker

## Windows Containers

You can run Windows Containers using Docker EE.

Use the cmd terminal with

```shell
docker version
docker run --isolation hyperv hello-world:nanoserver
```

## Linux Containers

You can run Linux Containers using WSL 2.

Use the cmd terminal and run

```shell
wsl -d Ubuntu-20.04 docker version
wsl -d Ubuntu-20.04 docker run hello-world
```
