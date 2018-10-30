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

# Optimize Analytic Engine

> STATUS: INCUBATING

Use this template to install Optimize Analytic Engine 10.1 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* Optimize Analytic Engine 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning Optimize Analytic Engine version 10.1 or higher
* Installing Optimize Analytic Engine latest fixes
* Adding basic Optimize Analytic Engine configuration

## Example how to run the composite template

```bash
sagcc exec templates composite apply sag-optimize-analysis nodes=optimize \
    repo.product=optimize repo.fix=Empower \
    --sync-job --wait 360
```

## Local development and testing using Docker

### With SQL Server database

Provision [SQL Server](../sag-db-sqlserver) container and schemas

Provision Optimize:

```bash
CC_ENV=sqlserver ./provisionw sag-optimize-analysis
```
