Return "This is a demo script file"

#region Select-Object

#objects

Get-Vegetable | select -First 3

# or select properties
#Property is positional
Get-Vegetable | select -Property Count, Name, State
#why did that fail?

#here's a handy discovery technique
Get-Vegetable | select -First 1 -Property *
#see the true property name?
Get-Vegetable | select Count, Name, CookedState

cls
#let's try with regular commands
Get-Service | select Name, StartType
#this gives you to raw value, not the formatted value you see by default
Get-Process | select ID, Name, WS, CPU -First 10
Get-WinEvent -ListLog System
Get-WinEvent -ListLog System | select *

Get-WinEvent -ListLog * | select Logname, Recordcount, MaximumSizeInBytes, FileSize | Out-GridView

cls
#endregion
