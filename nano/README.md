# Run Docker in Nanoserver

This is a work in progress using Matt Wrock's NanoServer Vagrant box from Atlas
and some half manual provisioning.

## Build the Vagrant box

```
cd build
./build.sh
vagrant box add nanoserver_docker nanoserver_docker_virtualbox.box
cd ..
```

## Run the Nano Server Docker VM

```
vagrant up --provider virtualbox
export DOCKER_HOST=tcp://127.0.0.1:2375
docker version
```
