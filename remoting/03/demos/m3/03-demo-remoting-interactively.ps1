# Windows PowerShell Remoting Options
# Demo: Running commands “locally” with Enter-PSSession
# Help resources for Remote Sessions

help about_PSSessions

help Enter-PSSession

# Set Demo Variable for remote computer

$localComputer = "localhost"
$ComputerName = "DC01"

# Interactive remote session
Enter-PSSession -ComputerName $localComputer

    # Commands on Remote System
        Get-ComputerInfo -Property CsName,CSProcessors,CsTotalPhysicalMemory

        Exit-PSSession
   # Back on client

# Interactive remote session
Enter-PSSession -ComputerName $ComputerName

    # Commands on Remote System

        Get-ComputerInfo -Property CsName,CSProcessors,CsTotalPhysicalMemory

        $ComputerInfo = Get-ComputerInfo -Property CsName,CSProcessors,CsTotalPhysicalMemory

        $ComputerInfo

        Exit-PSSession
   # Back on client
   
   $ComputerInfo

   Get-PSSession


    