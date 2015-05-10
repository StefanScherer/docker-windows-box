# docker-windows-box

This is a Vagrant box to test `docker-machine` on Windows.

**This is a work in progress as VirtualBox provisioning fails while `vagrant up` at the moment.**

Tested with VMware Fusion 6.

## Build the box

```bash
vagrant up --provider vmware_fusion
```

## Provision from inside the VM

Open a powershell terminal window.

If provisioning fails, just open a PowerShell window in the box and run

```
\vagrant\scripts\provision.ps1
```

from inside the VM and then you have `docker-machine.exe` and `docker.exe` installed.
