#demo formatting cmdlets
Return "This is a demo script file."

#read help and examples for all Format cmdlets as I am
#only demonstrating features you are most likely to use

# if you want to try my demo Vegetable commands:
#   Install-Module PSTeachingTools -force

#region Format-Wide

Get-Vegetable | format-wide
#the alias for Format-Wide is fw
Get-Service | fw
#specify the property name to use
Get-Service | fw -Property Displayname
#columns
Get-Service | fw -column 3
Get-Vegetable | fw -Column 4
#autosize
Get-Vegetable | fw -AutoSize
#Depends on the length of the text to display
cls

#group

Get-EventLog system -Newest 500 |
sort entrytype |
fw -group entrytype -Property source |
more

#custom formatting
$g = Get-EventLog system -Newest 500 | group Source
$g
$g | fw
#use a scriptblock that will define a string
$g | sort name | Format-Wide {"$($_.name) [$($_.count)]"}
cls

#endregion

