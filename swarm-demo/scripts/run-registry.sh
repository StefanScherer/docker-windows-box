#!/bin/bash
mkdir -p resources
mkdir -p resources/registry-v2
docker run -d -p 5000:5000 --restart=always -v "$(pwd)/resources/registry-v2:/var/lib/registry" registry:2.3.0
