#these are some of the PSDefaultParameterValues I use.

$PSDefaultParameterValues.Add("Receive-Job:Keep", $True)
$PSDefaultParameterValues.Add("Find-Module:Repository","PSGallery")
$PSDefaultParameterValues.Add("Install-Module:Scope","AllUsers")
$PSDefaultParameterValues.Add("Out-File:Encoding","ASCII")
$PSDefaultParameterValues.Add("Write-Host:ForegroundColor","Cyan")

#you can also use wild-cards
$cred = Get-Credential "company\artd"
#any Active Directory cmdlet like Get-ADUser or New-ADGroup will use this credential
$PSDefaultParameterValues.Add("*-AD*:Credential",$cred)