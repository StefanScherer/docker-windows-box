# docker-windows-box

This is a Vagrant box to test `docker-machine` on Windows.
After provisioning the box has the following tools installed:

* Chocolatey
* git command line
* ssh client
* docker 1.8.1 client
* docker-machine 0.4.1 binary
* VirtualBox 5.0.2

Tested with VMware Fusion 7.1.2.

## Build the box

```bash
vagrant up --provider vmware_fusion
```

## Working with SSH and GitHub

The installed git package also has an SSH client. So you can use your SSH key
to clone GitHub repos. To avoid entering your passphrase again and again you
can start the ssh-agent.exe with the following commnands

```bash
start-ssh-agent.cmd
ssh-add %USERPROFILE%\.ssh\id_rsa
```

Now you can work with git as your are used on Mac and Linux ;-)

## Create a docker machine

VirtualBox is already installed in this VM, so we can just create a new Docker machine with

```
docker-machine create -d virtualbox dev
```

### Set the environment variables

Depending on the shell you are using, set the environment variables to your new Docker machine with

### powershell

```
docker-machine env --shell=powershell dev | Invoke-Expression
```

### cmd.exe shell

```
FOR /f "tokens=*" %i IN ('docker-machine env --shell=cmd dev') DO %i
```

## Run docker containers

Now you can access the Docker machine and run commands with the Windows docker client.

```
docker version
docker info
```

Or run a container...
