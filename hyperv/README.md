# Hyper-V Server test

```
$ vagrant up
Bringing machine 'default' up with 'vmware_fusion' provider...
==> default: Cloning VMware VM: 'windows_2016_hyperv'. This can take some time...
==> default: Verifying vmnet devices are healthy...
==> default: Preparing network adapters...
==> default: Fixed port collision for 3389 => 3389. Now on port 2212.
==> default: Fixed port collision for 22 => 2222. Now on port 2213.
==> default: Fixed port collision for 5985 => 55985. Now on port 2214.
==> default: Fixed port collision for 5986 => 55986. Now on port 2215.
==> default: Starting the VMware VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: WinRM address: 172.16.63.129:5985
    default: WinRM username: vagrant
    default: WinRM execution_time_limit: PT2H
    default: WinRM transport: negotiate
==> default: Machine booted and ready!
==> default: Forwarding ports...
    default: -- 3389 => 2212
    default: -- 22 => 2213
    default: -- 5985 => 2214
    default: -- 5986 => 2215
==> default: Configuring network adapters within the VM...
==> default: Configuring secondary network adapters through VMware 
==> default: on Windows is not yet supported. You will need to manually
==> default: configure the network adapter.
==> default: Enabling and configuring shared folders...
    default: -- /Users/sample/code/docker-windows-box/hyperv: /vagrant
==> default: Running provisioner: shell...
    default: Running: scripts/install-docker.ps1 as c:\tmp\vagrant-shell.ps1
==> default:     Directory: C:\Program Files
==> default: Mode                LastWriteTime         Length Name          
==> default: ----                -------------         ------ ----          
==> default: d-----        6/10/2017   3:46 AM                docker        
==> default: Downloading Docker 17.06.0-ce-rc2
==> default: Ok.
==> default: Docker Service running listening on port 2375

$ docker -H 172.16.63.129 run microsoft/nanoserver ipconfig
Unable to find image 'microsoft/nanoserver:latest' locally
latest: Pulling from microsoft/nanoserver
bce2fbc256ea: Pull complete 
4a8c367fd46d: Pull complete 
Digest: sha256:86fa413540250b8de248da0a095f13fa119e00a212a855df98947d6948892b54
Status: Downloaded newer image for microsoft/nanoserver:latest

Windows IP Configuration


Ethernet adapter vEthernet (Container NIC 4915b7e1):

   Connection-specific DNS Suffix  . : localdomain
   Link-local IPv6 Address . . . . . : fe80::2939:dbf:c5b3:47bf%18
   IPv4 Address. . . . . . . . . . . : 172.29.7.126
   Subnet Mask . . . . . . . . . . . : 255.255.240.0
   Default Gateway . . . . . . . . . : 172.29.0.1
```

