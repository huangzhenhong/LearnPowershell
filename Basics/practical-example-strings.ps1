Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#demo common string techniques

$s = "PowerShell"
$s | Get-Member
cls
#one property
$s.Length

#strings can also be treated as an array
$s[0]
$s[3..6]

#case
$s.ToLower()
$s.ToUpper()
#doesn't change the variable
$s

#parsing with substring
$s.Substring.OverloadDefinitions
#start counting at 0
$s.Substring(5)
$s.Substring(0, 5)
#remember, the method is writing an object
$s.Substring(5).ToUpper()

cls

#split
$var = "I love Windows PowerShell"
$var.split
$var.split()
$var.split(" ", 3)
#or use the operator
$var -split "w"
cls
#split using a regular expression pattern  
$line = "FooData-BarData*FooData2*BarData2"
$data = $line -split "[\-\*]"
$data
#join
$data -join "||"
#but use cmdlets for things like paths
Join-Path -Path c:\work -ChildPath foo.dat

cls

#padding
$c = $env:computername
$c
$c.PadLeft
$c.PadLeft(20, ".")
#this doesn't do anything that you can see
$c.PadRight(20)
$c.PadRight(20, ".")
cls
#should be number greater than half the string length
$indent = 8
$PadWidth = ($c.Length) + $indent
$TotalWidth = $PadWidth * 2 - $c.length
$k = @()
$k += "*" * $TotalWidth
$k += $c.PadLeft($PadWidth).padright($totalWidth)
$k += "*" * $totalWidth
$k
#another way to join things
Write-Host $($k | Out-String) -ForegroundColor cyan

cls
#trim
$t = " Pluralsight   "
$t
$t.length
$t.TrimEnd()
$t.TrimStart()
$r = $t.trim()
$r
$r.length

cls

#you might need to clean-up data
$f = "c:\work\computers.txt"
Get-Content $f

#some commands can handle mis-formatted values
Get-Content $f | Foreach-Object { Test-Connection -Count 1 -computername $_ }

#trim white spaces
#I used Get-Member to discover actual property names from Test-Connection

Get-Content $f |
Where-Object { $_.length -gt 0 } |
Foreach-Object {
    Test-Connection -Count 1 -computername $_.Trim()
} | Select-Object @{Name = "Source"; Expression = { $_.PSComputername } },
IPV4Address, ResponseTime, @{Name = "Target"; Expression = { $_.address.ToUpper() } }

cls

#take your time to follow what PowerShell is doing
#read the help topics
# help about_split
# help about_join
