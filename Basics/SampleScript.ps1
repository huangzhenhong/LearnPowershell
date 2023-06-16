#requires -version 5.1

<#
This is a demonstration Windows PowerShell script.
It has no error handling and is not intended for production use.
#>

Param([string]$Computername = $env:COMPUTERNAME)

#define an array of hash tables. Each hash table will be splatted
#to Get-CimInstance
$cim = @(
    @{
        ClassName = 'Win32_OperatingSystem'
        Property  = 'Caption', 'InstallDate'
    },
    @{
        ClassName = 'Win32_ComputerSystem'
        Property  = 'TotalPhysicalMemory', 'Manufacturer', 'Model'
    },
    @{
        ClassName = 'Win32_Bios'
        Property  = 'SMBIOSBIOSVersion', 'ReleaseDate'
    },
    @{
        ClassName = 'Win32_LogicalDisk'
        Property  = 'DeviceID', 'Size', 'FreeSpace'
    }
)
<#
define a look-up hashtable. This will be used
to rename CIM property names with something more meaningful
#>
$map = @{
    Caption           = 'OperatingSystem'
    SMBIOSBIOSVersion = 'BIOSVersion'
    ReleaseDate       = 'BIOSReleaseDate'
}

#initialize a hash table for the results
$h = @{Computername = $Computername.ToUpper() }

#pipe the array to
Foreach ($splat in $cim) {
    #get the CIM Data from the computer
    $splat["Computername"] = $Computername
    $get = Get-CimInstance @splat
    #if the result is an array of instances
    #then build a nested entry
    if ($get -is [array]) {
        $nest = @()
        foreach ($result in $get) {
            # Add each result to the the $nest array, selecting the
            # desired properties
            $nest += $Result | Select-Object -Property $splat.Property
        }
        #add the nested entry to the hash table
        $h.Add($splat.ClassName, $nest)
    }
    else {
        foreach ($item in $splat.property) {
            #test if there is a mapping entry
            if ($map.ContainsKey($item)) {
                $key = $map[$item]
            }
            else {
                #use the original property name
                $key = $item
            }
            #create an entry in the hash table for each property and value
            $h.Add($key, $get.$item)
        }
    }
}

#convert the hash table into an object
[PSCustomObject]$h