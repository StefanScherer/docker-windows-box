# docker-windows-box

This is a Vagrant box to test `docker-machine` on Windows.

This is a work in progress as VirtualBox provisioning fails while `vagrant up` at the moment.

Tested with VMware Fusion 6.

## Build the box

```bash
vagrant up --provider vmware_fusion
```

## Provision from inside the VM

Open a powershell terminal window.

```
\vagrant\scripts\provision.ps1
```

