Return "This is a demo script file"

#region Measure-Object
Get-Vegetable
Get-Vegetable | measure-object -Property count -Sum
cls
#look at a sample
Get-Process | select -First 1

Get-Process | measure -Property WS -Sum -Average
#let's be selective

Get-Process |
measure -Property WS -Sum -Average |
select count, Sum, Average

cls
#endregion

#region Combining
Get-Process | sort WS -Descending | select -First 5

dir $env:temp -Recurse -file |
measure length -sum -av -max -min |
select * -ExcludeProperty Property

cls


#endregion
