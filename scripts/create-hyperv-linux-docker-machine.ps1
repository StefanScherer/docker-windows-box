# create a virtual switch
New-VMSwitch -NetAdapterInterfaceDescription "vmxnet3 Ethernet Adapter" -Name "docker"

# create a Hyper-V Linux docker machine
docker-machine -D create -d hyperv --hyperv-virtual-switch "docker" dev

# known issues
# https://github.com/docker/machine/issues/2267
# https://github.com/docker/machine/issues/2362
# workaround: https://github.com/docker/machine/issues/2267#issuecomment-156426874
docker-machine start dev
docker-machine regenerate-certs -f dev

# windows docker client has different API version
# workaround: update the docker engine in the Hyper-V Linux docker machine
docker-machine ssh dev sudo /etc/init.d/docker stop
docker-machine ssh dev sudo curl -o /usr/local/bin/docker https://master.dockerproject.org/linux/amd64/docker
docker-machine ssh dev sudo /etc/init.d/docker start
