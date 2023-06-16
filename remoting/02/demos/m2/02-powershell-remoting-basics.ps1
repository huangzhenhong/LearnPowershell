#Windows PowerShell Remoting Basics
# References:

# PowerShell Remoting Documents on Learn.Microsoft.Com - aka.ms/psremote-mb

Start-Process "https://aka.ms/psremote-mb"

# Enabling Windows PowerShell remoting

# Attempt running remote command

Invoke-Command -ComputerName DC01 -ScriptBlock {Get-Service}
    # Will Produce Error

# Enable Remoting on Remote System
# Logon to Remote System

Enable-PSRemoting

# Re-Attempt running remote command
Invoke-Command -ComputerName DC01 -ScriptBlock {Get-Service}

# Disable Windows PowerShell remoting
Disable-PSRemoting

