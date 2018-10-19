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

# Connecting Command Central to an Existing Platform Manager

With this template you can connect Command Central to an existing Platform Manager (SPM) installation on a remote machine.

## Requirements and limitations

### Supported Software AG releases

* Command Central 10.1 and higher
* Platform Manager 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template on Windows

To connect Command Central to an existing Platform Manager listening on port 8092 on remote1 host:

```bash
sagcc exec templates composite apply sag-spm-connect hosts=remote1 \
  spm.port=8092 \
  --sync-job --wait 360
```

> IMPORTANT: If you use Command Central 10.1 you have to monitor the job completion with a separate command:

```bash
sagcc exec templates composite apply sag-spm-connect hosts=remote1 \
  spm.port=8092
sagcc list jobmanager jobs <jobIdFromAboveCommand> --wait 360 -e DONE
```

## Creating and connecting a new stack to the remote infrastructure layer in the web user interface

1. Open Command Central > Stacks
2. Add a new stack
3. To add a new layer, layer > Existing nodes
  * Select the INFRA-EXISTING layer definition
  * Enter a name and description for the layer
  * Select the target machine fromthe list of nodes
After you finish the wizard, Command Central creates the new infrastructure layer.
