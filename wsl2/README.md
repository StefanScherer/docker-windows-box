# WSL 2

Test WSL 2 on a Windows 10 Home Insider Preview box.

```
vagrant up
```

In the box open an admin terminal and run `Ubuntu1804.exe` to start first WSL.

At the moment you cannot install Docker Desktop on Windows 10 Home, so you 
might want to try at least

```
curl https://get.docker.com | sh
sudo usermod -aG docker $USER
```

Then in a new bash run

```
sudo service docker start
docker version
```
