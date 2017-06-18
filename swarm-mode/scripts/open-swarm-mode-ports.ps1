# https://docs.docker.com/engine/swarm/swarm-tutorial/#/open-ports-between-the-hosts
New-NetFirewallRule -Protocol TCP -LocalPort 2377 -Direction Inbound -Action Allow -DisplayName "Docker swarm-mode cluster management TCP"
New-NetFirewallRule -Protocol TCP -LocalPort 7946 -Direction Inbound -Action Allow -DisplayName "Docker swarm-mode node communication TCP"
New-NetFirewallRule -Protocol UDP -LocalPort 7946 -Direction Inbound -Action Allow -DisplayName "Docker swarm-mode node communication TCP"
New-NetFirewallRule -Protocol UDP -LocalPort 4789 -Direction Inbound -Action Allow -DisplayName "Docker swarm-mode overlay network UDP"
