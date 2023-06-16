# Creating Variables
#variable names should be meaningful
$a = 2
$a
$n = "foo"
$n
#this command is part of the PSTeachingTools module
# Install-Module PSTeachingTools -force
$veg = Get-Vegetable c*
$veg

#this is technically possible, or if you need something special
New-Variable -Name ver -Value 1
$ver
New-Variable -Name user -Value "Jeff" -Option ReadOnly
New-Variable -Name pi -Value 3.14 -Option Constant
$user
$pi

#change
$n = "bar"
$n

$ver = 2
$ver

#this will fail because $user was defined as ReadOnly
$user = "Gladys"

#you could use this command
Set-Variable -Name user -Value Gladys -Force -PassThru

#but not constants
Set-Variable pi -Value 1 -Force
#constants can't be removed or recreated

#you can clear variable values
Clear-Variable user -Force
Get-Variable user

cls

# other ways of working with variables
Remove-Variable veg
Get-Variable veg
#but it didn't change the source
Get-Vegetable c*

cls

#some variable tricks and shortcuts
$a = $b = 4
get-variable a,b
$a = 10
$a * $b

$c,$d,$e = Get-Service bits,winrm,spooler
#there's no guarantee results will go in corresponding variables
$c,$d,$e
cls

