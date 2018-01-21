# LCOW

Linux Containers on Windows (LCOW) works on Windows 10 1709 and a Docker
engine that has the pull request [moby/moby#34859](https://github.com/moby/moby/pull/34859)
merged in.

At the moment we can use the nightly builds from [master.dockerproject.com](https://master.dockerproject.com).

To run Linux containers we also need a small Linux VM which is part of the Docker EE 17.10 Preview.

## Create the VM

```
vagrant up
```

## Run Windows containers

In the Windows 10 VM open a PowerShell terminal.

```
docker run microsoft/nanoserver:1709 cmd /c set
```

## Run Linux containers

At the moment you need to specify the `--platform` option to pull Linux images.

```
docker pull --platform linux alpine
```

Once you have pulled Linux images you can run them without the `--platform` option.

```
docker run alpine uname -a
```
