#demo formatting cmdlets
Return "This is a demo script file."

#read help and examples for all Format cmdlets as I am
#only demonstrating features you are most likely to use

# if you want to try my demo Vegetable commands:
#   Install-Module PSTeachingTools -force

#region Format-List
#there is no defined list view for vegetable objects so you get everything
Get-Vegetable  | Format-List
#but there is a default for other commands
Get-Process -id $pid | Format-List

Get-Item $pshome\powershell.exe
Get-Item $pshome\powershell.exe | fl
cls
#format list is a handy discovery tool
Get-Item $pshome\powershell.exe | fl -Property *
Get-Process -id $pid | fl *

#let PowerShell handle formatting - no need to call Format-List
Get-Process -id $pid | Select ID,Name,HandleCount,WS,PM,Path,Description

cls
#grouping
#need to sort first

Get-Vegetable | sort color |
fl -GroupBy Color -Property Name,Count,CookedState,IsPeeled | more


dir c:\work -file | fl Name,Length,Lastwritetime -GroupBy Directory | more

cls

Get-Eventlog system -Newest 10 |
Sort Source |
Format-List -GroupBy source -Property EntryType,InstanceID,Message,Username,TimeGenerated |
more

cls
#custom properties

dir c:\work -file |
Format-List -property Name,@{Name="Size";Expression={$_.Length}},
Lastwritetime,
@{Name="Age";Expression = {New-Timespan -Start $_.lastwriteTime -end (Get-Date)}} -GroupBy Directory |
more

#I would write it this way
#specify the properties in the order you want them listed

dir c:\work -file |
Select-Object -property Directory,Name,Lastwritetime,CreationTime,
@{Name="Size";Expression={$_.Length}},
@{Name="Age";Expression = {New-Timespan -Start $_.lastwriteTime -end (Get-Date)}} |
Sort-Object -property Age -Descending |
Format-List -GroupBy Directory -Property Name,Size,CreationTime,Lastwritetime,Age |
more


cls
#endregion


