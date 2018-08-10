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

With this template you can create user, storage tablespaces and webMethods database components on an Oracle database server.

## Requirements

### Supported Software AG releases

* Command Central 10.1 or higher
* Database Component Configurator 9.10 or higher
* webMethods database components for products 9.8 or higher

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of Oracle database
* Docker Engine 17.09 or higher

## Running as a standalone Composite Template

To install Database Component Configurator 10.1 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create database storage and database components for Integration Server 10.1 and My webMethods Server 10.1 with user `system` and password `oracle`:

```bash
sagcc exec templates composite apply sag-db-oracle
  release=10.1 repo.product=products-10.1 repo.fix=fixes-10.1 nodes=local
  db.host=oracle db.admin.username=system db.admin.password=oracle
  db.name=webm db.username=webm db.password=webm
  db.products=[IS,MWS]
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

To use this template for local development you must first launch the Command Central container. From the root folder of this project run:

```bash
docker-compose up -d cc
```

To launch the [Oracle Database Express Edition 11g Release 2](https://hub.docker.com/r/wnameless/oracle-xe-11g/) container and apply the `sag-db-oracle` template to create a user, storage, and Integration Server, My webMethods Server and BPM database components for the 10.3 release:

```bash
docker-compose -f templates/sag-db-oracle/docker-compose.yml run --rm provision
...
17      Wed Jul 18 17:42:45 UTC 2018    DONE    DONE
```

To verify that the schemas are created successfully:

```bash
docker-compose -f templates/sag-db-oracle/docker-compose.yml run --rm test
...
**********************************
* Executing action
*   Action            : catalog
*   Database          : Oracle
*   URL               : jdbc:wm:oracle://oracle:1521;SID=XE
*   User              : webm
**********************************

**********************************
*      Installed Components      *
**********************************
*   BLZ 10 Blaze   WEBMDATA,WEBMINDX
*   RUL 20 BusinessRules   WEBMDATA,WEBMINDX
*   CCS 27 Central Configuration   WEBMDATA,WEBMINDX
*   XRF 11 CrossReference   WEBMDATA,WEBMINDX
*   DSL 20 DistributedLocking   WEBMDATA,WEBMINDX
*   IDR 10 DocumentHistory   WEBMDATA,WEBMINDX
*   DBO 25 DynamicBusinessOrchestrator   WEBMDATA,WEBMINDX
*   ISC 51 ISCoreAudit   WEBMDATA,WEBMINDX
*   ISI 75 ISInternal   WEBMDATA,WEBMINDX
*   MWS 65 My webMethods Server   WEBMDATA,WEBMINDX
*   OPM 30 Operation Management   WEBMDATA,WEBMINDX
*   PRA 90 ProcessAudit   WEBMDATA,WEBMINDX
*   PRE 95 ProcessEngine   WEBMDATA,WEBMINDX
**********************************

The expected values were successfully retrieved after 1 call within 5 seconds.
```

You can now use this database for creating instances of webMethods products (Integration Server, My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:wm:oracle://oracle:1521;SID=XE
db.username=webm
db.password=webm
db.type=oracle
```
