# install git tab completion (https://github.com/dahlbyk/posh-git)
#Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
#Install-Module posh-git -Scope CurrentUser
Push-Location Documents
git clone https://github.com/dahlbyk/posh-git
cd posh-git
. .\install.ps1
Pop-Location
