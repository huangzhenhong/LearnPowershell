Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#the following is advanced .NET hacking
#static methods

$dt = Get-Date
#standard members
$gmNames = ($dt | Get-Member -MemberType Methods).name
$gmNames

#an instance of the type might have static methods
#these are methods that don't require an instance of the object
$dt | Get-Member -Static
# Get-Date | Get-Member -static

#this will fail
$dt.IsLeapYear(2024)

# :: is the static method operator
#use the class object
[DateTime]::IsLeapYear(2024)

[DateTime]::DaysInMonth(2024, 2)
# running $dt.DaysInMonth(2024,2) will fail

cls

#some classes don't create objects and all you have are static methods

# you can't pipe the [math] class to Get-Member because there aren't any objects like
# we have with services and processes


[math].GetMembers() |
Where-Object { $_.IsStatic } |
Select-Object -Property Name, MemberType -Unique |
Sort-Object MemberType, Name


#the math class doesn't have any static properties which is why PropertyType is empty

#this is a .NET way to discover how to use the method
# :: is the static operator
[math]::Pow.OverloadDefinitions
[math]::Pow(2, 3)
[math]::Sqrt(144)
[math]::PI

$r = 5
([math]::PI) * ([math]::Pow($r, 2))

cls

# I've included a function in the demo folder called Get-TypeMember you can use
# to identify static methods. The function is an alternative to Get-Member.
