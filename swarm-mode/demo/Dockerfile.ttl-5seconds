FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxCacheEntryTtlLimit -Value 5 -Type DWord
COPY askthem.ps1 askthem.ps1
CMD ["powershell", "-file", "askthem.ps1"]
