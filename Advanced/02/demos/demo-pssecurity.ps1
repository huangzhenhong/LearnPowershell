#demo powershell security features
Return "This is a walk-through demo file"

#region alternate credentials

help Get-WinEvent -parameter Credential

$credential = Get-Credential
$credential
Get-WinEvent -ListLog * -ComputerName localhost -Credential $credential

#save a credential
#use bad password
$admin = Get-Credential company\administrator
$admin

Get-WinEvent -ListLog * -ComputerName localhost -Credential $admin
#re-enter
$admin = Get-Credential company\administrator -message "Enter the domain admin credential"
Get-WinEvent -ListLog *powershell* -ComputerName localhost -Credential $admin

cls
#endregion
#region Windows PowerShell log

Get-WinEvent -LogName 'Windows PowerShell' -MaxEvents 10
Get-WinEvent -FilterHashtable @{Logname = 'Windows PowerShell';ID=800} -MaxEvents 1 | Select-Object * | more

cls
#endregion
#region Operational Log

Get-WinEvent -ListLog Microsoft-Windows-PowerShell/Operational
Get-WinEvent Microsoft-Windows-PowerShell/Operational -max 1 | Select-Object * | more 
cls
Get-WinEvent -FilterHashtable @{Logname = 'Microsoft-Windows-PowerShell/Operational';ID=4100} -MaxEvents 5 
| Select-Object -ExpandProperty Message 
|  more

Show-EventLog

cls
#endregion
#region Scriptblock Logging

$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging','HKLM:\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'

Get-Item $regPath

invoke-Command { get-process power*}
Get-WinEvent -FilterHashtable @{Logname = 'Microsoft-Windows-PowerShell/Operational';ID=4104} -MaxEvents 5 | Select-Object -ExpandProperty Message

cls
#endregion
