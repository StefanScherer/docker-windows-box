$logStartTime = (Get-Date).AddHours(-24)

$logNames = "Microsoft-Windows-Containers-Wcifs/Operational",
            "Microsoft-Windows-Containers-Wcnfs/Operational",
            "Microsoft-Windows-Hyper-V-Compute-Admin", 
            "Microsoft-Windows-Hyper-V-Compute-Operational",
            "Application"
$levels = 4,3,2,1,0
$providers = "Docker", "Microsoft-Windows-Hyper-V-Compute"

$events = Get-WinEvent -FilterHashtable @{Logname=$logNames; StartTime=$logStartTime; Level=$levels; ProviderName=$providers} -ErrorAction Ignore

$eventCsv = "logs_$((get-date).ToString("yyyyMMdd'-'HHmmss")).csv"
($events | Where-Object -FilterScript { $_.Message -Like "*::CreateProcess*" }).Message
