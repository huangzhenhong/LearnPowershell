Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#Bonus demo

$env:PSModulePath

#I would normally leave the numeric value as a number
#using -F treats it as a string which requires an extra
#step on my part. Think of this example more of a demonstration
#and not production-ready code.

$env:PSModulePath -split ';' | ForEach-Object {
    $m = Get-ChildItem -Path $_ -File -Recurse |
    Measure-Object -Property length -Sum
    [PSCustomObject]@{
        Path   = $_
        Files  = $m.count
        SizeKB = '{0:n0}' -f ($m.sum / 1KB -as [int32])
    }
} | Sort-Object { $_.SizeKB -as [int32] } -Descending

cls
