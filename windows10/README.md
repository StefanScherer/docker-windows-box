# Docker on Windows 10

This `Vagrantfile` installs the nightly Docker Engine on Windows 10 1809 or newer
as described in https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10

You need a Vagrant box with Windows 10 1809.

```
vagrant up
```

## Run Windows containers with process isolation

With Pull request [38000](https://github.com/moby/moby/pull/38000) the process isolation is also allowed for Windows 10 1809 and newer. At the moment the nightly Docker Engine is needed until
it gets [backported to 18.09](https://github.com/docker/engine/pull/81).
 
```
docker run --isolation process mcr.microsoft.com/windows/nanoserver:1809 ipconfig
```

## Docker Swarm-Mode with Linux and Windows

Additionally you can create a Swarm Mode with the Windows 10 box and an Hyper-V Docker Linux VM. The nested Hyper-V VM will be created with docker-machine and
we combine both the Windows 10 host and the Hyper-V VM in Swarm Mode.

Open a PowerShell terminal in the Windows 10 VM and then run

```
C:\vagrant\windows10\scripts\create-swarm.ps1
```

To have a look at the swarm mode after provisioning, open a PowerShell terminal
in the Windows 10 VM. Then run

```
PS C:\> docker node ls
ID                           HOSTNAME    STATUS  AVAILABILITY  MANAGER STATUS
n87zn357pc9jtx62upualgzy7    lin-on-win  Ready   Active        Leader
nxt6vesay0ovuvfsc3y29p9v8 *  win10       Ready   Active        Reachable
```
