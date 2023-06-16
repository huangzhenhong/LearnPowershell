# Setup Commands for Client01

# Set IP Addresss
# NOTE: You will need to use the Subnet and network information on your network

# Run command to verify current configuration and determine InterfaceIndex
# If you have multiple network interfaces, choose the one on the network you are building your lab on

Get-NetIPConfiguration

Get-NetIPConfiguration | New-NetIPAddress -IPAddress 192.168.68.30 -PrefixLength 24 -DefaultGateway 192.168.68.1

# Run if you only have one network interface to set DNS Server

Get-NetIPConfiguration | set-DNSClientServerAddress -ServerAddresses 8.8.8.8

# Run if you have multiple network interfaces
# NOTE: Change -InterFaceIndex to the interface on your lab network

Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses 8.8.8.8

Get-NetIPConfiguration

# Test Name Resolution
Test-NetConnection microsoft.com

# Test Network Connectivity
Test-NetConnection 8.8.8.8

#Set New Name
Rename-Computer -NewName DC01

# Restart Server
Restart-computer -Force
