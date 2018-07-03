# Bootstrapping Platform Manager on remote Windows machines

With this template you can install Platform Manager (SPM) on remote
Windows hosts using the native Windows remoting protocol, which eliminates the
requirement to have SSH access.

## Requirements

### Supported Software AG releases

* Command Central 10.2 or higher
* Platform Manager 9.12 or higher

### System requirements for the target Windows machines

* Windows 7 or higher
* PowerShell version 5.0 or higher
* DotNet 4.5 or higher (used to unzip)
* The remote connection user account must have Administrator privileges
* WinRM service must be running
* The memory used by PowerShell should be at the 2GB limit or more

Run the following commands from the PowerShell window as Administrator to ensure that the WinRM service is running and the PowerShell memory is set properly:

```powershell
PS> Enable-PSRemoting -SkipNetworkProfileCheck
PS> Set-Item WSMan:\localhost\Shell\MaxMemoryPerShellMB 2048
```

### System requirements for the Command Central machine

* Windows 7 of higher
* PowerShell version 5.0 or higher
* DotNet 4.5 or higher ( used for unzip )
* Must have Command Central bootstrap installer for Windows (.zip) saved in the `CC_HOME\profiles\CCE\data\installers` folder. Verify by running this command:

```bash
sagcc list provisioning bootstrap installers platform=w64
```

## Running as a standalone Composite Template

Bootstrap remote Windows machines on host1 and host2 with version 10.2 of Platform Manager into the C:\SoftwareAG2
installation directory on port 8292. The remote connection user account is the `sagadmin` account, which
has administrative privileges on host1 and host2. The list of hosts should be in the form of a YAML list, that is ["host1","host2"]

```bash
sagcc exec templates composite apply sag-spm-boot-winrm nodes=["host1","host2"] \
  cc.installer=cc-def-10.2-fix1-w64.zip \
  install.dir=C:\\SoftwareaAG2 \
  spm.port=8292 \
  os.username=sagadmin os.password=**** \
  --sync-job --wait 600
```

## Adding a Windows infrastructure layer to a stack

Create a new stack with version "10.2" and alias "Dev02" and provision the Windows infrastructure layer to host1 and host2:

```bash
sagcc create stacks alias=Dev02 release=10.2
sagcc create stacks Dev02 layers alias=WindowsInfra layerType=INFRA-REMOTE-WINDOWS nodes=host1,host2 \
  cc.installer=cc-def-10.2-fix1-w64.zip \
  install.dir=C:\\SoftwareaAG2 \
  spm.port=8292 \
  os.username=sagadmin os.password=**** \
  --sync-job --wait 600
```

See [sag-cc-layer-defs](../sag-cc-layer-defs/template.yaml) for details about the `INFRA-REMOTE-WINDOWS` layer type definition.

## Using the template from the Command Central Stacks user interface

1. In Command Central, open the Stacks interface.
2. Add a new stack.
3. In the new stack, Add layer > New nodes.
  a. Select the INFRA-REMOTE-WINDOWS layer definition.
  b. Select the Microsoft Windows x86-64 operating system and a corresponding bootstrap installer.
  c. Specify the required parameters, such as:
    * os.username - the username of the remote connection account
    * os.password - the password of the remote connection account
    * nodes - one or more host names
    * install.dir - the remote installation directory
  d. Finish the wizard
4. Wait until the provisioning job completes. You can monitor the job from the Jobs view.
