# demo PSReadline tab completion

Return "This is a walk-through demo file"

Find-Module PSReadLine
Get-Module PSReadLine

#need version 2.1.0 or later
Install-Module PSReadline -force
Remove-module PSReadline
Import-module PSreadline

Get-Module PSReadLine

#set the prediction source
Get-PSReadLineOption
#this would need to be set in your profile script
Set-PSReadLineOption -PredictionSource History

# configure the selection color
Get-PSReadLineOption
#I'm going to make it more noticeable
Set-PSReadLineOption -Colors @{InlinePrediction = "$([char]27)[4;38;5;189m"}

cls

#demo live
# tab completion
# demo history search with Ctrl+R
# demo new command prediction feature
# https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/

#back to slides