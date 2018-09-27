###############################################################################
#  Copyright © 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
###############################################################################
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
	
	[string]$LocalInstaller="C:\softwareag\profiles\CCE\data\installers\cc-def-10.2-milestone-w64.zip",
	
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
			"Installer already exists"
		}else{
			"Uploading installer $srz"
			get-date | select DateTime
			Copy-Item -Path $srz -Destination $rtp -ToSession $s
			"Upload finished"
			get-date | select DateTime
		}
		if($srz.EndsWith(".zip")){
			"Unzipping in $rtp"
			Invoke-Command -Session $s -ScriptBlock {param($srz,$rtp)
				$instfile=$srz.split("\")[-1]
				if(Test-Path -Path $rtp\$instfile){
					Expand-Archive -Path "$rtp\$instfile" -DestinationPath $rtp -Force
				}else{
					"Installer file $instfile does not exist in folder $rtp"
				}
			} -ArgumentList $srz,$rtp
		}else{
			"Installer is in exe format"
		}
		"Installing SPM"
		Invoke-Command -Session $s -ScriptBlock {param($rtp,$iar,$srz)
			set-location $rtp
			if($srz.EndsWith(".zip")){
				$installer=$(Get-ChildItem cc-*bat | Select-Object -Property Name).Name
			}else{
				$installer=$srz.split("\")[-1]
			}
			if ( ($installer) -and (Test-Path "$installer" )){
				"Running installer with options: $iar"
				Invoke-Expression "$rtp\$installer $iar"
			}
			else{
				"Installer script $installer does not exist"
			}
		} -ArgumentList $rtp,$iar,$srz
		get-pssession | Remove-PSSession
	} -ArgumentList $comp,$credentials,$LocalInstaller,$RemoteTempPath,$RemoteInstallPath,$InstallerArgs
}
get-job|wait-job
get-job|receive-job
get-job|remove-job
