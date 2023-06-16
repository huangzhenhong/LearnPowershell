# Windows PowerShell Remoting Options
# Demo: Remoting without Configuration
# Note: Only a subset of PowerShell cmdlets do not support -computername

#Help

help -Name about_Remote

# open Windows PowerShell as Administrator

Start-Process PowerShell -Verb runAs 

# View commands with -computername that don't use WinRM or create a session
Get-Command | Where-Object {$_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}

# Event logs

Get-EventLog -ComputerName LocalHost -LogName Security -InstanceId 4624,4625 -Newest 5 | 
format-table -Property MachineName,Time,InstanceId,Message

Get-EventLog -ComputerName Client01 -LogName Security -InstanceId 4624,4625 -Newest 5 | 
format-table -Property MachineName,Time,InstanceId,Message 

Get-EventLog -ComputerName DC01,Client01,localhost -LogName Security -InstanceId 4624,4625 -Newest 5 | 
 format-table -Property MachineName,Time,InstanceId,Message 















# Using Variables for -ComputerName value
$ComputerNames = "dc01","Client01","Localhost","dc01","Client01","Localhost","dc01","Client01","Localhost","dc01","Client01","Localhost","dc01","Client01","Localhost"
Get-EventLog -ComputerName $ComputerNames -LogName Security -InstanceId 4624,4625 -Newest 5 | 
 format-table -Property MachineName,Time,InstanceId,Message 

# Extra Commands

   

# Open Visual Studio code as Administrator
Start-Process vscode -Verb RunAs
