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

# Creating webMethods database on Miscrosoft SQL Server

With this template you can create user, database, and webMethods database schemas on Miscrosoft SQL Server. By default, the template installs the Database Component Configurator and the database scripts for all products, and it creates database schemas for all database components.

If you do not require to install database schemas for all products, remove the database scripts and the respective database components for the unrequired products. The following table maps the products to their database scripts, database component lists, and database actions for creating schemas:

Product | Database Script | Database Component List | Database Action for Creating Schemas
--------------------|----------|---------------------|------------------
webMethods Optimize  |OBEcdc  |  db.OBE.components | schemas.OBE
webMethods Business Rules | WOKcdc|  db.WOK.components | schemas.WOK
webMethods Trading Networks | TNScdc  |  db.TNS.components | schemas.TNS
My webMethods Server | MWScdc| db.MWS.components | schemas.MWS
webMethods B2B Cloud  |  B2BcloudCdc| db.B2Bcloud.components | schemas.B2Bcloud
webMethods Active Transfer | MATcdc | db.MAT.components | schemas.MAT
webMethods OneData |  ODEcdc | db.ODE.components | schemas.ODE
webMethods Integration Server and webMethods Microservices Runtime | PIEcdc | db.PIE.components | schemas.PIE
Integration Server | PIEEmbeddedCdc| Not applicable (N/A) | N/A
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
>NOTE: The database action for creating schemas for Optimizie will not be executed when the database component list is empty.
2. Remove the database script for Optimize by removing `OBEcdc` under `db.product.scripts:`

## Requirements

None.

### Supported Software AG releases

* Command Central 10.5 and higher
* Database Component Configurator 10.5 and higher
* webMethods database schemas for products version 9.8 and higher

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of Microsoft SQL Server database
* Docker Engine 17.09 and higher

## Running as a standalone Composite Template

To install Database Component Configurator 10.5 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create all database components schemas with user `sa` and password `MaNaGe123`:

```bash
sagcc exec templates composite apply sag-db-sqlserver \
  db.version=10.5 repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.host=sqlserver db.admin.username=sa db.admin.password=MaNaGe123 \
  db.name=webm db.username=webm db.password=webm \
  --sync-job --wait 360
```

To install Database Component Configurator 10.5 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create all database components schemas without API Gateway with user `sa` and password `MaNaGe123`:

```bash
sagcc exec templates composite apply sag-db-sqlserver \
  db.version=latest repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.host=sqlserver db.admin.username=sa db.admin.password=MaNaGe123 \
  db.name=webm db.username=webm db.password=webm \
  db.YAI.components=[] \
  db.product.scripts=[DatabaseComponentConfigurator,OBEcdc,WOKcdc,TNScdc,MWScdc,B2BCloudCdc,MATcdc,ODEcdc, \
  PIEcdc,PIEEmbeddedCdc,PIEMobileCdc,WMNcdc,WPEcdc,WSTcdc] \
  --sync-job --wait 360
```


## Using for local development and testing on Docker platforms

1. Launch the Command Central container from the root folder of the following project:

```bash
docker-compose up -d cc
```

2. Launch the [Miscrosoft SQL Server on Linux for Docker Engine](https://hub.docker.com/r/microsoft/mssql-server-linux/) container:

```bash
docker-compose -f templates/sag-db-sqlserver/docker-compose.yml up -d sqlserver
```

3. Provision `sag-db-sqlserver` template and run tests:

```bash
CC_ENV=sqlserver ./provisionw sag-db-sqlserver
```

If the test is successful, the test output contains `TEST SUCCESSFUL`.

You can now use this database for creating instances of webMethods products (for example, Integration Server and My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:wm:sqlserver://sqlserver:1433;databaseName=webm
db.username=webm
db.password=webm
db.type=sqlserver
```

The properties are pre-set in `environments/sqlserver/env.properties` file and you can use them by poiting to the environment name, for example:

```bash
CC_ENV=sqlserver ./provisionw sag-optimize-analysis
```
