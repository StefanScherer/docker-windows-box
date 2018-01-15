Install-Module DockerProvider -Force
Find-Package -ProviderName DockerProvider -AllVersions
Uninstall-Package Docker
# ignore error if CPU is not able to run Hyper-V, the preview package has a hard dependency
$ErrorActionPreference = 'SilentlyContinue'
Install-Package Docker -ProviderName DockerProvider -RequiredVersion 17.10.0-ee-preview-3 -Force
Start-Service docker
docker version
