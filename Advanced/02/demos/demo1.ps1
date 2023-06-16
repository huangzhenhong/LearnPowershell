#powershell commands and history

Return "This is a walk-through demo file"

#what version am I running
$PSVersionTable

#region Get-Command
Get-Command

Get-Command -CommandType cmdlet,function

#get a command by part of the name
Get-Command -name *disk*
cls

#refine the command
Get-Command -name *disk -CommandType cmdlet,function
cls

#PowerShell commands follow a verb-noun naming convention

Get-Verb | more

Get-Command -Verb Mount

#this automatically eliminates applications since they don't know
#about Nouns and Verbs
Get-Command -noun DiskImage

#wild cards are allowed
Get-Command -noun disk*
Get-Command -noun disk* -verb get

help get-disk -Examples
Get-Disk

cls

#endregion

# demo-alias.ps1
