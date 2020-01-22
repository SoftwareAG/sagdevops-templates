<!--
 Copyright (c) 2011-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc.,
 Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

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

# Creating webMethods database on DB2

With this template you can create webMethods database schemas on DB2. By default, the template installs the Database Component Configurator and the database scripts for all products, and it creates database schemas for all database components.

If you do not require to install database schemas for all products, remove the database scripts and the respective database components for the unrequired products. The following table maps the products to their database scripts, database component lists, and database actions for creating schemas:

Product | Database Script | Database Component List | Database Action for Creating Schemas
--------------------|----------|---------------------|------------------
webMethods Optimize  |OBEcdc  |  db.OBE.components | schemas.OBE
webMethods Business Rules | WOKcdc|  db.WOK.components | schemas.WOK
webMethods Trading Networks | TNScdc  |  db.TNS.components | schemas.TNS
My webMethods Server | MWScdc| db.MWS.components | schemas.MWS
webMethods Integration Server and webMethods Microservices Runtime | PIEcdc | db.PIE.components | schemas.PIE
Integration Server | PIEEmbeddedCdc | Not available (N/A) | N/A
Integration Server and Mobile Support | PIEMobileCdc | db.PIEMobile.components | schemas.PIEMobile
webMethods Monitor | WMNcdc | db.WMN.components | schemas.WMN
webMethods Process Engine | WPEcdc| db.WPE.components | schemas.WPE
webMethods CloudStreams Server | WSTcdc| db.WST.components | schemas.WST
webMethods API Gateway | YAIcdc| db.YAI.components | schemas.YAI

For example, to remove the database scripts and database components for webMethods Optimize:
1. Replace the database component list for Optimize with an empty list by replacing the following lines from the template:
```bash
 db.OBE.components: 
      - Analysis
      - ProcessTracker
      - DataPurge
      - DatabaseManagement
      - OperationManagement
      - ProcessAudit
```
With:
```bash
db.OBE.components: []
```
>NOTE: The database action for creating schemas for Optimize will not be executed when the database component list is empty.
2. Remove the database script for Optimize by removing `OBEcdc` under `db.product.scripts:`

## Requirements

None.

### Supported Software AG releases

* Command Central 10.5 and higher
* Database Component Configurator 10.5 and higher
* webMethods database schemas for products version 10.5 and higher

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of DB2 database   
* Docker Engine 17.09 and higher

## Running as a standalone Composite Template

To install Database Component Configurator 10.5 on the Command Central node with alias `local`, and create storage and all database components schemas for database `webm` and a database user named `webm` with password `webm`:

```bash
sagcc exec templates composite apply sag-db-db2 \
  db.version=10.5 repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.host=db2 \
  db.name=webm db.username=webm db.password=webm db.tablespace.dir="\home\sag\db2\webm" \
  db.admin.username=db2inst1 db.admin.password=db2inst1 \
  --sync-job --wait 360
```

To install Database Component Configurator 10.5 on the Command Central node with alias `local`, and create all database components schemas without API Gateway for already created database `webm` and a database user named `webm` with password `webm`:

```bash
sagcc exec templates composite apply sag-db-db2 \
  db.version=latest repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.name=webm db.username=webm db.password=webm db.tablespace.dir="\home\sag\db2\webm" \
  db.admin.username=db2inst1 db.admin.password=db2inst1 \
  db.YAI.components=[] \
  db.product.scripts=[DatabaseComponentConfigurator,OBEcdc,WOKcdc,TNScdc,MWScdc,PIEcdc, \             
  PIEEmbeddedCdc,PIEMobileCdc,WMNcdc,WPEcdc,WSTcdc] \
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

1. Launch the [DB2](https://hub.docker.com/r/ibmcom/db2) container:

```bash
docker-compose -f templates/sag-db-db2/docker-compose.yml up -d db2
```

2. Provision `sag-db-db2` template to create database components and run tests:

```bash
CC_TAG=10.5 TAG=10.5 CC_ENV=db2 ./provisionw sag-db-db2
```

If the test is successful, the test output contains `TEST SUCCESSFUL`.

You can now use this database for creating instances of webMethods products (for example, Integration Server and My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:wm:db2://db2:50000;databaseName=webm
db.username=webm
db.password=webm
db.type=db2luw
db.name=webm
```

The properties are pre-set in `environments/db2/env.properties` file and you can use them by pointing to the environment name, for example:

```bash
CC_ENV=db2 ./provisionw sag-optimize-analysis
```
