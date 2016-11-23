param ([String] $ip)

docker swarm init --listen-addr ${ip}:2377 --advertise-addr ${ip}:2377

# use Vagrant shared folder to transfer token to other managers and workers
if (!(Test-Path C:\vagrant\resources)) {
  mkdir C:\vagrant\resources
}
docker swarm join-token manager -q | Out-File -Encoding Ascii C:\vagrant\resources\manager-token
docker swarm join-token worker -q | Out-File -Encoding Ascii C:\vagrant\resources\worker-token
