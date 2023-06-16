Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#Contains methods
$j = @{name = 'foo' }

#keys must be unique
$j.Add('name', 'bar')

$j | Get-Member -Name contains*
$j.ContainsKey('name')
$j.Contains('name')

cls

#this is the kind of thing you would put in a script
#create a hashtable where the key is a unique process
#name and the value is the total working set of all
#related processes

Get-Process |
ForEach-Object -Begin { $p = @{} } -Process {
    if ($p.Contains($_.name)) {
        $p.Item($_.name) += $_.WS
    }
    else {
        $p.Add($_.name, $_.WS)
    }
}

$p
#this won't work the way you think
$p | Sort-Object -Property name

$p | Get-Member -MemberType Method
#You need to enumerate the hash table with GetEnumerator()
$p.GetEnumerator() | Get-Member
#Name is an alias property for Key
$p.GetEnumerator() | Sort-Object -Property Name
$p.GetEnumerator() | Where-Object { $_.value -ge 250MB } | Sort-Object -Property Value

cls

#look at SampleScript.ps1 for a more complex example of
#using arrays and hash tables
