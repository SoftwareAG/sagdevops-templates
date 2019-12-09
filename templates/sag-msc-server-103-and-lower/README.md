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

# Microservices Runtime

Use this template to provision and maintain Microservices Runtime

## Requirements

None.

### Supported Software AG releases

* Command Central 10.3 and higher
* Microservices Runtime 10.1 to 10.3

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.1 or 10.3 environments
* Installing latest fixes and support patches
* Configuration of:
  * License
  * JVM memory
  * Primary, diagnostics and JMX ports

## Provisioning of new server instance

For information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To provision a `default` instance of Microservices Runtime 10.1 with all latest fixes, using license key alias `MSC_LIC`,
listening on default ports 5555, 9999 and 8094 (jmx), with 512mb of memory on a managed installation node alias `dev1`:

```bash
sagcc exec templates composite apply sag-msc-server-103-and-lower nodes=dev1 \
  is.memory.max=512 \
  repo.product=webMethods-10.1 \
  repo.fix=Empower \
  is.msc.license.key=MSC_LIC \
  --sync-job --wait 360
```
## Creating a new stack using the web user interface

For information about using stacks and layers, see [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui).

* Open Stacks UI
* Click `(+)` to add a new stack
* Add a new Infrastructure layer
* Add a new Runtime layer
  * Select `MSC-SERVER-103-and-lower` layer definition
  * Select product and fix repositories
  * Select a single node on which to provision Integration Server
  * Review and adjust the optional parameters as required
  * Finish the wizard
* Wait until the provision jobs completes. Use the Jobs view to monitor the job progress.
