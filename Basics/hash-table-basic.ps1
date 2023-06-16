Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#demo hash table fundamentals

#create an empty hash table
#don't confuse this with an array
$ht = @{}

#or one with values
$ht = @{Name = 'jeff'; count = 3; 'Sample Entry' = 'This is a sample.' }
#a hash table is its own object
$ht | Get-Member
#listing
$ht

cls

#add an element
$ht.Add('Version', '5.1')
$ht

#reference elements using dotted notation
$ht.Name
$ht.count
#this is an alternate name.
#useful if the key has spaces

$ht['Version']
$ht['Sample Entry']
#or use the key
$ht.item('name')
cls
#change an element
#using the ++ operator
$ht.count++
$ht.count
#assign a new value
$ht.count = 10
$ht.count

$ht['name'] = 'roy g. biv'

#list keys
$ht.keys

#list values
$ht.Values

#remove an element
$ht.remove('version')

$ht
#clear completely
$ht.Clear()
$ht.keys

cls

#hash tables can store anything
#you don't need to use ; to separate. PowerShell detects
#multi-line definitions

$ht = @{
    Name     = 'jeff'
    count    = 3
    ps       = Get-Process -Id $pid
    services = Get-CimInstance win32_service
    nested   = @{foo = 'bar'; company = 'Pluralsight'; color = 'green' }
}


$ht
#use dotted notation
$ht.services[0..4]
$ht.ps
$ht.ps.path
$ht.nested
$ht.nested.company
$ht.nested.color = 'red'
$ht.nested

$ht
cls

#ordered hash tables
#hash tables are unordered
$k = [ordered]@{First = 100; Second = 'Foo'; Third = 'Bar' }
$k
#technically a different object
$k | Get-Member

cls

#but use the same
$k.first
$k.first = 10
$k

cls

$v = New-Object -TypeName PSObject -Property $k
$v

#or define the object from the start using a hashtable
#and the [PSCustomObject] type accelerator

$obj = [PSCustomObject]@{
    Name         = $env:username
    Computername = $env:computername
    Version      = $PSVersionTable.PSVersion
    LuckyNumber  = Get-Random -Minimum 1 -Maximum 1000
    PS           = [PSCustomObject]@{ID = $pid; Edition = $PSEdition; Profile = $Profile }
}

$obj
$obj.ps
$obj | Get-Member

help about_Hash_Tables

cls
