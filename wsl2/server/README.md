# Windows Server, version 2004 and Docker

## Windows Containers

You can run Windows Containers using Docker EE.

Use the cmd terminal with

```shell
docker version
docker run --isolation hyperv hello-world:nanoserver
```

## Linux Containers

You can run Linux Containers using Docker CE in WSL 2.

Use the cmd terminal and run

```shell
wsl -d Ubuntu-20.04 docker version
wsl -d Ubuntu-20.04 docker run hello-world
```


## How to build the Vagrant box

You need a Vagrant base box `windows_server_2004` before using the `Vagrantfile`. You need VMware Fusion / Workstation to have nested virtualization.

```shell
git clone https://github.com/StefanScherer/packer-windows
cd packer-windows
packer build \
  --only vmware \
  --var iso_url=~/packer_cache/msdn/en_windows_server_version_2004_x64_dvd_765aeb22.iso  \
  windows_server_2004.json
vagrant box add windows_server_2004 windows_server_2004_vmware.box
```

## Vagrant up

After you have created the Vagrant base box you can boot and provision the VM

```shell
vagrant plugin install vagrant-reload
vagrant up
```

Then use the cmd terminal in the VM to play with Docker 🐳
