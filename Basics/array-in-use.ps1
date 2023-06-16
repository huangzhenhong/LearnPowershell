Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#demo working with arrays

$p = Get-Process -Id $pid
$n = 'Foo', 'Bar', '#', '%', 1, 5, 7, '!', 'Alpha', 'Omega', $p
$n.Count
$n
#you can have different types, although you typically won't
$n | Get-Member | Select-Object -Property Typename -Unique
cls


#test for containment
#not case-sensitive
$n -contains 'FOO'
$n -contains 'xyz'
#or test if it doesn't contain
$n -notcontains 'xyz'

#you can also turn this around
#this could run slightly faster, especially for very, very large arrays
'xyx' -in $n
'xyz' -NotIn $n

cls

#a practical example
$list = 'rdpclip', 'searchapp', 'spoolsv'

#this is not the only way to do this task
#This is example is for demonstration purposes
# Get-Process $list
Get-Process | Where-Object { $list -contains $_.name }

#this might make more logical sense
Get-Process | Where-Object { $_.name -in $list }

#although it would make a useful exclusion technique
# Get-Process | Where-Object {$_.name -notin $list}
#

# this is not the only way to do this task
#but it helps demonstrate the -NotIn operator
$allowed = 'default share', 'Remote Admin', 'Remote IPC'
Get-SmbShare -CimSession $env:computername | Where-Object { $_.Description -NotIn $allowed }

cls
