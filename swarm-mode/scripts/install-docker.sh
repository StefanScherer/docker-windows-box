#!/bin/bash
# curl https://get.docker.com | sh
curl https://test.docker.com | sh
sudo apt-get install -y --allow-downgrades docker-engine=17.05.0~ce~rc1-0~ubuntu-xenial
sudo usermod -aG docker vagrant
