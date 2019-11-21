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


# Internal Data Store

Use this template to provision and maintain Internal Data Store.

## Requirements and limitations

Prepare your environment for Internal Data Store installation by completing the required steps, provided in the [Installing Software AG Products](https://documentation.softwareag.com/webmethods/wmsuites/wmsuite10-3/SysReqs_Installation_and_Upgrade/compendium/index.html#page/install-upgrade-webhelp%2Fto-prepare_machines_10.html%23wwconnect_header) 
help on Empower. 

### Supported Software AG releases

* Internal Data Store 10.1 and higher
* Command Central 10.3 or higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.1 and higher environments
* Installing latest fixes
* Configurations for clustered environment with two or three nodes

## Using the template to provision a new Internal Data Store server or clustered environment

For information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To provision Internal Data Store 10.3 on a single node with all latest fixes:

```bash

sagcc exec templates composite apply sag-internaldatastore nodes=node \
  repo.product=products-10.3 \
  repo.fix=fixes-10.3 \
  --sync-job --wait 360
```

To provision Internal Data Store 10.3 on two nodes with all latest fixes and configure the nodes in a cluster:

```bash

sagcc exec templates composite apply sag-internaldatastore nodes=[dev1,dev2] \
  repo.product=products-10.3 \
  repo.fix=fixes-10.3 \
  --sync-job --wait 360
```
