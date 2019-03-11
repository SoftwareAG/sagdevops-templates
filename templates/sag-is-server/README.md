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

# Integration Server

Use this template to provision and maintain Integration Server

## Requirements

### Supported Software AG releases

* Integration Server 9.8 and higher
* Command Central 10.3 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 9.8 or higher environments
* Installing latest fixes and support patches
* Configuration of:
  * License
  * JVM memory
  * Primary, diagnostics and JMX ports

## Provisioning of new server instance

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

Provision `default` instance of Integration Server 10.1 with all latest fixes, using `IS_LIC` license key alias,
listening on default ports 5555, 9999 and 8094 (jmx), with 512mb of memory, into managed
installation node alias `dev1`:

```bash
sagcc exec templates composite apply sag-is-server nodes=dev1 \
  is.memory.max=512 \
  repo.product=webMethods-10.1 \
  repo.fix=Empower \
  is.integrationserver.license.key=IS_LIC \
  --sync-job --wait 360
```
## Creating a new stack with Integration Server layer using Web UI

Consult [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui)
for additional information about using Stacks UI.

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select `IS-SERVER` layer definition
  * Select product and fix repositories
  * Select exactly one node on which to provision Integration Server
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor
