Return "This is a demo script file."

#read help and examples for all Format cmdlets as I am
#only demonstrating features you are most likely to use

# if you want to try my demo Vegetable commands:
#   Install-Module PSTeachingTools -force

#region Why Format right
Get-Vegetable | Format-List | Export-Csv c:\work\veg.csv
#no errors. But....
Import-Csv C:\work\veg.csv

Get-Service | Format-Table Displayname,Status,StartType | Sort Displayname
Get-Service | Format-Table | Get-Member
#not this
Get-Service | Get-Member
cls

#filter left, format right
Get-Service w* | Sort Displayname | Format-Table Displayname,Status,StartType
cls
#there are exceptions to this rule I'll cover next
#endregion