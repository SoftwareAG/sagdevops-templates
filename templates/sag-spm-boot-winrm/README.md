# Bootstrapping Platform Manager on remote Windows machines

This template allow to install Platform Manager (SPM) on remote
Windows hosts using native Windows remoting protocol, eliminating the
requirement to have SSH access.

## Requirements

### Supported Software AG releases

* Command Central 10.2 or later
* Platform Manager 9.12 or later

### System requirements for the target Windows machines

* Windows 2007 or later
* Powershell version 5.0 or higher
* DotNet 4.5 or higher ( used for unzip )
* The connecting user account must have Administrator privileges
* WinRM service must be enabled
* Memory used by powershell should be at 2GB limit or more

Run these commands from the powershell window as Administrator to ensure the last two requirements:

```powershell
PS> Enable-PSRemoting -SkipNetworkProfileCheck
PS> Set-Item WSMan:\localhost\Shell\MaxMemoryPerShellMB 2048
```

### System requirements for Command Central machine

* Windows 2007 of later
* Powershell version 5.0 or higher
* DotNet 4.5 or higher ( used for unzip )
* Must have Command Central bootstrap installer for Windows (.zip) saved in `CC_HOME\profiles\CCE\data\installers` folder. Verify by running:

```bash
sagcc list provisioning bootstrap installers platform=w64
```

## Running as a standalone Composite Template

Bootstrap remote Windows machines on host1 and host2 with 10.2 version of SPM into C:\SoftwareAG2
installation directory on port 8292. The remote connection is done using `sagadmin` user account that
has administrative privileges on host1 and host2. List of hosts should be given as yaml list i.e. ["host1","host2"]

```bash
sagcc exec templates composite apply sag-spm-boot-winrm nodes=["host1","host2"] \
  cc.installer=cc-def-10.2-fix1-w64.zip \
  install.dir=C:\\SoftwareaAG2 \
  spm.port=8292 \
  os.username=sagadmin os.password=**** \
  skip.runtime.validation=true \
  --sync-job --wait 600
```

> NOTE: SSH validation must be skipped via `skip.runtime.validation=true`

## Adding Windows Infrastructure layer to a Stack

Create a new 10.2 Dev02 stack and provision Windows infrastructure layer onto host1 and host2:

```bash
sagcc create stacks alias=Dev02 release=10.2
sagcc create stacks Dev02 layers alias=WindowsInfra layerType=INFRA-REMOTE-WINDOWS nodes=host1,host2 \
  cc.installer=cc-def-10.2-fix1-w64.zip \
  install.dir=C:\\SoftwareaAG2 \
  spm.port=8292 \
  os.username=sagadmin os.password=**** \
  skip.runtime.validation=true \
  --sync-job --wait 600
```

> NOTE: SSH validation must be skipped via `skip.runtime.validation=true`

## Using from Stacks UI

* Open Stacks UI
* Add new stack
* Add layer > New nodes
  * Select INFRA-REMOTE-WINDOWS layer definition
  * Choose Microsoft Windows x86-64 operating system and a corresponding Bootsrapper
  * Provide required parameters such as
    * os.username - remote access account
    * os.password - the account password
    * nodes - one or more host names
    * install.dir - remote installation directory
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor
