start http://$(docker inspect -f '{{ .NetworkSettings.Networks.nat.IPAddress }}' visualizer):8080
