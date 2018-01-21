[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
