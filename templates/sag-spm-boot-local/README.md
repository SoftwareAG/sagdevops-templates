# Bootstrapping Platform Manager on Command Central host

This template allows to install Platform Manager (SPM) on
the same host as Command Central. Normally this is used
for development purposes only.

> IMPORTANT: Using this template with Command Central 10.1 has significant limitations. See below for details.

## Requirements

### Supported Software AG releases

* Command Central 10.1 (with limitations), 10.2 or later
* Platform Manager 9.8 or later

### Supported platforms

* All platforms for which Command Central bootstrap installers are available for download from Empower

### System requirements for Command Central machine

* Must have Command Central bootstrap installer for the target platform saved in `CC_HOME\profiles\CCE\data\installers` folder. Verify by running:

```bash
sagcc list provisioning bootstrap installers
```

* IMPORTANT: If you use Command Central 10.1 then `local` SPM MUST be running on non-default HTTP/S ports so that you can use default 8092/8093 ports for the new local installation. If your Command Central SPM is configured with default ports, change them to non-default ports.

## Running as a standalone Composite Template on Windows

Bootstrap SPM 10.1 into `C:/SoftwareAG/dev1` installation directory listening on port 8192 on
local Windows box:

```bash
sagcc exec templates composite apply sag-spm-boot-local node=dev1 \
  cc.installer=cc-def-10.1-fix9-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8192 \
  --sync-job --wait 360
```

> IMPORTANT: If you use Command Central 10.1 then use default port 8092 and node alias as `%HOSTNAME%`. Also you have to monitor the job completion with a separate command:

```bash
sagcc exec templates composite apply sag-spm-boot-local node=%HOSTNAME% \
  cc.installer=cc-def-10.1-fix9-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8092
sagcc list jobmanager jobs <jobIdFromAboveCommand> --wait 360 -e DONE
```

## Adding Local Infrastructure layer to a Stack using CLI

Create a new 10.1 Dev01 stack and provision Local infrastructure layer on Windows:

```bash
sagcc create stacks alias=Dev01 release=10.1
sagcc create stacks Dev01 layers alias=LocalInfra layerType=INFRA-LOCAL node=dev1 \
  cc.installer=cc-def-10.1-fix8-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8192 \
  --sync-job --wait 360
```

> IMPORTANT: If you use Command Central 10.1 then use default port 8092 and node alias as `%HOSTNAME%`. Also you have to monitor the job completion with a separate command:

```bash
sagcc create stacks alias=Dev01 release=10.1
sagcc create stacks Dev01 layers alias=LocalInfra layerType=INFRA-LOCAL node=%HOSTNAME% \
  cc.installer=cc-def-10.1-fix8-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8092
sagcc list jobmanager jobs <jobIdFromAboveCommand> --wait 360 -e DONE
```

See [sag-cc-layer-defs](../sag-cc-layer-defs/template.yaml) for `INFRA-LOCAL` layer type definition.

## Creating a new Stack with Local infrastructure layer using Web UI

* Open Stacks UI
* Add new stack
* Add layer > New nodes
  * Select INFRA-LOCAL layer definition
  * Choose the operating system matching your Command Central host and available bootstrap installer for it
  * Provide required parameters such as
    * install.dir - installation directory on Command Central host
    * spm.port - SPM HTTP port number
    * node - node alias for the local installation
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor
