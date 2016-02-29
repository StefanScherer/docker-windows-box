# Windows Docker Swarm demo

This is a test setup using Vagrant with VirtualBox to demonstrate a Windows Docker Swarm with a private (insecure) registry.

## registry

A Linux box with Docker and two containers running:

1. The swarm manager using a token in `config/swarm-token`
2. A registry using the `registry-v2` folder on your host to store the Docker images

## sw-win-01 ...

The Windows Server 2016 TP4 machines that spin up a Swarm container to join the Docker Swarm.
The Docker Engine has connetion to the insecure registry running at `registry:5000`.

