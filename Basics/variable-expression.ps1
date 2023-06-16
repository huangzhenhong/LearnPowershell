Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

# Variable expansion
# $name = "Jeff"
#"Hello, my name is $name."
#but not this
# 'Hello, my name is $name.'

#simple
$PSEdition
Write-Host "I am running the $PSEdition edition of PowerShell." -ForegroundColor green

#this does not work
Write-Host 'I am running the $PSEdition edition of PowerShell.' -ForegroundColor green

#complex expansion
$svc = Get-Service WinRM
$svc | Select-Object name, status
$t = Get-Date -Format T
Write-Host "[$t] The $svc.name service is currently $svc.status" -ForegroundColor cyan
#use a subexpression
Write-Host "[$t] The $($svc.name) service is currently $($svc.status)" -ForegroundColor cyan

cls
# How to use SubExpressions
# this is more to illustrate the concept than a practical piece of PowerShell code
$random = 25
#try to use meaningful variable names

Get-Service | Get-Random -Count $random |
ForEach-Object {
    if ($_.Status -eq 'running') {
        $ForeColor = 'green'
    }
    elseif ($_.status -eq 'stopped') {
        $ForeColor = 'red'
    }
    else {
        $ForeColor = 'yellow'
    }
    Write-Host "[$(Get-Date -Format T)] The $($_.name) service is currently $($_.status)" -ForegroundColor $ForeColor
}

cls

#don't do this, even though it will work.
#this is poor PowerShell and what we had to do in VBScript.
#code like this indicates the user hasn't grasped the PowerShell paradigm
$t = Get-Date -Format T
"[$t] The " + $svc.name + ' service is currently ' + $svc.status

cls
