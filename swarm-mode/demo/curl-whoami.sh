#!/bin/bash
command="curl http://192.168.36.2:8000"
command="curl http://10.100.50.4:2237"
echo "Running $command"
while [ true ]; do
  $command
  sleep 0.5
done
