Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'
# putting it all together

$os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $env:COMPUTERNAME
#Turn into bytes - don't assume all values are in bytes
$InUse = ($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) * 1KB
#total bytes in use
$inUse

#define a hashtable of parameters to splat
#substitute your own computername


$cim = @{
    ClassName    = "win32_process"
    ComputerName = $env:computername
    filter       = "WorkingSetSize >=$(100MB)"
}


Get-CimInstance @cim | Select-Object -property ProcessID, Name,
@{Name = "WorkingMB"; Expression = { [math]::Round($_.WorkingSetSize / 1mb, 2) } },
@{Name = "PctMemory"; Expression = { "{0:p2}" -f ($_.WorkingsetSize / $InUse) } }


#I'm connecting to the local host several times to simulate
#multiple remote connections

$n = Get-Content c:\work\computers2.txt |
Where-Object { ($_.length -gt 0) -AND (Test-WSMan $_.trim()) }

$n

Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $n.trim() |
Select-Object -property @{Name = "Computername"; Expression = { $_.CSName } },
@{Name = "OS"; Expression = { ($_.Caption -Replace "Microsoft|Evaluation", $null).trim() } }, Version,
@{Name = "Uptime"; Expression = { New-TimeSpan -Start $_.LastBootUpTime -end (Get-Date) } },
@{Name = "Installed"; Expression = { "{0:MMMyyyy}" -f $_.InstallDate } },
@{Name = "InstallAge"; Expression = { (Get-Date) - $_.InstallDate } },
@{Name = "TotalMemGB"; Expression = { $_.TotalVisibleMemorySize / 1MB -as [int] } } |
Out-GridView

cls
