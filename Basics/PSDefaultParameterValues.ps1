Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#You need to specify a log name otherwise
#Get-WinEvent throws an error
Get-WinEvent -LogName system -MaxEvents 1

#lets set default values

#PSDefaultParameterValues
#is defined but empty by default
Get-Variable -Name PSDefaultParameterValues
$PSDefaultParameterValues | Get-Member
$PSDefaultParameterValues
cls

#this is a special hashtable variable
#you might set these in your PowerShell profile script
$PSDefaultParameterValues.add('Get-WinEvent:LogName', 'System')
$PSDefaultParameterValues.add('Get-WinEvent:MaxEvents', 10)
$PSDefaultParameterValues

#use the defaults
Get-WinEvent
#use other values
Get-WinEvent application -max 1

#change a value
$PSDefaultParameterValues['Get-WinEvent:MaxEvents'] = 5
Get-WinEvent security

#you can disable them
$PSDefaultParameterValues['Disabled'] = $True
#this should throw an exception again
Get-WinEvent

#or clear them
$PSDefaultParameterValues.Clear()
$PSDefaultParameterValues

help about_Parameters_Default_Values

cls
