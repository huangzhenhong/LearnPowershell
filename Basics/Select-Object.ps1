Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#custom objects and properties
#be sure to look at help examples for Select-Object

# Get-ChildItem -path C:\data -file -recurse |
# Select-Object -property FullName,Name,LastWriteTime,
# @{Name = "Size";Expression = {$_.Length}},
# @{Name = "Computername";Expression = {$env:computername}},
# @{Name = "Audit";Expression = {(Get-Date -format g)}} |
# Export-CSV c:\work\data.csv

#using Select-Object
Get-TimeZone
#add a custom property
Get-TimeZone | Select-Object *, @{Name = 'Computername'; Expression = { $env:computername } }

Get-Process | Where-Object { $_.ws -ge 250MB } |
Select-Object ID, Name,
@{Name = 'MemoryMB'; Expression = { ($_.ws / 1mb) -as [int32] } },
@{Name = 'Threads'; Expression = { $_.threads.count } },
@{Name = 'Runtime'; Expression = { (Get-Date) - ($_.StartTime) } } |
Format-Table

#another example

Get-Process -IncludeUserName |
Group-Object -Property Username |
Select-Object -Property Name, Count,
@{Name = 'TotalMemoryMB'; Expression = {
$measure = $_.group | Measure-Object -Property WS -Sum
[math]::Round($measure.sum / 1MB, 2)
 }
}


cls

