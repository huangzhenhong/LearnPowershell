Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#creating custom objects with hash tables

#Custom objects
#This is a variation of the code I had in the slides.
#look at help for new-object
$ps = Get-CimInstance win32_process
$os = Get-CimInstance win32_OperatingSystem
#note that the property name is different than the one in Get-Service
$svc = Get-CimInstance win32_service -Filter "state = 'running'"

$hash = @{
    Computername = $env:computername
    Version      = $PSVersionTable.PSVersion
    ProcessCount = $ps.count
    ServiceCount = $svc.count
    Uptime       = New-TimeSpan -Start $os.LastBootUpTime -End (Get-Date)
}

$hash
#what is $hash?
$hash | Get-Member

New-Object -TypeName PSObject -Property $hash | Tee-Object -Variable new

$new | Get-Member

cls

#using [PSCustomObject]
#notice properties weren't displayed in the order they were defined.

$obj = [PSCustomObject]@{
    Computername = $env:computername
    Version      = $PSVersionTable.PSVersion
    ProcessCount = $ps.count
    ServiceCount = $svc.count
    TimeZone     = (Get-TimeZone).DisplayName
    Uptime       = New-TimeSpan -Start $os.LastBootUpTime -End (Get-Date)
}

#property order is maintained
$obj

cls

#let's revisit an earlier example
#these techniques used more often in scripting
$procs = Get-Process | Where-Object { $_.ws -ge 200MB }

foreach ($p in $procs) {
    [PSCustomObject]@{
        ID           = $p.Id
        Name         = $p.Name
        MemoryMB     = ($p.ws / 1mb) -as [int32]
        Threads      = $p.threads.count
        Runtime      = (Get-Date) - ($p.StartTime)
        Computername = $env:computername
    }
}


cls

#region Bonus demos

#alternatives

#using forEach-Object
Get-Process | Where-Object { $_.ws -ge 200MB } |
ForEach-Object {
    [PSCustomObject]@{
        ID           = $_.Id
        Name         = $_.Name
        MemoryMB     = ($_.ws / 1mb) -as [int32]
        Threads      = $_.threads.count
        Runtime      = (Get-Date) - ($_.StartTime)
        Computername = $env:computername
    }
}

#Using Select-Object
Get-Process | Where-Object { $_.ws -ge 200MB } |
Select-Object -property ID,Name,
@{Name = "MemoryMB";Expression = {($_.ws / 1mb) -as [int32] }},
@{Name = "Threads";Expression= {$_.threads.count}},
@{Name = "Runtime";Expression = {(Get-Date) - ($_.StartTime)}},
@{Name = "ComputerName";Expression = {$env:computername}}

#endregion


