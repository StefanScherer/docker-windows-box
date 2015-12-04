# The servers that we want to use
$newDNSServers = "8.8.8.8", "4.4.4.4"

# Get all network adapters that already have DNS servers set
$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DNSServerSearchOrder -ne $null}

# Set the DNS server search order for all of the previously-found adapters
$adapters | ForEach-Object {$_.SetDNSServerSearchOrder($newDNSServers)}
