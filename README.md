# docker-windows-box

This is a Vagrant box to test Windows Docker Containers on a Windows Server 2016 TP4.

![](images/tp4.png)

After provisioning the box has the following tools installed:

* docker TP4 engine and client
* docker-machine 0.5.1
* docker-compose 1.5.1
* Chocolatey
* git command line
* ssh client

Optionally you can create a Hyper-V Docker Linux machine and have a multi architecture experience in one VM.

Tested with VMware Fusion 7.1.3 on a MacBookPro with Retina display. The Vagrant box will be started in fullscreen mode also with Retina support.

## Get the base box

If you don't have the Vagrant `windows_2016_docker` base box you need to create it first with [Packer](https://packer.io). See my [packer-windows](https://github.com/StefanScherer/packer-windows) repo to build the base box.

To build the base box you have to run these commands on your host machine:

```
git clone https://github.com/StefanScherer/packer-windows
cd packer-windows
packer build --only=vmware-iso windows_2016_docker.json
vagrant box add windows_2016_docker windows_2016_docker_vmware.box
```

## Spin up the box

To start the VM with [Vagrant](https://vagrantup.com) run this command

```bash
vagrant up --provider vmware_fusion
```

Now you can work with git as your are used on Mac and Linux ;-)

## Create some Windows Docker Container images

You may clone my [dockerfiles-windows](https://github.com/StefanScherer/dockerfiles-windows) repo and create some container images.

```
git clone https://github.com/StefanScherer/dockerfiles-windows
cd dockerfiles-windows
cd node
.\build.bat
```

## Test the nightly Windows Docker Engine

You can update the Docker Engine with the script

```
C:\vagrant\scripts\update-nightly-docker.ps1
```

This will stop the Docker service, download the nightly build from https://master.dockerproject.org and restart the service.

## Create a Linux Docker machine in Hyper-V

If you want to try out multi architecture you also use `docker-machine` to create a Linux Docker Engine running in Hyper-V.
I have prepared a script that will set up everything as there are some known issues.

```
C:\vagrant\scripts\create-hyperv-linux-docker-machine.ps1
```

This PowerShell script creates a Docker machine and updates Docker Engine to the latest so that the Windows Docker client is able to communicate with the Linux Docker Engine.

### Use the Linux Docker machine

Open a PowerShell terminal as an administrator and select the Linux Docker machine with

```
docker-machine env --shell powershell | iex
```

Now run your first busybox container with

```
docker run -it busybox uname -a
```

## Use Vagrant to control your box

From your host control your Vagrant box with the usual Vagrant workflow:

* vagrant up
* vagrant halt
* vagrant destroy -f
* vagrant snap take
* vagrant snap rollback
* ...

Writing the installation script for the Hyper-V Docker machine the snapshot functions helped me a lot to test the script again and again.
