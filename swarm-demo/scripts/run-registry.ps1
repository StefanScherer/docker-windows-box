mkdir -p C:\registry-v2
# volume mount point does not work right now, see https://github.com/docker/distribution/issues/1732
# docker run -d -p 5000:5000 -v "C:\registry-v2:C:\registry" stefanscherer/registry-windows:2.5.1
docker run -d -p 5000:5000 stefanscherer/registry-windows:2.5.1
