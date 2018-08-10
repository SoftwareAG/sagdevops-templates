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
# Ninja demo product

Use this template to provision and migrate Ninja demo product.

## Requirements

### Supported Software AG releases

* SAG internal network
* Ninja 10.1 or higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new environments
* Installing latest fixes and support patches
* In-place upgrades
* Cross-host migrations
* Configuration of:
  * License
  * JVM memory
  * Ports
  * ...

## Running as a composite template

> NOTE: to provision a new 9.8+ node use any of the `sag-spm-*` templates.

Provisions `default` instance of Universal Messaging Realm 10.1 server with all latest fixes,
listening on default ports
9000 and 9988 (jmx), with 512mb of memory:

```bash
sagcc exec templates composite apply sag-ninja-server nodes=node \
  ninja.memory.max=256 \
  repo.product=products \
  repo.fix=fixes \
  --sync-job --wait 600
```

## Creating a new stack with Ninja layer using Web UI

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select NINJA-SERVER layer definition
  * Select product and fix repositories
  * Select exactly one node on which to provision Ninja server
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor

## TODO

* Fix local dev/build on Docker by providing custom repo initialization
