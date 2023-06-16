Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#demo common DateTime techniques
help Get-Date
cls
#case-sensitive
Get-Date "12/12/2024 14:34" -format g
Get-Date "12/12/2024 14:34" -format G
Get-Date "12/12/2024 14:34" -format u
# unix format
Get-Date "12/12/2024 14:34" -uformat "%Y_%m_%d"

#you can create a date
$a = "12/12/2024 2:15PM"
Get-Date $a
$b = Get-Date -Year 2024 -Month 12 -Date 31
$b
$b | Select-Object *
$b | Get-Member -MemberType methods

$b.IsDaylightSavingTime()
$b.ToLongDateString()

#these are methods you are likely to use
$b | Get-Member add*
$b.AddDays(45)
$b.AddHours(1000)
#easier to use a negative number
$b.AddMonths(-5)

#TimeSpans
[DateTime]$c = "11/11/2024 6:00PM"

help New-TimeSpan
#I corrected the command from the demo
$ts = New-TimeSpan -Start $c -End $b
$ts
$ts.Days

#or subtract
$c - $b

#TimeSpans usually are automatically displayed as strings inside double quotes
$ts.ToString()

cls

#practical examples

Get-Process | Where-Object { $_.StartTime } |
Select-Object -property ID, Name, WS,
@{Name = "Runtime"; Expression = { (Get-Date) - $_.StartTime } } |
Sort-Object Runtime -Descending |
Select-Object -first 10


# a hashtable of parameter values to splat to Get-ChildItem

$splat = @{
    Path    = "C:\Scripts"
    File    = $true
    Recurse = $True
    Include = "*.ps1", "*.psm1", "*.psd1", "*.txt", "*.xml", "*.json"
}

#the Include parameter requires -Recurse

Get-ChildItem @splat |
Group-Object -Property { $_.LastWriteTime.Year } |
Select-Object -Property Count, @{Name = "Year"; Expression = { $_.Name } },
@{Name = "Size"; Expression = { ($_.Group | Measure-Object -property length -sum).sum } },
@{Name = "Lines"; Expression = { ($_.Group | Get-Content | Measure-Object -Line -ignoreWhitespace).Lines } } |
Sort-Object -property Year |
Format-Table -GroupBy @{Name = "Path"; Expression = { $splat.Path } } -AutoSize

cls
