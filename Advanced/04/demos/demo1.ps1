Return "This is a demo script file"

#region Group-Object

# Install-Module PSTeachingTools -force

Get-Vegetable
Get-Vegetable | Group-Object -Property Color
#Group is an alias for Group-Object
Get-Vegetable | group color | Get-Member

#let's try with a real PowerShell command
Get-Process -IncludeUserName | group Username
cls

#you can use any property
Get-Service winrm
Get-Service winrm | Get-Member -MemberType properties
Get-Service | group StartType -NoElement
#be sure to read help

cls

#endregion

