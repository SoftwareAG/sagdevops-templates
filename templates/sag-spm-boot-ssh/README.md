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
# Bootstrapping Platform Manager on remote UNIX machines

With this template you can install Platform Manager (SPM) on remote
UNIX hosts using the SSH protocol.

## Requirements

### Supported Software AG releases

* Command Central 10.2 Fix2 or later
* Platform Manager 9.8 or later

### Supported platforms

* All UNIX platforms for which you can download Command Central bootstrap installers from Empower.

> NOTE: Windows platforms are NOT supported by this template. See [sag-spm-boot-winrm](../sag-spm-boot-winrm/README.md)

### System requirements for the target UNIX machines

* SSH daemon with SHA1 support enabled
* User account, e.g. sagadmin, with remote SSH login privileges and write access to the target installation directory
* Credentials for the remote connection user account, e.g. sagadmin, are configured. See [sag-cc-creds-dev](../sag-cc-creds-dev/README.md).

### System requirements for the Command Central machine

* All supported UNIX or Windows operating systems
* Must have Command Central bootstrap installer for the target UNIX platform (*.sh file) saved in `CC_HOME\profiles\CCE\data\installers` folder. Verify by running:

```bash
sagcc list provisioning bootstrap installers
```

## Running as a standalone Composite Template

* Bootstraps SPM 10.2 into the `/home/vmtest/sag102` installation directory, listening on port 8292 on
the bgcctbp11 and bgcctbp12 Linux hosts. The remote SSH connection is authenticated with the pre-configured
`VMTEST` username/password credentials.

```bash
sagcc exec templates composite apply sag-spm-boot-ssh nodes=bgcctbp11,bgcctbp12 \
  cc.installer=cc-def-10.2-fix1-lnxamd64.sh \
  install.dir=/home/vmtest/sag102 \
  spm.port=8292 \
  os.credentials.key=VMTEST \
  --sync-job --wait 360
```

* Authenticates the SSH connection using pre-configured `SSH-PRIVATE-KEY` credentials that point
to the `~/.ssh/id_rsa` private key on the Command Central (CCE) host for the user account that runs CCE, e.g. sagadmin:

```bash
sagcc exec templates composite apply sag-spm-boot-ssh nodes=bgcctbp11,bgcctbp12 \
  cc.installer=cc-def-10.2-fix1-lnxamd64.sh \
  install.dir=/home/vmtest/sag103 \
  spm.port=8392 \
  os.credentials.key=SSH-PRIVATE-KEY \
  --sync-job --wait 360
```

## Adding UNIX infrastructure layer to a stack using CLI

Creates a new 10.1 Dev01 stack and provisions the LinuxInfra infrastructure layer onto host1 and host2.
The SSH connection from CCE to host1 and host2 is authenticated through the sagadmin user account private key.

```bash
sagcc create stacks alias=Dev01 release=10.1
sagcc create stacks Dev01 layers alias=LinuxInfra layerType=INFRA-REMOTE-UNIX nodes=host1,host2 \
  cc.installer=cc-def-10.1-fix8-lnxadm64.sh \
  install.dir=/opt/softwareag \
  os.credentials.key=SSH-PRIVATE-KEY \
  --sync-job --wait 360
```

See [sag-cc-layer-defs](../sag-cc-layer-defs/template.yaml) for `INFRA-REMOTE-UNIX` layer type definition.

## Creating a new Stack with UNIX infrastructure layer using Web UI

* Open the Stacks UI
* Add a new stack
* Add layer > New nodes
  * Select INFRA-REMOTE-UNIX layer definition
  * Choose the operating system (except Microsoft Windows x86-64), and a corresponding bootstrap installer
  * Provide required parameters, such as
    * os.credentials.key - SSH credentials
    * nodes - one or more host names
    * install.dir - remote installation directory
  * Finish the wizard
* Wait until the provisioning jobs complete. Monitor the jobs from the Jobs view.

## Local testing

You can test the template against `localhost` on a Linux or Mac OS machine if it has SSHD running.
For example:

```bash
sagcc exec templates composite apply sag-spm-boot-ssh nodes=`hostname` \
  cc.installer=cc-def-10.2-fix1-osx.sh \
  install.dir=$HOME/test4 \
  spm.port=8492 \
  os.credentials.key=SSH-PRIVATE-KEY \
  --sync-job --wait 600
```
