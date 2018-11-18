# docker-machine test environment

Run a macOS VM to test `docker-machine` and nested boot2docker Linux VM's and Linux containers.

## Create environment

Adjust the versions in the Vagrantfile for the macOS VM to be used, VMware Fusion, docker-machine and the docker CLI. Then run

```
vagrant up
```

## Test to create a Docker machine

Now inside the VM - either with `vagrant rdp` or just using the desktop of the visible VM.

First you have to enter a valid VMware Fusion license or start the 30 days trial.
To install and/or use vmware-fusion you may need to enable their kernel extension in

  System Preferences → Security & Privacy → General

Then open a Terminal.

Then run this command and specify the version of the boot2docker URL. There are several versions of docker-machine downloaded (0.13.0 to 0.16.0).

```
docker-machine-0.13.0 -D create -d vmwarefusion --vmwarefusion-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.06.1-ce/boot2docker.iso test
```

During the creation you can see the boot2docker VM by opening the vmx file:

```
open ~/.docker/machine/machines/test/test.vmx
```

If that works try if the shared folder is mounted in the boot2docker VM:

```
docker-machine ssh test ls /Users
```

If that also works try to run a container with a shared folder mounted:

```
eval $(docker-machine env test)
docker run --rm -v /Users:/Users alpine ls /Users
```

If that also works you found a working combination.

To try another boot2docker version destroy the current docker machine:

```
docker-machine rm -f test
```

## Current status

This combination works fine

- docker-machine 0.13.0 with `vmwarefusion` driver
- boot2docker 18.06.1

Any newer docker-machine binary does not work and aborts at vmrun enableSharedFolders.

## See also

- https://github.com/boot2docker/boot2docker/pull/1350
