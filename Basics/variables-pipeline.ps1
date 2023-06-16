Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#pipeline variable
#Advanced content for special use-cases
#This is a one-line command.

#pv is an alias for pipelineVariable

1..10 | ForEach-Object -PipelineVariable a { $_ } |
ForEach-Object -pv b { $_ * $a } |
Select-Object @{Name = 'Value'; Expression = { $a } },
@{Name = 'Square'; Expression = { $b } },
@{Name = 'Cubed'; Expression = { $b * $a } }


#pipeline variables don't exist outside of the pipeline
Get-Variable a, b

#this could have been broken down into multiple steps
#I'm using language elements you may not have learned yet.

$a = 1..10
$b = $a | ForEach-Object { $_ * $_ }

for ($i = 0; $i -lt $b.count; $i++) {
    $b[$i] | Select-Object @{Name = 'Value'; Expression = { $a[$i] } },
    @{Name = 'Square'; Expression = { $_ } },
    @{Name = 'Cubed'; Expression = { $_ * $a[$i] } }
}

#PowerShell doesn't mean always using one-line commands

cls

# I have a command which can help identify variables you have created.
# Install-Module PSScriptTools -force
# Get-MyVariable -NoTypeInformation
