#!/bin/bash
num=$1
command="docker service scale whoami=$num"

# you can run this script from your Vagrant host or inside the Vagrant box
if [ "$(hostname)" != "sw-lin-01" ]; then
  vagrant ssh -c "$command" sw-lin-01
else
  $command
fi
