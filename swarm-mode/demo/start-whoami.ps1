docker service create --name=whoami --endpoint-mode dnsrr `
  --network=sample stefanscherer/whoami-windows:latest
