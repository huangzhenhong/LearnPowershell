Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#demo array fundamentals
$a = 1..10
$a
#we'll cover -is later in the course
$a -is [array]

#a case where the variables DOES have its own meaning
#you can get the count of the array
$a.count
$a.length
#even though the contents are integers
$a | Get-Member

cls

$b = 'foo', 'bar', 'abra', 'ca', 'dabra'
$b.Count

#reference by index number
$b[0]
$b[1]
#start at the end
$b[-1]
$b[-2]

#or you can do this:
$b[1..3]
cls

#create an empty array
$c = @()

$c += 'localhost'
$c += $env:computername
$c += 'foo'
$c

#this doesn't work
Test-WSMan -ComputerName $c
#why?std
help test-wsman -Parameter computername
#this will work
$c | Test-WSMan
help test-connection -Parameter computername

#test the command
Test-Connection $c[0] -Count 1
Test-Connection $c -Count 1
cls

#can't remove items from an array
#but you can re-define
#this is not the only way you could do this

Test-Connection -ComputerName $c -Count 1 |
Where-Object { $_.statuscode -eq 0 } |
ForEach-Object -Begin { $c = @() } -Process {
    $c += $_.Address
} -End {
    Write-Host 'testing complete' -foreground cyan
}


#what is in $c now?
$c

#Another example to rebuild an array
# $a = 1..10
#rebuild the array where the number is > 6
#use whatever code you need to filter out what you don't want.4
# $a = $a | where { $_ -ge 6 }
# $a

#read the help
help about_arrays

cls
