<#
.SYNOPSIS
    Gets the extended Properties of files.
.DESCRIPTION
    Gets following extended properties of files in a specified directory
                              - OriginalFilename
                              - FileName
							  - FileDescription
                              - ProductName
                              - Comments
                              - CompanyName
                              - FileVersion
                              - FileVersionUpdated
                              - ProductVersion
                              - Language
                              - CreationTime
                              - Length
               
.PARAMETER Path
    Specifies a path to one locations. If the path includes escape characters, enclose it in single
    quotation marks. Single quotation marks tell Windows PowerShell not to 
    interpret any characters as escape sequences.
.PARAMETER Type
    Specifies a file type of the files. Like *.exe, *.dll etc.                  
               
.EXAMPLE
    C:\PS> Get-FileProperties -path C:\windows\System32 -type *.exe
.EXAMPLE
    C:\PS> Get-FileProperties | where-object {$_.Language -notmatch "^English"}
.EXAMPLE
    C:\PS> Get-FileProperties
               
.NOTES
    Author: Jan Tiedemann
    Date:   08.08.2017   
    Verson: 1.1
#>
# Requires -Version 3.0
function Get-FileProperties {

    Param(
        [parameter(Mandatory = $false, Position = 0, HelpMessage = "Path to search in ")] [string]$path = "$env:windir\system32",
        [ValidateSet('*', '*.exe', '*.dll')] [string]$type = "exe",
        [parameter(Mandatory = $false, Position = 1)] [switch]$recurse
    )
        
    try {
        Update-TypeData -TypeName System.Io.FileInfo -MemberType ScriptProperty -MemberName FileVersionUpdated -ErrorAction SilentlyContinue -Value {
            New-Object System.Version -ArgumentList @(
                $this.VersionInfo.FileMajorPart
                $this.VersionInfo.FileMinorPart
                $this.VersionInfo.FileBuildPart
                $this.VersionInfo.FilePrivatePart
            )
        }
    }
    Finally { }
    
    if ($recurse) {
        $mydlls = Get-ChildItem -Path $path -Filter $type -File -Recurse
    }
    else {
        $mydlls = Get-ChildItem -Path $path -Filter $type -File
    }
    ForEach ($dll in $mydlls) {
        $Object = New-Object PSObject -Property @{            
            OriginalFilename   = $dll.VersionInfo.OriginalFilename
            FileName           = $dll.VersionInfo.FileName
            FileDescription    = $dll.VersionInfo.FileDescription
            ProductName        = $dll.VersionInfo.ProductName
            Comments           = $dll.VersionInfo.Comments
            CompanyName        = $dll.VersionInfo.CompanyName
            FileVersionUpdated = $dll.FileVersionUpdated
            FileVersion        = $dll.VersionInfo.FileVersion
            ProductVersion     = $dll.VersionInfo.ProductVersion
            Language           = $dll.VersionInfo.Language
            CreationTime       = $dll.CreationTime
            Size               = $dll.Length
        }
        $Object
    } 
}