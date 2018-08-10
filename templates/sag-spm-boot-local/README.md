<!-- Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors

   SPDX-License-Identifier: Apache-2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and

     limitations under the License.                                                  

-->
# Bootstrapping Platform Manager on Command Central host

With this template you can install Platform Manager (SPM) on the same host as Command Central. This is normally used only for development purposes.

> IMPORTANT: Using this template with Command Central 10.1 has significant limitations. Limitation details are provided below.

## Requirements and limitations

### Supported Software AG releases

* Command Central 10.2 or higher
* Command Central 10.1 with limitations
* Platform Manager 9.8 or higher

### Supported platforms

All supported Windows and UNIX platforms.

### System requirements for Command Central machine

Command Central bootstrap installer for the target platform stored in `CC_HOME\profiles\CCE\data\installers`. Verify by running:

```bash
sagcc list provisioning bootstrap installers
```

* IMPORTANT: For Command Central 10.1, the `local` SPM **must** be running on non-default HTTP(S) ports, so that you can use the default 8092/8093 ports for the new local installation. If your local SPM is configured with default ports, change them to non-default ports.

## Running as a standalone Composite Template on Windows

To bootstrap an SPM 10.1 that listens on port 8192 into the `C:/SoftwareAG/dev1` installation directory, type the following in a local Command Prompt window:

```bash
sagcc exec templates composite apply sag-spm-boot-local node=dev1 \
  cc.installer=cc-def-10.1-fix9-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8192 \
  --sync-job --wait 360
```

> IMPORTANT: If you are using Command Central 10.1, use the default port, 8092, and specify the node alias as `%HOSTNAME%`. In addition, monitor the job completion with the following command:

```bash
sagcc exec templates composite apply sag-spm-boot-local node=%HOSTNAME% \
  cc.installer=cc-def-10.1-fix9-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8092
sagcc list jobmanager jobs <jobIdFromAboveCommand> --wait 360 -e DONE
```

## Adding Local Infrastructure layer to a Stack using CLI

To create a new 10.1 Dev01 stack and provision Local infrastructure layer on Windows:

```bash
sagcc create stacks alias=Dev01 release=10.1
sagcc create stacks Dev01 layers alias=LocalInfra layerType=INFRA-LOCAL node=dev1 \
  cc.installer=cc-def-10.1-fix8-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8192 \
  --sync-job --wait 360
```

> IMPORTANT: If you are using Command Central 10.1, use the default port, 8092, and specify the node alias as `%HOSTNAME%`. In addition, monitor the job completion with the following command:

```bash
sagcc create stacks alias=Dev01 release=10.1
sagcc create stacks Dev01 layers alias=LocalInfra layerType=INFRA-LOCAL node=%HOSTNAME% \
  cc.installer=cc-def-10.1-fix8-w64.zip \
  install.dir=C:/SoftwareAG/dev1 \
  spm.port=8092
sagcc list jobmanager jobs <jobIdFromAboveCommand> --wait 360 -e DONE
```

For more information, see [sag-cc-layer-defs](../sag-cc-layer-defs/template.yaml) for `INFRA-LOCAL` layer type definition.

## Creating a new stack with local infrastructure layer from the Command Central Stacks user interface

1. In Command Central, open the Stacks interface.
2. Add a new stack.
3. In the new stack, Add layer > New nodes.
  * Select the INFRA-LOCAL layer definition
  * Select the operating system that matches your Command Central host and a corresponding bootstrap installer.
  * Specify the required parameters, such as:
    * install.dir - the installation directory on the Command Central host
    * spm.port - the SPM HTTP port number
    * node - the node alias for the local installation
  * Finish the wizard
4. Wait until provision jobs completes. Use Jobs view to monitor
