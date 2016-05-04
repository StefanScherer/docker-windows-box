#!/bin/bash
mkdir -p /vagrant/registry-v2
docker run -d -p 5000:5000 -v "/vagrant/registry-v2:/var/lib/registry" registry:2.3.0
