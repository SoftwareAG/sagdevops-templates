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
# Creating webMethods database on Miscrosoft SQL Server

> STATUS: INCUBATING

With this template you can create user, database, and webMethods database schemas on a Microsoft SQL Server. If you need any other database components, you can extend the template with similar inline templates, is-db-scripts.

## Requirements

None.

### Supported Software AG releases

* Command Central 10.4 and higher
* Database Component Configurator 10.4 and higher
* webMethods database schemas for products version 9.8 and higher

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of Microsoft SQL Server database
* Docker Engine 17.09 and higher

## Running as a standalone Composite Template

To install Database Component Configurator 10.4 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create database components for Integration Server 10.4 and My webMethods Server 10.4 with user `sa` with password `MaNaGe123`:

```bash
sagcc exec templates composite apply sag-db-sqlserver-104-sample
  db.version=10.4.0.0 repo.product=products-10.4 repo.fix=fixes-10.4 nodes=local
  db.host=sqlserver db.admin.username=sa db.admin.password=MaNaGe123
  db.name=webm db.username=webm db.password=webm
  db.products=[IS,MWS,OPTI,PRE]
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

Launch the Command Central container from the root folder of this project:

```bash
docker-compose up -d cc
```

Launch the [Miscrosoft SQL Server on Linux for Docker Engine](https://hub.docker.com/r/microsoft/mssql-server-linux/) container:

```bash
docker-compose -f templates/sag-db-sqlserver-104-sample/docker-compose.yml up -d sqlserver
```

Provision sag-db-sqlserver template and run tests:

```bash
CC_ENV=sqlserver ./provisionw sag-db-sqlserver-104-sample
```

Successful test output looks like this:

```bash
...
**********************************************************************************
* Installed components                                                           *
*                                                                                *
* The release number shown for each database component reflects the last         *
* release in which a change was made to that database component.                 *
* Therefore all database components will not show the same release number.       *
*                                                                                *
* code  version    name                           data                           *
* ISC   10.3       ISCoreAudit                                                   *
* ISI   10.3.fix1  ISInternal                                                    *
* DSL   7.1        DistributedLocking                                            *
* IDR   7.1        DocumentHistory                                               *
* XRF   8.2.2      CrossReference                                                *
* CCS   9.0.1      CentralConfiguration                                          *
* MWS   10.2       MywebMethodsServer                                            *
* OPM   9.0.1      OperationManagement                                           *
* OPT_AE_ANL 85         Optimize Analytic Engine Analysis Component                                *
* ANL   10.1       Analysis                                                      *
* DBM   9.9        DatabaseManagement                                            *
* DTP   9.0.1      DataPurge                                                     *
* PRA   10.3       ProcessAudit                                                  *
* OPT_AE_PTR 50         Optimize Analytic Engine Process Tracker Component                                *
* PTR   10.1       ProcessTracker                                                *
* CTR   8.0        ComponentTracker                                              *
* PRE   10.4       ProcessEngine                                                 *

The expected values were successfully retrieved after 1 call within 2 seconds.
TEST SUCCESSFUL

```

You can now use this database for creating instances of webMethods products (Integration Server, My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:wm:sqlserver://sqlserver:1433;databaseName=webm
db.username=webm
db.password=webm
db.type=sqlserver
```

The properties are preset in `environments/sqlserver/env.properties` file and you can use them by poiting to the environment name. For example:

```bash
CC_ENV=sqlserver ./provisionw sag-optimize-analysis
```
