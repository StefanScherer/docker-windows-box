# Run Docker in Nanoserver

This is a work in progress using Matt Wrock's NanoServer Vagrant box from Atlas
and some half manual provisioning.

```
vagrant up --provider virtualbox
```

Then use the `winrm` Go binary to connect to the VM

```
winrm -port 55958 cmd
powershell
```

Then copy the commands of the `provision.ps1` script into the WinRM session.
