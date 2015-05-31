# docker-windows-box

This is a Vagrant box to test `docker-machine` on Windows.

**This is a work in progress as VirtualBox provisioning fails while `vagrant up` at the moment.**

Tested with VMware Fusion 6.

## Build the box

```bash
vagrant up --provider vmware_fusion
```

## Provision from inside the VM

Open a powershell terminal window.

If provisioning fails, just open a PowerShell window in the box and run

```
\vagrant\scripts\provision.ps1
```

from inside the VM and then you have `docker-machine.exe` and `docker.exe` installed.

## Translate envs

The `docker-machine env dev` output is unixish and you have to translate it

```
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH="C:\Users\vagrant\.docker\machine\machines\dev"
export DOCKER_HOST=tcp://192.168.99.100:2376
```

to powershell

```
$ENV:DOCKER_TLS_VERIFY=1
$ENV:DOCKER_CERT_PATH="C:\Users\vagrant\.docker\machine\machines\dev"
$ENV:DOCKER_HOST="tcp://192.168.99.100:2376"
```

or to cmd.exe

```
set DOCKER_TLS_VERIFY=1
set DOCKER_CERT_PATH="C:\Users\vagrant\.docker\machine\machines\dev"
set DOCKER_HOST=tcp://192.168.99.100:2376
```
