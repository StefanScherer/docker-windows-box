# docker-windows-box

This is a Vagrant box to test `docker-machine` on Windows.

**This is a work in progress as VirtualBox provisioning fails while `vagrant up` at the moment.**

Tested with VMware Fusion 6.

```bash
vagrant up --provider vmware_fusion
```

If provisioning fails, just open a PowerShell window in the box and run

```
\vagrant\scripts\provision.ps1
```

from inside the VM and then you have `docker-machine.exe` and `docker.exe` installed.

At the moment the `docker.exe` has protocol version 1.19 and the boot2docker still has 1.17. So you
have to patch the `docker.exe`

```
sed -ibak -b docker.exe -e 's/1\.19/1.17/g'
```

But searching for `sed` in chocolatey is not so easy. Many deprecated packages out there. I've installed cygwin and patched it in a cygwin shell.

## See also

* https://github.com/docker/machine/issues/732
* https://github.com/docker/docker/issues/11486

