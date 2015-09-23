# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box          = "windows_2016_docker"
  config.vm.communicator = "winrm"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = 1024
    vb.cpus = 1
    vb.customize ["modifyvm", :id, "--vram", "32"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
  end

  ["vmware_fusion", "vmware_workstation"].each do |provider|
    config.vm.provider provider do |v, override|
      v.gui = true
      v.vmx["memsize"] = "4096"
      v.vmx["numvcpus"] = "2"
      v.vmx["vhv.enable"] = "TRUE"
      v.vmx["hypervisor.cpuid.v0"] = "FALSE"
    end
  end

  config.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
#  config.vm.provision "reload"
#  config.vm.provision "shell", path: "scripts/setup-hyperv.ps1", privileged: false
end
