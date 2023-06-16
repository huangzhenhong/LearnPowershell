#region Running commands

Return "This is a walk-through demo file"

Get-Process
cls
# The *-Vegetable commands are in the PSTeachingTools module which you can install
# Import-Module PSTeachingTools -force
# Answer yes to any prompts
Get-Vegetable
help Get-Vegetable
# parameters
Get-Vegetable -Name corn
Get-Vegetable -RootOnly

# verbose
Get-Vegetable -Verbose

cls

Get-Service -Name win* -Verbose
#some parameters are positional
Get-Service win*

help Get-Service -Parameter name
help Get-Service -Parameter requiredServices
gsv bits -RequiredServices

cls

help Get-Process
# I want to get the current PowerShell process ID
# this fails
Get-Process $pid

help get-process -Parameter id
Get-Process -Id $pid

cls

#some commands have default behavior, others have mandatory parameters
Get-CimInstance

help Get-Ciminstance -Parameter *name
Get-CimInstance win32_operatingsystem -Verbose -ComputerName localhost

cls

#endregion

# demo-history.ps1