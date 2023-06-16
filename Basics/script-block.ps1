Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#these code snippets are in the slides for this module

#creating a scriptblock
$sb = { Get-Service | Where-Object { $_.status -eq 'running' } }

#running a scriptblock

& $sb

Invoke-Command $sb

#used everywhere
#typically in scripts
Get-Process | Where-Object { $_.ws –ge 100MB } | Select-Object -Property ID, Name, WS

$new = @{
    Path     = 'C:\Work'
    ItemType = 'Directory'
    Force    = $True
}
1..10 |
ForEach-Object {
    New-Item -Name "Data-$_" @new
}

#with parameters
$sb = { Param([string]$log, [int]$count) Get-WinEvent -LogName $log -MaxEvents $count }

&$sb system 2 | Format-List ProviderName,ID,LevelDisplayName,Message
#using parameter names
&$sb -count 2 -log system | Format-List ProviderName,ID,LevelDisplayName,Message

#splatting
$p = @{count = 5; log = 'system' }
&$sb @p

#using Invoke-Command - parameters are positional and passed as an array
Invoke-Command -ScriptBlock $sb -ArgumentList System, 2

Start-Job {
    param([string]$log, [int]$count)
    Get-WinEvent -FilterHashtable @{
        LogName            = $log
        SuppressHashFilter = @{Level = 4 }
    } -MaxEvents $count |
    Group-Object -property ProviderName -NoElement |
    Sort-Object -property Count -Descending
} -ArgumentList System, 1000 -Name LogInfo

Receive-Job LogInfo -Keep | Format-Table -AutoSize

#eventually you'll create functions
Function Get-LogInfo {
    Param(
        [string]$Log = 'System',
        [int]$Count = 100
    )
    Get-WinEvent -FilterHashtable @{
        LogName = $log
        Level   = 2, 3
    } -MaxEvents $count | Group-Object -property ProviderName -NoElement |
    Sort-Object -property Count -Descending
} #end function

Get-LogInfo
