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

# My webMethods Server

> STATUS: INCUBATING

Use this template to provision My webMethods Server 10.1 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* My webMethods Server 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Local development and testing using Docker

### With SQL Server database

Provision [SQL Server](../sag-db-sqlserver) container and schemas

Provision My webMethods Server:

```bash
CC_ENV=sqlserver ./provisionw sag-mws-server
```
