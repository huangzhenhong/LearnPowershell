Return "This is a demo script file"

#region Alternatives

#create a sample file
# cd \work
#see if you can follow the pipeline
1..5 | foreach { Get-Date | Out-File "secret-$_.dat"}
dir .\secret*.dat

#this is technically an option
#using $psitem instead of $_
dir .\secret*.dat | foreach {$psitem.Attributes+="Hidden"}
#need -Force to show hidden
dir .\secret*.dat -force

#I would stick to this
dir .\secret*.dat -force | foreach {$_.Attributes-="Hidden"}
dir *.dat
cls

#endregion

#region expanding properties

# Don't do this
#this is the wrong way to use ForEach-Object
dir -file
dir -file | foreach {$_.name}

#We used to use this technique in VBScript.
#this is still thinking about parsing text and not working with objects.

#the PowerShell way -writing an object with a single property
dir -file | Select Name

#expanding to a list
dir -file | Select -expandproperty Name | Out-file work.txt
get-content .\work.txt

#this is an easier way once you understand the PowerShell paradigm
# (dir -file).name

cls

#endregion

