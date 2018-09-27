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

# Infrastructure Data Collector UI on My webMethods Server

Use this template to provision Infrastructure Data Collector UI on My webMethods Server 10.1 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.1 or higher
* Infrastructure Data Collector UI 10.1 and higher
* My webMethods Server 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new Infrastructure Data Collector UI on top of existing My webMethods Server instance
* Installing latest fixes

## Running as a composite template

Provision an instance of [My webMethods Server](../sag-mws-server/) first.

Provision Infrastructure Data Collector UI onto the My webMethods Server instance running on node alias `dev1`:

 ```bash
 sagcc exec templates composite apply sag-mws-infradcui nodes=dev1 \
    mws.instance.name=default \
    repo.product=products-10.1 repo.fix=fixes-10.1 \
    --sync-job --wait 360
```
