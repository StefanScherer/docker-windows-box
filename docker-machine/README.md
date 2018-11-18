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
docker-machine create -d vmwareworkstation --vmwareworkstation-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.06.1-ce/boot2docker.iso
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

## Current status

This combination works fine

- docker-machine 0.13.0
- boot2docker 18.06.1

## See also

- https://github.com/boot2docker/boot2docker/pull/1350
