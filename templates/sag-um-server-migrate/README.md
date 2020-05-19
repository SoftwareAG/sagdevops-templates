<!-- Copyright 2013 - 2020 Software AG, Darmstadt, Germany and/or its licensors

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

# Universal Messaging Realm Server Side-by-Side Migration

> STATUS: INCUBATING

Use this template to perform side-by-side migration of a Universal Messaging realm server.

## Requirements

### Supported Software AG releases

* Universal Messaging 10.1 and higher
* Command Central 10.3 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of Universal Messaging 
* Installing latest fixes and support patches
* Side-by-side migration to Universal Messaging version 10.1 or higher
* Configuration of:
  * License
  * JVM memory
  * NHP and JMX ports
  * COMMON-JAVASYSPROPS


## Migration of new server instance

For information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To migrate a `default` instance of Universal Messaging realm 10.1 installed in directory /home/vmtest/sag
to target `default` instance of Universal Messaging realm 10.5 in directory /home/vmtest/sag_10.5 with all latest fixes,
listening on default ports 9000 and 9988 (JMX), with 512 MB of memory:

```bash
sagcc exec templates composite apply sag-um-server-migrate environment.mode=migration \ 
  nodes=dev1 \
  version=10.5 \
  platform=lnxamd64 \
  install.dir=/home/vmtest/sag \
  um.memory.max=512 \
  repo.product=webMethods-10.5 \
  repo.fix=Empower \
  --sync-job --wait 360
```
