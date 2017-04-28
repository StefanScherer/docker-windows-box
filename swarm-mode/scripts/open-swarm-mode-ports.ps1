# https://docs.docker.com/engine/swarm/swarm-tutorial/#/open-ports-between-the-hosts
& netsh advfirewall firewall add rule name="Docker swarm-mode cluster management TCP" dir=in action=allow protocol=TCP localport=2377
& netsh advfirewall firewall add rule name="Docker swarm-mode node communication TCP" dir=in action=allow protocol=TCP localport=7946
& netsh advfirewall firewall add rule name="Docker swarm-mode node communication UDP" dir=in action=allow protocol=UDP localport=7946
& netsh advfirewall firewall add rule name="Docker swarm-mode overlay network UDP" dir=in action=allow protocol=UDP localport=4789
