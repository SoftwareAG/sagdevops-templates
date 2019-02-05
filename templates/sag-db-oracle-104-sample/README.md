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

# Creating webMethods database on Oracle

> STATUS: INCUBATING

With this template you can create user, storage tablespaces and webMethods database components on an Oracle database server. If you need any other database components, you can extend the template with similar inline templates, like is-db-scripts.

## Requirements

None.

### Supported Software AG releases

* Command Central 10.4 and higher
* Database Component Configurator 10.4 and higher
* webMethods database components for products 9.8 and higher

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of Oracle database
* Docker Engine 17.09 and higher

## Running as a standalone Composite Template

To install Database Component Configurator 10.4 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create database storage and database components for Integration Server 10.4 , My webMethods Server 10.4 , Optimize 10.4 and Process Engine 10.4 with user `system` and password `oracle`:

```bash
sagcc exec templates composite apply sag-db-oracle-104-sample
  db.version=10.4.0.0 repo.product=products-10.4 repo.fix=fixes-10.4 nodes=local
  db.host=oracle db.admin.username=system db.admin.password=oracle
  db.name=webm db.username=webm db.password=webm
  db.products=[IS,MWS,OPTI,PRE]
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

Launch the Command Central container from the root folder of this project:

```bash
docker-compose up -d cc
```

Launch the [Oracle Database Express Edition 11g Release 2](https://hub.docker.com/r/wnameless/oracle-xe-11g/) container:

```bash
docker-compose -f templates/sag-db-oracle-104-sample/docker-compose.yml up -d oracle
```

Provision the `sag-db-oracle-104-sample` template to create a user, storage, and Integration Server, My webMethods Server, Optimize and Process Engine database components for the 10.4 release:

```bash
CC_ENV=oracle ./provisionw sag-db-oracle-104-sample
```

Successful output looks like this:

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
* ISC   10.3       ISCoreAudit                    WEBMDATA,WEBMINDX              *
* ISI   10.3.fix1  ISInternal                     WEBMDATA,WEBMINDX              *
* DSL   7.1        DistributedLocking             WEBMDATA,WEBMINDX              *
* IDR   7.1        DocumentHistory                WEBMDATA,WEBMINDX              *
* XRF   8.2.2      CrossReference                 WEBMDATA,WEBMINDX              *
* CCS   9.0.1      CentralConfiguration           WEBMDATA,WEBMINDX              *
* MWS   10.2       MywebMethodsServer             WEBMDATA,WEBMINDX              *
* CTR   8.0        ComponentTracker               WEBMDATA,WEBMINDX              *
* PRA   10.3       ProcessAudit                   WEBMDATA,WEBMINDX              *
* PRE   10.4       ProcessEngine                  WEBMDATA,WEBMINDX              *


The expected values were successfully retrieved after 1 call within 5 seconds.
TEST SUCCESSFUL
```

You can now use this database for creating instances of webMethods products (Integration Server, My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:wm:oracle://oracle:1521;SID=XE
db.username=webm
db.password=webm
db.type=oracle
```

The properties are preset in `environments/oracle/env.properties` file and you can use them by poiting to the environment name. For example:

```bash
CC_ENV=oracle ./provisionw sag-optimize-analysis
```
