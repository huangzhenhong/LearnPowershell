#demo formatting cmdlets


#region Alternate views

Get-Process | Format-Table -view priority
#there's a bug in the formatting file
Get-Process | sort starttime | ft -view Starttime | more
#discovery
Get-Process | ft -view foo
#look at the error message
cls
#use an advanced cmdlet

Get-FormatData system.diagnostics.process -PowerShellVersion $PSVersionTable.PSVersion |
Select-Object -ExpandProperty FormatViewDefinition

# Use a command from my module
# Install-Module PSscriptTools
help Get-FormatView
Get-Vegetable | Get-Member
Get-FormatView  PSTeachingTools.PSVegetable
Get-Vegetable | ft -view state
cls
#use with native commands

Get-FormatView system.serviceprocess.servicecontroller
#the ANSI view is added by the PSScriptTools module
Get-Service | ft -view ansi

#run the command with no type to see everything
Get-FormatView | more
#some of these are from command in the PSScriptTools module

Get-FormatView | group typename | Where count -gt 2 |
sort count -Descending |
Format-Table -AutoSize

cls
#You can define your own custom views, but that it outside the scope of this course

#endregion

