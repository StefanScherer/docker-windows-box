Get-WindowsOptionalFeature -Online -FeatureName *hyper-v*all | Enable-WindowsOptionalFeature
 -Online
# Reboot

Get-NetAdapter
New-VMSwitch -NetAdapterInterfaceDescription "vmxnet3 Ethernet Adapter" -Name "Ethernet 2"

# PS C:\Windows\system32> new-vmswitch -AllowManagementOS 1 -NetAdapterInterfaceDescription "vmxnet3 Ethernet Adapter" -Name "docker"
