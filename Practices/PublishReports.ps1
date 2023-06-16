param (
    [string] $SourceFolder = "",
    [string] $TargetReportServerUri = "http://localhost/ReportServer",
    [string] $AgentUserId = "",
    [string] $AgentPassword = "",
    [string] $DataSourceName = "",
    [string] $ConnectionStringRegistry = "",
    [string] $ConnectionStringReport = ""
)

## Data Source List
$DataSource = @('RegistryDataSource.rds','ReportDataSource.rds')
## Data Set List
$DataSet = @('ReportStyle.rsd')
## Import/Export Report
$ImportExportReport = "TransmitListing.rdl"
$ImportExportReportFolder = "ImportExportReports"

$ErrorActionPreference = "Stop"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
Install-Module PowerShellGet -RequiredVersion 2.2.4 -SkipPublisherCheck -Force -Confirm:$false

Install-PackageProvider -Name NuGet -Force

$reportServerUri = $TargetReportServerUri + "/ReportService2010.asmx?wsdl"

if ($SourceFolder -eq "") {
    $SourceFolder = $(Get-Location).Path + "\"
}

if (!$SourceFolder.EndsWith("\")) {
    $SourceFolder = $SourceFolder + "\"
}

Write-Output $now
Write-Output "====================================================================================="
Write-Output "                             Deploying SSRS Reports"
Write-Output "Source Folder: $SourceFolder"
Write-Output "Target Server: $TargetReportServerUri"
Write-Output "Agent User Id: $AgentUserId"
Write-Output "Data Source: $DataSourceName"
Write-Output "====================================================================================="

Write-Output "Marking PSGallery as Trusted..."
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

Write-Output "Installing ReportingServicesTools Module..."
Install-Module -Name ReportingServicesTools -Force -Confirm:$false            

Write-Output "connect to database"
# connect to database
$SQLServer = New-Object System.Data.SqlClient.SqlConnection
$SQLServer.ConnectionString = $ConnectionStringRegistry
$SQLServer.Open()

Write-Output "construct command"
# construct command
$SQLCmd = New-Object System.Data.SqlClient.SqlCommand
$SQLCmd.Connection = $SQLServer
$SQLCmd.CommandText = "SELECT StandardReportId = ROW_NUMBER() OVER (ORDER BY st.StandardName, r.ReportFileName) 
    ,st.StandardName
    ,ReportFileName = r.ReportFileName
FROM Dic.Standard  st 
INNER JOIN Dic.StandardFields sf
ON st.Standard_ID = sf.Standard_ID
AND sf.TablePointer_CommonListOfTypes_GUID = '83190AE3-EFB7-4328-A59C-0C794313602F'
INNER JOIN Reg.Reports r
ON sf.TableGUID = r.Reports_GUID
AND sf.TableGUID_Revision = r.Revision
INNER JOIN Reg.ReportsListOfTypes rlot
ON r.Type_ReportsListOfTypes_ID = rlot.ReportsListOfTypes_ID
WHERE r.IsDeleted = 0 
AND sf.IsDeleted = 0 
ORDER BY st.StandardName, r.ReportFileName"

Write-Output "fetch all results"
# fetch all results
$ReportDS = New-Object System.Data.DataSet
$SQLadapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SQLadapter.SelectCommand = $SQLCmd
$SQLadapter.Fill($ReportDS)

$Password = ConvertTo-SecureString $AgentPassword -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($AgentUserId, $Password)
$rs = New-WebServiceProxy -Uri $reportServerUri -Credential $Credential -Namespace "SSRS"


####################################
# Create / Upload Data Sources
####################################
$SourceFolderPath =  'DataSourceUp'

#remove Local Dir if exists - want only the freshest reports 
if (Test-Path -Path $SourceFolderPath) {
   Remove-Item $SourceFolderPath -Force -Recurse 
}
#Create Local folder for upload
New-Item -Path $SourceFolderPath -ItemType Directory

$connString = New-Object System.Data.SqlClient.SQLConnectionStringBuilder($ConnectionStringReport);
$UserId = $connString["User ID"];
$DbPassword = $connString["Password"];
$DbPassword = ConvertTo-SecureString $DbPassword -AsPlainText -Force
$DbCredential = New-Object System.Management.Automation.PSCredential ($UserId, $DbPassword)
foreach ($fds in $DataSource) {     
   $SourceFilePath = $SourceFolder + "\" + $fds
   
   if (Test-Path -Path $SourceFilePath) {
      if ($fds -eq "RegistryDataSource.rds") {
        New-RsDataSource -RsFolder "/" -Name $fds.Replace('.rds','') -Extension 'SQL' -ConnectionString $ConnectionStringRegistry  -CredentialRetrieval 'Store' -DatasourceCredentials $DbCredential -Proxy $rs -Overwrite
      } else {
        New-RsDataSource -RsFolder "/" -Name $fds.Replace('.rds','') -Extension 'SQL' -ConnectionString $ConnectionStringReport  -CredentialRetrieval 'Store' -DatasourceCredentials $DbCredential -Proxy $rs -Overwrite
      }       
    }
}



####################################
# Create / Upload Data Sets
####################################
$SourceFolderPath =  'DataSetUp'

#remove Local Dir if exists - want only the freshest reports 
if (Test-Path -Path $SourceFolderPath) {
   Remove-Item $SourceFolderPath -Force -Recurse 
}
#Create Local folder for upload
New-Item -Path $SourceFolderPath -ItemType Directory
    
foreach ($fds in $DataSet) {    
   $SourceFilePath = $SourceFolder + "\" + $fds

      
   if (Test-Path -Path $SourceFilePath) {
        Copy-Item -Path $SourceFilePath -Destination $SourceFolderPath   
        Write-RsFolderContent -ReportServerUri $TargetReportServerUri -Path $SourceFolderPath -Destination "/" -Verbose -Overwrite

        $dsPath = $fds.Replace('.rsd','')

        $referencedDataSourceName = $rs.GetItemDataSources("/$dsPath");
        $newrdsPath = "/"+$referencedDataSourceName.Name
        if (Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path '/' -Recurse | Where-Object Name -eq $referencedDataSourceName.Name) {
            Set-RsDataSourceReference -ReportServerUri $TargetReportServerUri -Path $rp.Path -DataSourceName $referencedDataSourceName.Name -DataSourcePath $newrdsPath -Verbose
        }
    }
}

$Reports = Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path "/"  | Where-Object TypeName -eq 'DataSet' 
      
foreach($rp in $Reports) {               
    $referencedDataSourceName = $rs.GetItemDataSources($rp.Path);
    $newrdsPath = "/"+$referencedDataSourceName.Name
    if (Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path '/' -Recurse | Where-Object Name -eq $referencedDataSourceName.Name) {
        Set-RsDataSourceReference -ReportServerUri $TargetReportServerUri -Path $rp.Path -DataSourceName $referencedDataSourceName.Name -DataSourcePath $newrdsPath -Verbose
    }   
}


####################################
# Create / Upload Reports
####################################

$PrevFolder =''
$UploadFolderList = @()

foreach ($Row in $ReportDS.Tables.Rows)
{ 
   $StandardReportID = $($Row[0])
   $StandardName = $($Row[1])
   $ReportFileName = $($Row[2])

   $SourceFilePath = $SourceFolder + "\" + $ReportFileName
   
   $SourceFolderPath =  $SourceFolder + "Up_"+ $StandardName

    Write-Output "Uploading " + $ReportFileName + " - Standard: " + $StandardName

   if ($StandardName -ne $PrevFolder){
        $UploadFolderList += $StandardName
        
        #remove Local Dir if exists - want only the freshest reports 
        if (Test-Path -Path $SourceFolderPath) {
           Remove-Item $SourceFolderPath -Force -Recurse 
        }
        #Create Local folder for upload
        New-Item -Path $SourceFolderPath -ItemType Directory
       
        # Create SSRS Folder
        New-RsFolder -ReportServerUri $TargetReportServerUri -Path / -Name $StandardName -Verbose -ErrorAction SilentlyContinue
   }         
   
   if (Test-Path -Path $SourceFilePath) {
     Copy-Item -Path $SourceFilePath -Destination $SourceFolderPath
   }

   if ($ReportFileName.Contains("SummaryBySiteSexClassStatusStage")) {
     $ReportFileName = $ReportFileName.replace("SummaryBySiteSexClassStatusStage", "SummaryBySiteSexClassStatusStageMisc")
     $SourceFilePath = $SourceFolder + "\" + $ReportFileName
     Copy-Item -Path $SourceFilePath -Destination $SourceFolderPath
   }

   $PrevFolder = $StandardName
}

foreach ($uf in $UploadFolderList) {
    $SourceFolderPath =  $SourceFolder + "Up_"+ $uf
    
    if ($uf -ne 'Data Sources' ) {
        $now = Get-Date -Format "yyyy-MM-dd HH:mm"
        Write-Output $now
        Write-Output "====================================================================================="
        Write-Output "                             Deploying $uf"
        Write-Output "====================================================================================="

      
        Write-RsFolderContent -ReportServerUri $TargetReportServerUri -Path $SourceFolderPath -Destination "/$uf" -Verbose -Overwrite
        $Reports = Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path "/$uf"  | Where-Object TypeName -eq 'Report' 
      
        foreach($rp in $Reports) {                   
            $referencedDataSourceName = $rs.GetItemDataSources($rp.Path);
            $newrdsPath = "/"+$referencedDataSourceName.Name
            if (Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path '/' -Recurse | Where-Object Name -eq $referencedDataSourceName.Name) {
                Set-RsDataSourceReference -ReportServerUri $TargetReportServerUri -Path $rp.Path -DataSourceName $referencedDataSourceName.Name -DataSourcePath $newrdsPath -Verbose
            }
            
            $referencedDataSetName = $rs.GetItemReferences($rp.Path,'DataSet');
            $newrsdPath = "/"+$referencedDataSetName.Name
            if (Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path '/' -Recurse | Where-Object Name -eq $referencedDataSetName.Name) {
                Set-RsDataSetReference -ReportServerUri $TargetReportServerUri -Path $rp.Path -DataSetName $referencedDataSetName.Name -DataSetPath $newrsdPath -Verbose
            }
        }
    }
}

####################################
# Create / Upload Import/Export Reports
####################################
New-RsFolder -ReportServerUri $TargetReportServerUri -Path / -Name $ImportExportReportFolder -Verbose -ErrorAction SilentlyContinue
$SourceFilePath = $SourceFolder + "\" + $ImportExportReport
$SourceFolderPath = $SourceFolder + "Up_Others"
$NewFilePath = $SourceFolderPath + "\" + $ImportExportReport
if (Test-Path -Path $SourceFolderPath) {
    Remove-Item $SourceFolderPath -Force -Recurse 
 }
 #Create Local folder for upload
New-Item -Path $SourceFolderPath -ItemType Directory
if (Test-Path -Path $SourceFilePath) {
    Copy-Item -Path $SourceFilePath -Destination $NewFilePath
  }
Write-Output $now
Write-Output "====================================================================================="
Write-Output "                             Deploying $ImportExportReport"
Write-Output "====================================================================================="
Write-RsFolderContent -ReportServerUri $TargetReportServerUri -Path $SourceFolderPath -Destination "/$ImportExportReportFolder" -Verbose -Overwrite
$Reports = Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path "/$ImportExportReportFolder"  | Where-Object TypeName -eq 'Report' 
      
foreach($rp in $Reports) {                   
    $referencedDataSourceName = $rs.GetItemDataSources($rp.Path);
    $newrdsPath = "/"+$referencedDataSourceName.Name
    if (Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path '/' -Recurse | Where-Object Name -eq $referencedDataSourceName.Name) {
        Set-RsDataSourceReference -ReportServerUri $TargetReportServerUri -Path $rp.Path -DataSourceName $referencedDataSourceName.Name -DataSourcePath $newrdsPath -Verbose
    }
    
    $referencedDataSetName = $rs.GetItemReferences($rp.Path,'DataSet');
    $newrsdPath = "/"+$referencedDataSetName.Name
    if (Get-RsCatalogItems -ReportServerUri $TargetReportServerUri -Path '/' -Recurse | Where-Object Name -eq $referencedDataSetName.Name) {
        Set-RsDataSetReference -ReportServerUri $TargetReportServerUri -Path $rp.Path -DataSetName $referencedDataSetName.Name -DataSetPath $newrsdPath -Verbose
    }
}

$now = Get-Date -Format "yyyy-MM-dd HH:mm"
Write-Output $now
