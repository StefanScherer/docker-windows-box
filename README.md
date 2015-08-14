# docker-windows-box

This is a Vagrant box to test `docker-machine` on Windows.
After provisioning the box has the following tools installed:

* Chocolatey
* git command line
* ssh client
* docker 1.8.1 client
* docker-machine 0.4.0 binary

Tested with VMware Fusion 7.

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
