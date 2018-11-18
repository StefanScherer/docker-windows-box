# docker-machine test environment

Run a Windows 10 VM to test `docker-machine` and nested boot2docker Linux VM's and Linux containers.

## Create environment

Adjust the versions in the Vagrantfile for the Windows VM to be used, VMware Workstation, docker-machine and the docker CLI. Then run

```
vagrant up
```

## Test to create a Docker machine

Now inside the VM - either with `vagrant rdp` or just using the desktop of the visible VM.

First you have to enter a valid VMware Workstation license or start the 30 days trial.

Then open a PowerShell terminal ( `Win`+ `R` and enter `powershell` ).

Then run this command and specify the version of the boot2docker URL.

```
docker-machine -D create -d vmwareworkstation --vmwareworkstation-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.06.1-ce/boot2docker.iso test
```

During the creation you can see the boot2docker VM by opening the vmx file:

```
start C:\Users\vagrant\.docker\machine\machines\test\test.vmx
```

If that works try if the shared folder is mounted in the boot2docker VM:

```
docker-machine env test | iex
docker-machine ssh test ls /Users
```

If that also works try to run a container with a shared folder mounted:

```
docker-machine env test | iex
docker run --rm -v "/Users/vagrant:/code" alpine ls /code
```

If that also works you found a working combination.

To try another boot2docker version destroy the current docker machine:

```
docker-machine rm -f test
```

## Current status

This combination works fine

- docker-machine 0.13.0 with `vmwareworkstation` driver
- boot2docker 18.06.1

Windows has two third-party docker-machine drivers: [`vmwareworkstation`](https://github.com/pecigonzalo/docker-machine-vmwareworkstation) and [`vmware`](https://github.com/machine-drivers/docker-machine-driver-vmware).

| shared folder status | docker-machine version | driver used | boot2docker |
|--|--|--|--|
| ✅ | 0.13.0 | vmwareworkstation | 18.06.1 |
| ✅ | 0.16.0 | vmwareworkstation | 18.06.1 |
| ❌ | 0.13.0 | vmware | 18.06.1 |
| ❌ | 0.16.0 | vmware | 18.06.1 |

Here is a combination that does not work:

```
choco install -y docker-machine -version 0.16.0 -force
docker-machine -D create -d vmware --vmware-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.06.1-ce/boot2docker.iso test
docker-machine ssh test ls /Users
```

This is the same behaviour as with the `vmwarefusion` driver on macOS. The code base for the `vmware` driver is probably very similar.

## See also

- https://github.com/boot2docker/boot2docker/pull/1350
