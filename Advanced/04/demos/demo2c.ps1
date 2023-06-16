return "This is a demo script file"

#region a complete example
#this is using an advanced technique with
#a hashtable to define a new property

#I'm using parameter names for the sake of clarity
#most of them are positional

dir c:\windows -file |
group -property extension |
Select -property Name,Count,
@{Name="Size";Expression={ $_.group | Measure -property length -sum | select -expandproperty sum  }} |
Sort -property Size -Descending |
Select -first 5

cls

#endregion

#region Bonus demo

Get-WinEvent -ListLog * |
sort FileSize -Descending |
select -First 10 -Property Logname, RecordCount, FileSize

#let's discover
Get-WinEvent -LogName system -MaxEvents 1 | select *

#what is causing problems?

Get-WinEvent -LogName system -MaxEvents 1000 |
group Providername -NoElement |
sort Count -Descending |
select -First 10 |
Out-GridView

cls

#endregion