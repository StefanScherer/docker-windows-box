# notify-env-changes.ps1 can be used as last provision script in a Vagrantfile
# for Vagrant Windows boxes that have autologin enabled. The already logged
# on session does not receive environment changes of the provision scripts.
# This script runs an interactive scheduled task to send this notification
# in the logged on user session. Opening a new CMD shell or PowerShell then
# have all your provisioned tools in PATH.

# create a Task Scheduler task which is also able to run in battery mode due
# to host notebooks working in battery mode. This complicates the whole script
# from a one liner to a fat XML - good heaven.

$xml = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2014-03-27T13:53:05</Date>
    <Author>vagrant</Author>
  </RegistrationInfo>
  <Triggers>
    <TimeTrigger>
      <StartBoundary>2014-03-27T00:00:00</StartBoundary>
      <Enabled>true</Enabled>
    </TimeTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>vagrant</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>LeastPrivilege</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>P3D</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>setx.exe</Command>
      <Arguments>trigger 1</Arguments>
    </Exec>
  </Actions>
</Task>
"@

$XmlFile = $env:Temp + "\notify-env.xml"
Write-Host "Write Task to $XmlFile"
$xml | Out-File $XmlFile

& schtasks /Delete /F /TN NotifyEnvironmentChanges
& schtasks /Create /TN NotifyEnvironmentChanges /XML $XmlFile
& schtasks /Run /TN NotifyEnvironmentChanges
