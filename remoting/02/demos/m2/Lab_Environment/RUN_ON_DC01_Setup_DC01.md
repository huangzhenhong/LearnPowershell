# Setup Commands for DC01

**Important** Complete this entire script on DC01 **BEFORE** configuring the other two clients.

**Note: These commands assume you are using the IP addresses laid out in these scripts and assigned to each client. If you have a different subnet configuration, you will need to modify commands accordingly**



## Set IP Addresss

**NOTE: You will need to use the Subnet and network information on your network**

### Run command to verify current configuration and determine InterfaceIndex
**If you have multiple network interfaces, choose the one on the network you are building your lab on**

```powershell

    Get-NetIPConfiguration
    
    Get-NetIPConfiguration | New-NetIPAddress -IPAddress 192.168.68.10 -PrefixLength 24 -DefaultGateway 192.168.68.1
```


### Run if you only have one network interface to set DNS Server

    ```powershell

    Get-NetIPConfiguration | set-DNSClientServerAddress -ServerAddresses 8.8.8.8

    ```

### Run if you have multiple network interfaces

**NOTE: Change -InterFaceIndex to the interface on your lab network**

```powershell

    Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses 8.8.8.8
    
    Get-NetIPConfiguration

```

## Test Name Resolution

```powershell
    Test-NetConnection microsoft.com
```

## Test Network Connectivity

```powershell
    Test-NetConnection 8.8.8.8
```

## Set New Name

```powershell
    Rename-Computer -NewName DC01
```

## Restart Server

```powershell
    Restart-computer -Force
```

## Install ADDS Role and Mgt Tools

```powershell
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

    Import-Module ADDSDeployment
```

### Install a new AD Forest
    
```powershell

Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "default" `
    -DomainName "psdemo.co" `
    -DomainNetbiosName "psdemo" `
    -ForestMode "default" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true

    Restart-computer


```

## Configure DNS Records
    
```powershell
    Get-DnsServerZone -ComputerName DC01
```

## Create DNS Records for all servers

```powershell
    #Create DNS Records for lab computers
    Add-DnsServerResourceRecordA -Name DC01 -ZoneName psdemo.local -IPv4Address 192.168.68.10
    Add-DnsServerResourceRecordA -Name Client01 -ZoneName psdemo.local -IPv4Address 192.168.68.20
    Add-DnsServerResourceRecordA -Name Server01 -ZoneName psdemo.local -IPv4Address 192.168.68.30
    
    Get-DnsServerResourceRecord -ZoneName psdemo.co -rrtype A

```