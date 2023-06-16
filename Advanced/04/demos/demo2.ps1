Return "This is a demo script file"

#region foreach-object basics

# Help ForEach-Object

1..10 | ForEach-Object { $_ * 2 } | Select-Object -Last 1

1..10 | ForEach-Object { $_ * 2 } | Measure-Object -sum -Average

#hiding the property Property since it isn't used in this example
#can you follow along in your head?

1..100 | ForEach-Object { Get-Random -Minimum 1 -Maximum 100} |
ForEach-Object { $_ * 2 } |
Measure-Object -sum -Average -Maximum -Minimum |
Select-Object -Property * -ExcludeProperty Property,Count

#Foreach-Object has an alias of %
2, 4, 7, 8, 10, 39 | % { $_ / 2 }

cls

#endregion

