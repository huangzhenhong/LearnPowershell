Return "This is a demo script file. Open this file in the PowerShell ISE or VS Code."

# How to use Variables in PowerShell
$a = 2
Get-Vegetable | Select-Object -First $a
$a = 5

#I'll use the variable a and save the results to variable b
$b = Get-Process | Select-Object -First $a
$b
$b | Select-Object Name

#now you can use the results without having to re-run Get-Process
$b | Sort-Object ws -Descending | Select-Object name,ws
$b | select id,name,handles

# Get alias
Help Get-Alias 
Get-Alias -Definition Select-Object

#saving time
#Tip: learn to use Get-WinEvent instead of Get-Eventlog
Help Get-WinEvent
$logs = Get-WinEvent -LogName system -MaxEvents 1000
$logs
$logs | Group-Object LevelDisplayName -NoElement
$logs | Group-Object ProviderName -NoElement
cls

$logs 
| Where-Object { $_.providername -eq 'service control manager' } 
| Select-Object TimeCreated, LevelDisplayName, Message -first 5

cls

#variables shouldn't change
$bits = Get-Service BITS
$bits | Select-Object name, StartType


Set-Service bits -StartupType Disabled -PassThru |
Select-Object name, StartType

#variable is unchanged
$bits.StartType

#reset
# Set-service bits -StartupType Manual

#sometimes the variable will change
$veg = Get-Vegetable c*
$veg
Set-Vegetable corn -Count 1 -Passthru
$veg

cls

#type
$a = 2
#this is a an alternative to showing type name instead
#of using Get-Member
$a.GetType()
$a + $a

#be careful
$i = '5'
$i + $i
$i.GetType()

# cast to type
[int32]$i = 10
$i * 2

[datetime]$d = "12/31/2024"
$d
$d.GetType()

#but be careful
$d = "foo"
#either remove the variable or re-define
[string]$d = "foo"
$d
#or be careful of your variable names and usages

cls
#a slightly advanced alternative
$t = "12/12/2024 10:00 AM"
$t
$t.getType()
$t -as [datetime]
#doesn't change $t
$t.Length

cls
