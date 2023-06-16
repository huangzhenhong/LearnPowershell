#requires -version 5.1

#This script is for demonstration purposes only. It is not production-ready.

Param([string[]]$Computername = $env:Computername)

Get-CimInstance Win32_OperatingSystem -ComputerName $Computername |
Select-Object @{Name="Computername";Expression = {$_.PSComputername.ToUpper()}},
 @{Name="OperatingSystem";Expression={$_.Caption}},
@{Name="TotalMemoryGB";Expression = {($_.TotalVisibleMemorySize/1mb) -as [int]}},
@{Name= "FreeMemoryGB";Expression = {[math]::round($_.FreePhysicalMemory/1mb,2)}}
