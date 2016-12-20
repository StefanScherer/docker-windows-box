param(
  [string]$name
)

if (! $name) {
  $name = "dev"
}

# ensure that we are running as administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {#
  Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Name $name" -Verb RunAs; exit
}

# create a virtual switch
if (((Get-VMSwitch).name | grep docker) -ne "docker") {
  $description=(Get-NetAdapter).InterfaceDescription | grep -v Hyper-V
  New-VMSwitch -NetAdapterInterfaceDescription $description -Name "docker"

  Write-Host "Waiting for internet connectivity"
  Sleep 15
}

# create a Hyper-V Linux docker machine
docker-machine create -d hyperv --hyperv-virtual-switch "docker" $name

# known issues
# https://github.com/docker/machine/issues/2267
# https://github.com/docker/machine/issues/2362
# workaround: https://github.com/docker/machine/issues/2267#issuecomment-156426874
docker-machine start $name
docker-machine regenerate-certs -f $name
