Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#demo working with hash table

#splatting
#standard usage
Get-Service -Name b* -Exclude bits

#define a hashtable of parameters and values
#the hash table key must match the parameter name
$p = @{Name = 'b*'; Exclude = 'bits' }
#splat the hashtable
Get-Service @p

$cim = @{ClassName = 'Win32_Bios'; Verbose = $True }
$cim
Get-CimInstance @cim

$cim.ClassName = 'Win32_OperatingSystem'
Get-CimInstance @cim

#you can combine splatting with other parameters
Get-CimInstance @cim -ComputerName $env:computername

cls
#this is very handy when it comes to scripting
#you can update hash tables on-the-fly
$splat = @{Computername = $env:Computername; FilterHashTable = @{} }
#get all error and warning entries from the last 3 days
$filter = @{LogName = ''; Level = 2, 3; StartTime = $(Get-Date).AddDays(-3) }
$logs = 'system', 'Application', 'Windows PowerShell'

$logs | ForEach-Object {
    #update the filter hash table LogName key
    $filter.LogName = $_
    #update the splat hash table FilterHashTable key
    $splat.FilterHashTable = $filter
    #splat
    Get-WinEvent @splat
}

help about_Splatting

cls

