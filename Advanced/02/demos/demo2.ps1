#powershell host vs pipeline

Return "This is a walk-through demo file"

#The Host vs the Pipeline
$host

"apple"
Write-Output "apple"
write-host "apple"

#we'll cover Get-Member in the next module
"apple" | Get-Member
write-output "apple" | Get-Member
Write-Host "apple" | Get-Member

#Using Write-Host
help Write-Host
Write-Host "A is for Apple" -foregroundcolor red

#mostly just let command write to the pipeline

#Using Read-Host
#you can assign values directly
$Name = "Jeff"
$Name
# Or you can prompt
$name = Read-Host "Enter a service name"
#gsv is an alias for Get-Service
gsv $name

#normal output is a string, but you can create a secure string
$pw = Read-Host "Enter the password" -AsSecureString
$pw
#here's how you might use it. I'm not running the command, just showing the syntax
'New-ADUser -Name "Pat Rabbit" -SamAccountName prabbit -AccountPassword $pw -ChangePasswordAtLogon $True'
#normally, you'll run Get-Credential

# You are more likely to use Read-Host when scripting
# read the help for Read-Host
cls

#demo-streams.ps1