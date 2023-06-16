#demo formatting cmdlets
Return "This is a demo script file."

#read help and examples for all Format cmdlets as I am
#only demonstrating features you are most likely to use

# if you want to try my demo Vegetable commands:
#   Install-Module PSTeachingTools -force

#region Format-Table
#Let PowerShell decide how to format

Get-Vegetable
Get-Vegetable | Format-Table

#ft is an alias for Format-Table
Get-Vegetable | ft -Property Count,Name,Color
#This is just as easy
Get-Vegetable | Select-Object -Property Count,Name,Color
#and then you are setup to add commands to the expression

#think about formatting as filling a special need
Get-Vegetable | Select-Object -Property Count,Name,Color | ft -HideTableHeaders
cls

#or you want for force a specific format
$p = Get-Process | Select-Object id,ws,npm,cpu,name
$p
$p | Format-Table | more
cls

#wrap
$a = Get-Eventlog system -Newest 5 | Select EntryType,Source,Message
$a
$a | Format-Table -wrap

#be careful, Formatting may drop colums without warning
$a | ft message,source,entrytype
$a | ft message,source,entrytype -wrap
#you may need to adjust property order
cls
Get-Process | select id,name,path,ws | ft -wrap
Get-Process | select id,ws,name,path | ft -Wrap

#you can use wildcards
Get-Process -id $pid | ft name,peak*size
cls

#Autosize
#PowerShell does a good job of autosizing automatically, but it never hurts to try
Get-Vegetable | ft
Get-Vegetable | ft -autosize
cls
#grouping
Get-Vegetable | Format-Table -GroupBy Color | more
#I'll exclude the color property since I am grouping on it
Get-Vegetable | Sort Color | Format-Table -GroupBy Color -Property Count,Name,State
#need to use property names you see with Get-member

Get-Vegetable carrot | Format-Table *
Get-Vegetable | Sort Color | Format-Table -GroupBy Color -Property Count,Name,CookedState
#there's no way to control the spacing other than to create a custom view of your own
cls

Get-CimInstance win32_process -filter "workingsetsize > $(50mb)" -ComputerName srv1,srv2,dom1 |
Format-Table -GroupBy PSComputername -Property ProcessID,Name,WorkingSetSize

cls
#sometimes default formatting gets in the way
dir c:\work -file | Sort Extension | ft -GroupBy Extension
dir c:\work -file | Sort Extension | ft -GroupBy Extension -Property Mode,Lastwritetime,Length,Name
cls


#creating custom properties

Get-Process -id $pid | Format-Table ID,WS,
@{label="Runtime";Expression={New-Timespan -Start $_.StartTime -End (Get-Date)}}

#Use Name/Expression

Get-Process -id $pid | Format-Table ID,WS,
@{Name="Runtime";Expression={New-Timespan -Start $_.StartTime -End (Get-Date)}}

#this is the way I prefer

Get-Process -id $pid | Select-Object -property ID,Path,
@{Name="WorkingSetMB";Expression = {$_.ws/1mb -as [int]}},
@{Name="Runtime";Expression={New-Timespan -Start $_.StartTime -End (Get-Date)}} |
Format-Table -GroupBy Path -Property ID,WorkingSetMB,RunTime


cls
#there is an exception
#Align does not work in Select-Object

Get-Process -id $pid | Format-Table -property ID,Path,
@{name="WorkingSetMB";Align="Center";Expression = {$_.ws/1mb -as [int]}},
@{Name="Runtime";Align="Right";Expression={New-Timespan -Start $_.StartTime -End (Get-Date)}}

cls

#this demo was not included in the finished course
#force best possible fit

Get-Service | where {$_.dependentservices.count -gt 0} | Format-Table Name,DependentServices

#each dependent service is a service object

Get-Service |
where {$_.dependentservices.count -gt 0} |
Format-Table -wrap -autosize -Property Name,
@{Name="Dependencies";Expression={$_.dependentservices.name -join ','}} |
more

cls


#endregion
