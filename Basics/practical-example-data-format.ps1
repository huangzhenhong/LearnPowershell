Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#format operator
#these links may change
# https://docs.microsoft.com/dotnet/standard/base-types/composite-formatting

$s = Get-Service bits
"The service {0} is {1}." -f $s.name,$s.status

# https://docs.microsoft.com/dotnet/standard/base-types/standard-numeric-format-strings

#results are strings

#fixed format
$n = 12345.5678
"{0:f}" -f $n
"{0:f0}" -f $n
"{0:f3}" -f $n

#numeric with commas
"{0:n0}" -f $n

# to 3 decimal points
"{0:n3}" -f $n

#percent
"{0:p}" -f (45/100)
"{0:p4}" -f (455/1237)

#currency is culture specific
"{0:c}" -f 23.56

cls

#date time formats are similar to what we looked at earlier
# https://docs.microsoft.com/dotnet/standard/base-types/standard-date-and-time-format-strings

$d = "12/31/2024 11:10AM"
#case sensitive
"{0:d}" -f $d
"{0:D}" -f $d
"{0:g}" -f $d
"{0:f}" -f $d
"{0:u}" -f $d
"{0:yyyy-dd-MM}" -f $d

cls

# a practical example


$splat = @{
 path = "C:\Work"
 Recurse = $true
 File = $true
}

$data = Get-ChildItem @splat | Measure-Object -Property length -sum
#cost per KB
$rate = "0.005"
$cost = ($data.sum/1KB) * $rate

#you could save this to a file
$string = "[{0}] Files:{1:n0} TotalKB:{2:n2} Billing:{3:c2}" -f $splat.Path,$data.count,($data.sum/1KB),$cost
$string

cls
