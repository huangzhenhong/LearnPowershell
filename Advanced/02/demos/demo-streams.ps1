#demo stream redirection

Return "This is a walk-through demo file"

Get-CimInstance Win32_LogicalDisk -filter "deviceid='c:'" -Verbose
#warning sample
Test-NetConnection foo

#error sample
Get-Service FooBarFun,winrm,BITS

help about_Redirection

#  Stream #   Description          Introduced in    Write Cmdlet
#  ---------- -------------------- ---------------- -------------------
#  1          SUCCESS Stream       PowerShell 2.0   Write-Output
#  2          ERROR Stream         PowerShell 2.0   Write-Error
#  3          WARNING Stream       PowerShell 3.0   Write-Warning
#  4          VERBOSE Stream       PowerShell 3.0   Write-Verbose
#  5          DEBUG Stream         PowerShell 3.0   Write-Debug
#  6          INFORMATION Stream   PowerShell 5.0   Write-Information
#  *          All Streams          PowerShell 3.0

cls

#Success
#typically use Out-File to save results
#this is what we could have done in the old CMD days
Get-Process powershell > c:\work\ps.txt
Get-Content C:\work\ps.txt
#I recommend this
Get-Process powershell | Out-File c:\work\ps.txt

#Errors
#this is what we could have done in the old CMD days
Get-Service FooBarFun,winrm,BITS 2>c:\work\svc-error.txt
Get-Content C:\work\svc-error.txt

#you can also use the common errorvariable
Get-Service FooBarFun,winrm,BITS -ErrorVariable ev
$ev
$ev.exception | out-file c:\work\ev.txt
get-content c:\work\ev.txt

#warnings
Test-NetConnection foo 3>c:\work\test.txt
#cat is an alias for get-Content
cat C:\work\test.txt

#this too has a common variable
#use the warning action to supress the warning outpout
Test-NetConnection fooby -WarningVariable wv -WarningAction SilentlyContinue
$wv

#verbose
Get-CimInstance Win32_LogicalDisk -filter "deviceid='c:'" -Verbose 4>c:\work\verbose.txt
#another alias for get-content
gc C:\work\verbose.txt

#you can combine
Get-CimInstance Win32_LogicalDisk -filter "deviceid='c:'" -CimSession $env:computername,"fooby" -verbose *>c:\work\all.txt
#gc is an alias for Get-Content
gc C:\work\all.txt

#stream redirection should be for special situations and may not be supported
#on all hosts.

cls