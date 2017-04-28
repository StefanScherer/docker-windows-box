#!/bin/bash
docker service create \
  --name=visualizer \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  sealsystems/visualizer
