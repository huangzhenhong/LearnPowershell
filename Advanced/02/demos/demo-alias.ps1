Return "This is a walk-through demo file"

$PSVersionTable

# Get all the alias
Get-Alias 

Get-Volume -DriveLetter C

Get-Service -Name bits,winrm -Verbose

Stop-Service -Name WinRM -WhatIf -Verbose

# Get the history commands executed
Get-History

# execute a history command
Help Invoke-History
Invoke-History -Id 1

#using an alias
dir c:\
ls C:\

#the actual command
Get-Alias -Name dir
Get-Command gsv

Get-ChildItem c:\
cls

# PowerShell command alias
gsv

#this is the full command
Get-Service

Help Get-Service

Help Get-Service -Parameter Name

Get-Service -Name win* -Verbose

# List all the commands 
Get-Command

Get-Command -CommandType Function 

Get-Command -name *disk -CommandType Function 

#how did I know?
Get-Command gsv
Get-Command Get-Service

Get-Verb

Get-Command -Verb Mount

Get-Command -noun DiskImage

Get-Command -Noun *disk -verb Get

#region Get-Help
help Get-Service

#or use the alias
help dir

#What commands work with aliases?
Get-Command -Noun alias
cls

# demo-running-commands.ps1

Get-Vegetable

Help Get-Vegetable

# Powershell process 
$pid

Help Get-Process -Parameter Id

# Get a specific process by Id
Get-Process -Id $pid

# Get all processes
Get-Process

# Get CimInstance
Help Get-CimInstance 

Get-CimClass -ClassName *memory*
Get-CimInstance Win32_PhysicalMemory -Verbose

