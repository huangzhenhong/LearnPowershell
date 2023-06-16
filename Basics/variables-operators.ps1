Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#fundamentals
"foo" | Get-Member | more
123 | Get-Member | more
Get-Process -id $pid | Get-Member | more
cls

$d = '1/1/2024'
$d | Get-Member | more

#casting to type
#PowerShell can make educated guesses
$d
$d - (Get-Date)

[datetime]$d = '1/1/2024'
$d - (Get-Date)

cls

#type operators -IS and -AS
$i = '10'
$i * $i

$i -is [int32]
$i -is [string]
$i -as [int32]
($i -as [int32]) * 3

"1.0" -as [version]
[version]$v = "1.0.0"
$v

Remove-Variable d
$d = "1/1/2024"
$d -is 'datetime'
$d -is 'string'
($d -as [datetime]) - (Get-Date)

cls

#type tricks
# get the type name
$d
#methods require the parameters
$d.GetType()
#This is just another object
$d.GetType().Name

$i = 123.789
$i.gettype().name
#casting as type might change things
$i -as [int]

cls

#using dotted notation
$p = Get-Process -Id $pid
$p

$p | Get-Member -MemberType Properties
$p.id
$p.path

#view all properties
$p | Select-Object -Property *

#you can extend the dotted notation
#visualization is a big help
$p.modules
$p.modules.modulename

#here's a cool trick
$all = Get-Process
$all.Name
$all.Name.ToUpper()

cls

#don't assume what you see is what you get
# Install-Module PSTeachingTools -force
Get-Vegetable
#This doesn't work the way you might expect
Get-Vegetable | Select-Object Name, State, Count
#check members
Get-Vegetable | Get-Member
#look at values
Get-Vegetable corn | Select-Object *
#revise the command
Get-Vegetable | Select-Object Name, CookedState, Count

cls

#invoking object methods
notepad
$n = Get-Process notepad
$n | Get-Member -MemberType methods
$n.CloseMainWindow()
Get-Process notepad
#look for cmdlets that invoke methods

cls

$n = "fred", "betty", "wilma", "barney"
$n[0] | Get-Member ToUpper
$n | ForEach-Object { $_.ToUpper() }

#this will also work
$n.ToUpper()

#some methods have parameters
$n[0] | Get-Member substring

#capitalize the first letter of each name
$n | ForEach-Object { "$($_.substring(0,1).ToUpper())$($_.Substring(1))" }
#                                   ^F                    ^red

#we'll look at other ways to manipulate strings in the next module

cls

