# Setup Commands for Client01

# Set IP Addresss
# NOTE: You will need to use the Subnet and network information on your network

# Run command to verify current configuration and determine InterfaceIndex
# If you have multiple network interfaces, choose the one on the network you are building your lab on

Get-NetIPConfiguration

Get-NetIPConfiguration | New-NetIPAddress -IPAddress xx.xx.xx.20 -PrefixLength 24 -DefaultGateway <YourDefaultGateway>

# Run if you only have one network interface to set DNS Server

Get-NetIPConfiguration | set-DNSClientServerAddress -ServerAddresses XX.XX.XX.10

# Run if you have multiple network interfaces
# NOTE: Change -InterFaceIndex to the interface on your lab network

Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses XX.XX.XX.10

Get-NetIPConfiguration

# Test Name Resolution
Test-NetConnection microsoft.com

# Test Network Connectivity
Test-NetConnection 8.8.8.8

# Test Network Connectivity and Name Resolution to DC01
Test-Netconnection DC01

# Rename Computer
Rename-Computer -NewName DC01

# Enter credentials for Administrator account on DC01

$credential = Get-Credential

# Add computer to domain

Add-Computer -DomainName psdemo.local -credential $credential -Restart

## Verify you can logon to Client01
