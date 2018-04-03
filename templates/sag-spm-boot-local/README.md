# Bootstrapping Platform Manager on Command Central host

This template allows to install Platform Manager (SPM) on
the same host as Command Central. Normally this is used
for development purposes only.

## Requirements

### Supported Software AG releases

* Command Central 10.2 of later
* Platform Manager 9.8 or later

### Supported platforms

* All platforms for which Command Central bootstrap installers are available for download from Empower

### System requirements for Command Central machine

* Must have Command Central bootstrap installer for the target UNIX platform (*.sh file) saved in `CC_HOME\profiles\CCE\data\installers` folder. Verify by running:

```bash
sagcc list provisioning bootstrap installers
```

## Running as a standalone Composite Template

Bootstrap SPM 10.2 into `/home/vmtest/dev1` installation directory listening on port 8192 on
localhost:

```bash
sagcc exec templates composite apply sag-spm-boot-local node=dev1 \
  cc.installer=cc-def-10.2-fix1-lnxamd64.sh \
  install.dir=/Users/me/softwareag/dev1 \
  spm.port=8192 \
  --sync-job --wait 360
```

## Adding UNIX Infrastructure layer to a Stack using CLI

Create a new 10.1 Dev01 stack and provision LinuxInfra infrastructure layer onto host1 and host2.
The SSH connection from CCE to host1 and host2 is authenticated via the sagadmin user account private key.

```bash
sagcc create stacks alias=Dev01 release=10.1
sagcc create stacks Dev01 layers alias=LocalInfra layerType=INFRA-LOCAL node=dev1 \
  cc.installer=cc-def-10.1-fix8-lnxadm64.sh \
  install.dir=/Users/me/softwareag/dev1
  --sync-job --wait 360
```

See [sag-cc-layer-defs](../sag-cc-layer-defs/template.yaml) for `INFRA-REMOTE-UNIX` layer type definition.

## Creating a new Stack with UNIX infrastructure layer using Web UI

* Open Stacks UI
* Add new stack
* Add layer > New nodes
  * Select INFRA-LOCAL layer definition
  * Choose the operating system matching your Command Central host and available bootstrap installer for it
  * Provide required parameters such as
    * node - node alias for the local installation
    * install.dir - installation directory on Command Central host
    * spm.port - SPM HTTP port number
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor
