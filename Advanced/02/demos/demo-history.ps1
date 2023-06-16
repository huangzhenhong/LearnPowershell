# Navigating previous commands arrow keys
Return "This is a walk-through demo file"

Get-History | more
#history count
$MaximumHistoryCount

#has an alias of h
h

help Get-History
get-history -Count 1
#you only need to type enough of the parameter so
#PowerShell knows what you mean
h -c 5

#Invoke-History
help Invoke-History
Get-Alias -Definition Invoke-History

h 10
r 10

#demo up/down arrows live
cls

#there is more we can do with History using the PSReadline module

#demo-psreadline.ps1