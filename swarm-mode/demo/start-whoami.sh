#!/bin/bash
command="docker service create --name=whoami -p 8000:8000 -e PORT=8000 stefanscherer/whoami:1.2.0"

# you can run this script from your Vagrant host or inside the Vagrant box
if [ "$(hostname)" != "sw-lin-01" ]; then
  vagrant ssh -c "$command" sw-lin-01
else
  $command
fi
