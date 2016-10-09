#!/bin/bash
curl https://get.docker.com | sh
sudo usermod -aG docker ubuntu

sudo service docker stop
sleep 2
sudo sed -i 's,^ExecStart=/usr/bin/dockerd.*$,ExecStart=/usr/bin/dockerd -H unix:// -H 0.0.0.0:2375,' /lib/systemd/system/docker.service
sleep 2
sudo systemctl daemon-reload
sleep 2
sudo service docker start

sleep 10
