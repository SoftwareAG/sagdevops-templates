
param
(
	[Parameter(Mandatory)]
	[ValidateNotNullOrEmpty()]
	[string[]]$Computername,
	
	[Parameter(Mandatory)]
	[ValidateNotNullOrEmpty()]
	[string]$PlainCredentials,
	
	[string]$RemoteTempPath="c:\temp",
	
	[string]$RemoteInstallPath="c:\softwareag\",
	
	[string]$LocalInstallerZip="C:\softwareag\profiles\CCE\data\installers\cc-def-10.2-milestone-w64.zip",
	
	[string]$AdministratorPassword="manage",
	
	[string]$HttpPort="8092",
	
	[string]$HttpsPort="8093",
	
	[switch]$AcceptLicense
)

$command=""
$computers=$computername.split(",")
$InstallerArgs=" -d $RemoteInstallPath -p $AdministratorPassword -s $HttpPort -S $HttpsPort -D SPM"
if($AcceptLicense){
	$installerArgs+=" --accept-license"
}
if(($PlainCredentials.Length -gt 0 ) -and ($PlainCredentials.Contains(":"))){
	$ruser=$PlainCredentials.Split(":")[0]
	$rpass=$PlainCredentials.Split(":")[1]
	$srpass=ConvertTo-SecureString -AsPlainText -Force -string $rpass
	$credentials=new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $ruser,$srpass
}else{
	Write-Host "Wrong format username:pass"
	exit 1
}
foreach ($comp in $computers.Replace("[","").Replace("]","").Replace("`"","")){
	start-job -ScriptBlock { 
		param($comp,$cred,$srz,$rtp,$rip,$iar) 
		$s=New-PSSession -ComputerName $comp -Credential $cred
		if(!$s){
			write-error "Can not connect to host: $comp"
			exit 2
		}
		"Processing computer $comp"
		"Creating temp folder $rtp"
		Invoke-Command -Session $s -ScriptBlock {param($rtp)
			if(!(Test-Path -path $rtp)){
				new-item -ItemType directory -Path $rtp
			}else{
				"folder $RemoteTempPath already exists"
			}
		} -ArgumentList $rtp
		if(Invoke-Command -Session $s -ScriptBlock {param($rtp,$dsz) Test-Path -Path "$rtp\$dsz" } -ArgumentList $rtp,$srz.split("\")[-1]){
			"Zip already exists"
		}else{
			"Uploading zipfile $srz"
			get-date | select DateTime
			Copy-Item -Path $srz -Destination c:\temp -ToSession $s
			"Upload finished"
			get-date | select DateTime
		}
		"Unzipping in $rtp"
		Invoke-Command -Session $s -ScriptBlock {param($srz,$rtp)
#			Add-Type -AssemblyName "system.io.compression.filesystem"
			$instzip=$srz.split("\")[-1]
			if(Test-Path -Path $rtp\$instzip){
#				[io.compression.zipfile]::ExtractToDirectory("$rtp\$instzip",$rtp)
				Expand-Archive -Path "$rtp\$instzip" -DestinationPath $rtp -Force
			}else{
				"Installer zipfile $instzip does not exist in folder $rtp"
			}
		} -ArgumentList $srz,$rtp
		"Installing SPM"
		Invoke-Command -Session $s -ScriptBlock {param($rtp,$iar)
			set-location $rtp
			$installer=$(Get-ChildItem cc*bat | Select-Object -Property Name).Name
			if ( ($installer) -and (Test-Path "$installer" )){
				"Running installer with options: $iar"
				Invoke-Expression "$rtp\$installer $iar"
			}
			else{
				"Installer script $installer does not exist"
			}
		} -ArgumentList $rtp,$iar
		get-pssession | Remove-PSSession
	} -ArgumentList $comp,$credentials,$LocalInstallerZip,$RemoteTempPath,$RemoteInstallPath,$InstallerArgs
}
get-job|wait-job
get-job|receive-job
get-job|remove-job




param
(
	[Parameter(Mandatory)]
	[ValidateNotNullOrEmpty()]
	[string[]]$Computername,
	
	[Parameter(Mandatory)]
	[ValidateNotNullOrEmpty()]
	[string]$PlainCredentials,
	
	[string]$RemoteTempPath,
	
	[string]$RemoteInstallPath,
	
	[string]$LocalInstallerZip,
	
	[string]$AdministratorPassword,
	
	[string]$HttpPort,
	
	[string]$HttpsPort,
	
	[switch]$AcceptLicense
)

$command=""
#$computers=$computername.split(",")
$InstallerArgs=" -d $RemoteInstallPath -p $AdministratorPassword -s $HttpPort -S $HttpsPort -D SPM"
if($AcceptLicense){
	$installerArgs+=" --accept-license"
}
if(($PlainCredentials.Length -gt 0 ) -and ($PlainCredentials.Contains(":"))){
	$ruser=$PlainCredentials.Split(":")[0]
	$rpass=$PlainCredentials.Split(":")[1]
	$srpass=ConvertTo-SecureString -AsPlainText -Force -string $rpass
	$credentials=new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $ruser,$srpass
}else{
	Write-Host "Wrong format username:pass"
	exit 1
}
foreach ($comp in $computername){
	start-job -ScriptBlock { 
		param($comp,$cred,$srz,$rtp,$rip,$iar) 
		$s=New-PSSession -ComputerName $comp -Credential $cred
		if(!$s){
			write-error "Can not connect to host: $comp"
			exit 2
		}
		"Processing computer $comp"
		"Creating temp folder $rtp"
		Invoke-Command -Session $s -ScriptBlock {param($rtp)
			if(!(Test-Path -path $rtp)){
				new-item -ItemType directory -Path $rtp
			}else{
				"folder $RemoteTempPath already exists"
			}
		} -ArgumentList $rtp
		if(Invoke-Command -Session $s -ScriptBlock {param($rtp,$dsz) Test-Path -Path "$rtp\$dsz" } -ArgumentList $rtp,$srz.split("\")[-1]){
			"Zip already exists"
		}else{
			"Uploading zipfile $srz"
			get-date | select DateTime
			Copy-Item -Path $srz -Destination c:\temp -ToSession $s
			"Upload finished"
			get-date | select DateTime
		}
		"Unzipping in $rtp"
		Invoke-Command -Session $s -ScriptBlock {param($srz,$rtp)
#			Add-Type -AssemblyName "system.io.compression.filesystem"
			$instzip=$srz.split("\")[-1]
			if(Test-Path -Path $rtp\$instzip){
#				[io.compression.zipfile]::ExtractToDirectory("$rtp\$instzip",$rtp)
				Expand-Archive -Path "$rtp\$instzip" -DestinationPath $rtp -Force
			}else{
				"Installer zipfile $instzip does not exist in folder $rtp"
			}
		} -ArgumentList $srz,$rtp
		"Installing SPM"
		Invoke-Command -Session $s -ScriptBlock {param($rtp,$iar)
			set-location $rtp
			$installer=$(Get-ChildItem cc*bat | Select-Object -Property Name).Name
			if ( ($installer) -and (Test-Path "$installer" )){
				"Running installer with options: $iar"
				Invoke-Expression "$rtp\$installer $iar"
			}
			else{
				"Installer script $installer does not exist"
			}
		} -ArgumentList $rtp,$iar
		get-pssession | Remove-PSSession
	} -ArgumentList $comp,$credentials,$LocalInstallerZip,$RemoteTempPath,$RemoteInstallPath,$InstallerArgs
}
get-job|wait-job
get-job|receive-job
get-job|remove-job



