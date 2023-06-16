Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#demo common number techniques
1kb
3kb
1mb
1gb
1tb

459870234 / 1mb

#you can round to an integer
54598225634 / 1gb -as [Int32]

cls

#doing math with .NET

#we looked at static methods in Module 6

[math].GetMethods() | Group-Object -Property Name
#this is one you'll use often
[math]::round.OverloadDefinitions
$i = 345.6789
#round to 2 decimal points
[math]::round($i, 2)

$m = Get-ChildItem c:\scripts\*.ps* | Measure-Object -property Length -sum
$m.Sum
#in KB
$m.sum / 1kb
#in MB
$m.sum / 1mb
#as an int
$m.sum / 1kb -as [int]
#rounded
[math]::round($m.sum / 1mb, 4)

cls

#a hashtable of parameters to splat to Get-ChildItem

$get = @{
    Path    = "C:\Users\zhuae09687\Downloads\windows-powershell-language\07\demos"
    File    = $True
    Recurse = $True
    Exclude = "*.exe", "*.dll"
}



Get-ChildItem @get |
Where-Object { $_.Extension } |
Group-Object -Property Extension -AsHashTable | Tee-Object -Variable g

#this is code that would make a good PowerShell script or function
#The code is technically a one-line command

$g.GetEnumerator() |
Select-Object -Property @{Name = "FileType"; Expression = { $_.Name } },
@{Name = "Count"; Expression = { $_.value.count } },
@{Name = "SizeKB"; Expression = {
        $m = $_.value | Measure-Object -Property length -sum
        [math]::round($m.sum / 1KB, 2)
    }
} | Sort-Object -Property SizeKB -Descending |
Select-Object -first 10


cls

#another practical example

Get-CimInstance Win32_OperatingSystem -ComputerName $env:computername |
Select-Object Caption, TotalVisibleMemorySize, FreePhysicalMemory, PSComputername |
Tee-Object -Variable os

#don't assume all values are in bytes

$os | Select-Object @{Name = "Computername"; Expression = { $_.PSComputername.ToUpper() } },
@{Name = "OperatingSystem"; Expression = { $_.Caption } },
@{Name = "TotalMemoryGB"; Expression = { ($_.TotalVisibleMemorySize / 1mb) -as [int] } },
@{Name = "FreeMemoryGB"; Expression = { [math]::round($_.FreePhysicalMemory / 1mb, 2) } }


#I built a script around this
C:\Users\zhuae09687\Downloads\windows-powershell-language\07\demos\Get-ComputerData.ps1 -Computername srv1, srv2, dom1, win10

cls
