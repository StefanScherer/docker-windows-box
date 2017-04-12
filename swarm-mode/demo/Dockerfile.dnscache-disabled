FROM microsoft/nanoserver
RUN sc.exe config dnscache start= disabled
COPY askthem.ps1 askthem.ps1
CMD ["powershell", "-file", "askthem.ps1"]
