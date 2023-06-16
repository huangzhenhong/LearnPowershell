# Windows PowerShell Remoting Options
# Demo: Gathering information with CIM and WMI

# Using WMI and CIM Information
    # Using WMI and CIM to find physical memory information
    # Remember: -class and -classname parameter values are the same for most WMI/CIM calls
    # General Rule: Use CIM on modern versions of windows; Use WMI for older versions
        Get-WmiObject -List *    
        Get-WmiObject -List *memory*
        Get-WmiObject -class Win32_PhysicalMemory
        
        #CIM
        Get-CimClass -ClassName *memory*
        Get-CimInstance -ClassName Win32_PhysicalMemory
        Get-CimInstance -ClassName Win32_PhysicalMemory | Select Tag,Capacity
        (Get-CimInstance Win32_PhysicalMemory -ComputerName Client01).Capacity
        ((((Get-CimInstance Win32_PhysicalMemory -ComputerName Client01).Capacity | measure -Sum).Sum)/1gb)

    # Help files
    help about_WMI_Cmdlets
    
# Demo: Remoting with New-CimSession
    # Run these commands in Windows PowerShell console as Administrator 

    # Help with New-Cimsession
    help about_CimSession

    # Help for New-CimSession
    Help New-CimSession

    $CimSession = New-CimSession -ComputerName DC01

    # Accessing DNS Client on remote system
    
    Help Get-DNSClientServerAddress

    Get-DNSClientServerAddress -CimSession $cimsession
    
    # Storing CIM Session in variable for use later
    # Using multiple CIM sessions
    $ComputerNames = "dc01","Client01","Localhost","dc01","Client01","Localhost","dc01","Client01","Localhost","dc01","Client01","Localhost","dc01","Client01","Localhost"
    $cimsession = New-CimSession -ComputerName $ComputerNames
    
    Get-DnsClientServerAddress -CimSession $cimsession
    
    Get-DnsClientServerAddress -CimSession $cimsession | Format-Table -RepeatHeader -GroupBy PSComputername

    
