<!--
 Copyright (c) 2011-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., 
 Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

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

# Terracotta Big Memory Max Server

Use this template to provision Terracotta Big Memory Max 4.x Server.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* Terracotta 4.x Server

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new Terracotta Big Memory Max Server
* Installing latest fixes
* Configuration of:
  * License
  * JVM memory
  * TC config
* Building docker images for 10.x releases

## Provisioning of new server instance

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

Provision `default` instance of Terracotta Big Memory Max Server 4.3 server with all latest fixes,
listening on default ports 9000 and 9988 (jmx), with 512mb of memory:

```bash
sagcc exec templates composite apply sag-tc-server nodes=dev1 \
  um.memory.max=512 \
  repo.product=webMethods-10.5 \
  repo.fix=Empower \
  --sync-job --wait 360
```

## Creating a new stack with Terracotta Big Memory Max Server layer using Web UI

Consult [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui)
for additional information about using Stacks UI.

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select TC-SERVER layer definition
  * Select product and fix repositories
  * Select exactly one node on which to provision Terracotta Big Memory Max Server
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor

