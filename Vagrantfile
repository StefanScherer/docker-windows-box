# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vpn|
  #vpn.vm.box      = "kensykora/windows_81"
  vpn.vm.box      = "windows_7"
  vpn.vm.communicator = "winrm"

  vpn.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = 768
    vb.cpus = 1
    vb.customize ["modifyvm", :id, "--vram", "32"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
  end

  ["vmware_fusion", "vmware_workstation"].each do |provider|
    vpn.vm.provider provider do |v, override|
      v.gui = true
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      v.vmx["vhv.enable"] = "TRUE"
    end
  end

  # provisioning does not work as VirtualBox disconnects all network interfaces
  # open a powershell windows in the box and type c:\vagrant\scripts\provision.ps1
  # vpn.vm.provision "shell", path: "scripts/provision.ps1", privileged: false

end
