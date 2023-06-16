# Windows PowerShell Remoting Options
# Demo: Remoting with Invoke-Command
    # Run these commands in Windows PowerShell console as Administrator 
    
    # Help with Invoke-Command
    help Invoke-command
    
    
# Variable for -ComputerName value
    $ComputerName = "DC01"
    $Name = "*win*"

# Running get-service on remote system
    Invoke-command -ComputerName $computername -ScriptBlock { get-service -Name $Name | format-table DisplayName,Status,Name }
        #Note: This fails since you cannot pass variables to remote systems

# Passing variable to remote system with Using:
    invoke-command -ComputerName $computername -ScriptBlock { get-service -Name $using:Name | format-table DisplayName,Status,Name }

# More Information on $using in help
    help about_Remote_Variables

# Adding remote computer data to variable
    $data =  invoke-command -ComputerName $computername -ScriptBlock { get-service -Name $using:Name }
    $data | get-member
    # Note: Objects are deserialized - Due to XML conversion, many methods are removed. Properties of object generally remain intact.

    $data | where-object -Property status -Eq "Stopped" | select-object -Property DisplayName,status,machinename

# Running Remote Commands
    $ADUser = "psuser"

    invoke-command -ComputerName $computername -ScriptBlock { Get-ADUser -Identity $using:ADuser | format-list }
        # Because DC01 is a domain controller and has the ADDS tools installed, you can run any of the cmdlets installed.


# Running Scripts
    cd .\M3
    
    code .\get-helpdeskdata.ps1
    .\get-helpdeskdata.ps1
    
    Invoke-Command -FilePath .\get-helpdeskdata.ps1 -ComputerName DC01,client01
