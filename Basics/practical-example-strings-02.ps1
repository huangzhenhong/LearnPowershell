Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#replace
#We have this variable
$s = "PowerShell"

#method
#we have this string
$s.Replace.OverloadDefinitions
$s.replace("e", 3)
#original doesn't change
$s
#you can combine
$s.Replace("o", "()").Replace("e", "<").Replace("h", "&")

#case-sensitive
#sometimes you don't know what the data will be
#the method is case-sensitive
$s.replace("p", "X")
#use the operator which is case-insensitive
$s -replace "p", "X"
#can also use regular expressions
$s -replace "[aeiou]", "@"
"jeff789" -replace "\d", "N"

cls

#an example
#this might be a line from a log file
$data = "art | deco |1234|Sales"
$arr = $data.split("|").Trim()
$arr
#using arrays
$arr[0]
#this fails
#get the first character of the first element of $arr
($arr[0][0]).ToUpper()
$arr[0][0] | Get-Member
#technically a string element is a [CHAR] so it needs to
#be converted to a string first
($arr[0][0]).toString().ToUpper()

cls

#there are other ways to achieve the same result.
#I wanted to demonstrate string techniques
$name = @()
$name += $arr[0].replace($arr[0][0], $arr[0][0].toString().ToUpper())
$name
$name += $arr[1].replace($arr[1][0], $arr[1][0].toString().ToUpper())
$name
$name -join ' '
Write-Host "Creating user '$($name -join ' ')' in the $($arr[-1].ToUpper()) department" -ForegroundColor yellow

cls


