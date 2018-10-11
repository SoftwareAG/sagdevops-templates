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

> STATUS: INCUBATING

Use this template to provision and maintain Integration Server stateless cluster

## Requirements

### Supported Software AG releases

* Integration Server 9.8 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.
All supported Database servers.

### Supported use cases

* Provisioning of new 9.8 or higher single server environment with database
* Provisioning of new 9.8 or higher cluster environment
* Installing latest fixes and support patches
* Configuration of:
  * License
  * JVM memory
  * Primary, diagnostics and JMX ports

## Provisioning of new Cluster

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

Provision `default` instance of Integration Server 10.1 with all latest fixes onto `dev1` and `dev2` nodes,
connected to an Oracle database, listening on default ports 5555, 9999 and 8094 (jmx), with 512mb of memory:

```bash
sagcc exec templates composite apply sag-is-server nodes=dev1,dev2 \
  is.memory.max=512 \
  db.type=oracle db.name=webm db.username=webm db.password=**** \
  db.url="jdbc:wm:oracle://oracledb:1521;SID=XE" \
  repo.product=webMethods-10.1 \
  repo.fix=Empower \
  --sync-job --wait 360
```

## Creating a new stack with Integration Cluster layer using Web UI

Consult [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui)
for additional information about using Stacks UI.

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select `IS-SERVER` layer definition
  * Select product and fix repositories
  * Select one or more nodes on which to provision Integration Server
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor

## Local development and testing using Docker

### With SQL Server database

Provision [SQL Server](../sag-db-sqlserver) container and schemas

Provision My webMethods Server:

```bash
CC_ENV=sqlserver ./provisionw sag-is-cluster
```
