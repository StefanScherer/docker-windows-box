$ProgressPreference = 'SilentlyContinue';

$version="0.6.0"
Invoke-WebRequest -UseBasicParsing https://github.com/estesp/manifest-tool/releases/download/v$version/manifest-tool-windows-amd64.exe -OutFile $env:ProgramFiles\docker\manifest-tool.exe
