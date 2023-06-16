#demo out cmdlets
Return "This is a demo script file."

# if you want to try my demo Vegetable commands:
# Install-Module PSTeachingTools -force

#read help and examples for all the commands I'm showing

#region Out-File

#you don't need to format to use this command
Get-Vegetable | Out-File c:\work\veg.txt
notepad c:\work\veg.txt

Get-Vegetable | ft -view state | Out-File c:\work\vegstate.txt
Get-Content c:\work\vegstate.txt
cls

Get-Process -IncludeUserName |
Sort-object Username |
Format-Table -groupby Username -Property Handles,WS,PM,NPM,CPU,ID,Name,
@{Name="Runtime";Expression={New-Timespan -start $_.starttime -end (Get-Date)}} -AutoSize |
Out-File c:\work\user.txt

notepad C:\work\user.txt

#avoid using console redirection because you'll miss out on parameters like WhatIf
#and NoClobber
cls

#endregion

#region Out-Printer

#find printers
Get-Printer
#or use CIM
Get-CimInstance win32_printer | Select Name,Default,PortName

#save as veg.pdf in documents
Get-Vegetable | ft -view state | Out-Printer
Invoke-Item $home\documents\veg.pdf
#be careful

$p = Get-Process -IncludeUserName |
Sort-object Username |
Format-Table -groupby Username -Property Handles,WS,PM,NPM,CPU,ID,Name,
@{Name="Runtime";Expression={New-Timespan -start $_.starttime -end (Get-Date)}}

#save as user.pdf
$p | Out-Printer
Invoke-Item $home\Documents\user.pdf

cls
#you might need to experiment with different property order, wrapping, and autosize
#save as user2.pdf

Get-Process -IncludeUserName |
Sort-object Username |
Format-Table -groupby Username -Property ID,Name,Handles,WS,PM,NPM,CPU,
@{Name="Runtime";Expression={New-Timespan -start $_.starttime -end (Get-Date)}} -AutoSize -Wrap |
Out-Printer

Invoke-Item $home\Documents\user2.pdf

cls
#endregion
#region Out-String

#special use case command
$s = Get-Vegetable | sort color | Format-Table -GroupBy color -Property Count,Name | Out-String
$s
$s | Get-Member
$s.toupper()
cls
#don't try to parse strings when you can use properties.
#endregion
#region Out-Gridview

#formatted data fails
Get-Service w* | Sort displayname | Format-Table Displayname,Status,StartType | Out-GridView
Get-Service w* | Select Displayname,Status,StartType | Out-GridView
#passthrough is very useful
Get-Service | Where {$_.status -eq 'running'} | Out-GridView -Title "Select a process" -PassThru
#use output mode to control how much to select
help out-gridview -parameter Outputmode
cls

Get-Service | Where {$_.status -eq 'running'} |
Out-GridView -Title "Select a service" -OutputMode Multiple |
Restart-Service -passthru

cls

#endregion
