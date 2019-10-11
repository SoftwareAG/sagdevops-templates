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

You can remove one or more product database scripts from the template if you do not require to install them. If you remove a database script from the product list, you should also set the components for this database script to empty list. The following table maps the database scripts  to their product and database components: 

Database Script  |  Product | Database Component Property ID
--------------------|----------|---------------------------------------
OBEcdc              | Optimize |                         db.OBE.components
WOKcdc              | BusinessRules |                    db.WOK.components
TNScdc              | TradingNetworks |                  db.TNS.components
MWScdc              | MyWebmethodsServer |               db.MWS.components
B2BcloudCdc         | B2B Cloud |                        db.B2Bcloud.components
MATcdc              | Active Transfer |                  db.MAT.components
ODEcdc              | One Data |                         db.ODE.components
PIEcdc              | Integration Server and MSC |       db.PIE.components
PIEEmbeddedCdc      | Integration Server |               -
PIEMobileCdc        | Integration Server Mobile Support |db.PIEMobile.components
WMNcdc              | Monitor |                          db.WMN.components
WPEcdc              | Process Engine |                   db.WPE.components
WSTcdc              | Cloud Streams |                    db.WST.components
YAIcdc              | API Gateway |                      db.YAI.components



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

To install Database Component Configurator 10.5 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create all database components schemas with user `sa` with password `MaNaGe123`:

```bash
sagcc exec templates composite apply sag-db-sqlserver \
  db.version=10.5 repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.host=sqlserver db.admin.username=sa db.admin.password=MaNaGe123 \
  db.name=webm db.username=webm db.password=webm \
  --sync-job --wait 360
```

To install Database Component Configurator 10.5 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create all database components schemas without API Gateway  with user `sa` and password `MaNaGe123`:

```bash
sagcc exec templates composite apply sag-db-mysql \
  db.version=latest repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.host=sqlserver db.admin.username=sa db.admin.password=MaNaGe123 \
  db.name=webm db.username=webm db.password=webm \
  db.YAI.components=[] \
  db.product.scripts=[DatabaseComponentConfigurator, OBEcdc, WOKcdc, TNScdc, MWScdc, B2BCloudCdc, MATcdc, ODEcdc, PIEcdc, PIEEmbeddedCdc, PIEMobileCdc, WMNcdc, WPEcdc, WSTcdc] \
  --sync-job --wait 360
```


## Using for local development and testing on Docker platforms

Launch the Command Central container from the root folder of this project:

```bash
docker-compose up -d cc
```

Launch the [Miscrosoft SQL Server on Linux for Docker Engine](https://hub.docker.com/r/microsoft/mssql-server-linux/) container:

```bash
docker-compose -f templates/sag-db-sqlserver/docker-compose.yml up -d sqlserver
```

Provision sag-db-sqlserver template and run tests:

```bash
CC_ENV=sqlserver ./provisionw sag-db-sqlserver
```

If the test is successful, the test ouptut contains `TEST SUCCESSFUL`.
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
