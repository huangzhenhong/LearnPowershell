#requires -version 5.1

<#
This is an alternative function you can use in-place of Get-Member. This file and the
ps1xml file must be in the same folder. Dot-source the script file

PS C:\scripts\> . .\Get-TypeMember.ps1
#>

Function Get-TypeMember {
    <#
    .SYNOPSIS
    Get type member information.
    .DESCRIPTION
    This is an alternative to using Get-Member. Specify a type name to see a simple view of an object's members. The output will only show native members, not those added by PowerShell such as ScriptProperties.
    .PARAMETER Type
    'Specify a .NET type name like DateTime
    .PARAMETER StaticOnly
    Get only static members.
    .PARAMETER MemberType
    Filter for a specific member type. Valid values are Property, Method, Event, and Field.
    .EXAMPLE
    PS C:\> Get-TypeMember DateTime

   Type: System.DateTime

Name                 MemberType ResultType          IsStatic
----                 ---------- ----------          --------
MaxValue             Field      System.DateTime         True
MinValue             Field      System.DateTime         True
Add                  Method     System.DateTime        False
AddDays              Method     System.DateTime        False
AddHours             Method     System.DateTime        False
AddMicroseconds      Method     System.DateTime        False
...
Date                 Property   System.DateTime
Day                  Property   System.Int32
DayOfWeek            Property   System.DayOfWeek
DayOfYear            Property   System.Int32
...
    .EXAMPLE
    PS C:\> Get-TypeMember DateTime -StaticOnly

           Type: System.DateTime

Name            MemberType ResultType      IsStatic
----            ---------- ----------      --------
MaxValue        Field      System.DateTime     True
MinValue        Field      System.DateTime     True
Compare         Method     System.Int32        True
DaysInMonth     Method     System.Int32        True
Equals          Method     System.Boolean      True
FromBinary      Method     System.DateTime     True
...
    .LINK
    Get-Member
    #>
    [cmdletbinding(DefaultParameterSetName = "member")]
    [OutputType('psTypeMember')]
    [Alias('gtm')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Specify a .NET type name like DateTime'
        )]
        [ValidateNotNullOrEmpty()]
        [type]$Type,
        [Parameter(ParameterSetName = "static",HelpMessage = 'Get only static members.')]
        [switch]$StaticOnly,
        [Parameter(ParameterSetName = "member",HelpMessage = "Filter for a specific member type.")]
        [ValidateSet("Property","Method","Event","Field")]
        [string]$MemberType
    )

    if ($StaticOnly) {
        $filter = { -Not $_.IsSpecialName -AND $_.IsStatic }
    }
    elseif ($MemberType) {
        $filter = {-Not $_.IsSpecialName -AND $_.MemberType -eq $MemberType}
    }
    else {
        $filter = { -Not $_.IsSpecialName }
    }
    $type.GetMembers() | Where-Object $filter |
    Select-Object -Property Name, MemberType, FieldType, PropertyType, ReturnType, IsStatic -Unique |
    Sort-Object -Property MemberType, Name |
    ForEach-Object {
        [PSCustomObject]@{
            PSTypeName   = 'psTypeMember'
            Type         = $type.FullName
            Name         = $_.Name
            MemberType   = $_.MemberType
            PropertyType = $_.PropertyType
            ReturnType   = $_.ReturnType
            FieldType    = $_.FieldType
            IsStatic     = $_.IsStatic
        }
    }
}

#load the custom formatting file
Update-FormatData $PSScriptRoot\psTypeMember.format.ps1xml