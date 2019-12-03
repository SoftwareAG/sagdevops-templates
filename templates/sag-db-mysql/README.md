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

# Creating webMethods database on MySQL server

With this template you can create user, database, and webMethods database schemas on a MySQL Server. By default, the template installs the Database Component Configurator and the database scripts for all products, and it creates database schemas for all database components.

If you do not require to install database schemas for all products, remove the database scripts and the respective database components for the unrequired products. The following table maps the products to their database scripts, database component lists, and database actions for creating schemas:

Product | Database Script | Database Component List | Database Action for Creating Schemas
--------------------|----------|---------------------|------------------
webMethods Optimize  | OBEcdc  |  db.OBE.components | schemas.OBE
webMethods Business Rules | WOKcdc|  db.WOK.components | schemas.WOK
webMethods Trading Networks | TNScdc  |  db.TNS.components | schemas.TNS
My webMethods Server | MWScdc| db.MWS.components | schemas.MWS
webMethods Integration Server and webMethods Microservices Runtime | PIEcdc | db.PIE.components | schemas.PIE
webMethods Process Engine | WPEcdc| db.WPE.components | schemas.WPE

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
* webMethods database schemas for products version 10.5 and higher
* [MySQL JDBC Driver](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.zip)

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of MySQL Server database
* Docker Engine 17.09 and higher

## Running as a standalone Composite Template

When importing the composite template in Command Central, you have to attach the `mysql-connector-java-5.1.47.jar` file. Add the `template.yaml` and `mysql-connector-java-5.1.47.jar` files into a single template.zip file and import that file using the following command in the Command Central CLI:

```bash
sagcc exec templates composite import -i template.zip
```

To install Database Component Configurator 10.5 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create all database components schemas with user `root` and password `root`:

```bash
sagcc exec templates composite apply sag-db-mysql \
  db.version=latest repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.host=mysql db.admin.username=root db.admin.password=root \
  db.STR.components=[STR] \
  db.name=webm db.username=webm db.password=webm \
  --sync-job --wait 360
```


To install Database Component Configurator 10.5 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create all database components without My Webmethods Server  with user `root` and password `root`:

```bash
sagcc exec templates composite apply sag-db-mysql \
  db.version=latest repo.product=products-10.5 repo.fix=fixes-10.5 nodes=local \
  db.host=mysql db.admin.username=root db.admin.password=root \
  db.name=webm db.username=webm db.password=webm \
  db.MWS.components=[] db.STR.components=[STR]\
  db.product.scripts=[DatabaseComponentConfigurator,OBEcdc,WOKcdc,TNScdc,PIEcdc,WPEcdc] \
  --sync-job --wait 360
```

## Using the template for local development and testing on Docker platforms

1. Launch the Command Central container from the root folder of the following project:
```bash
docker-compose up -d cc
```

2. Launch the [MySQL](https://hub.docker.com/_/mysql/) container:
```bash
docker-compose -f templates/sag-db-mysql/docker-compose.yml up -d mysql
```

3. Provision `sag-db-mysql` and run tests:
```bash
CC_ENV=mysql ./provisionw sag-db-mysql
```
If the test is successful, the test output contains `TEST SUCCESSFUL`.

You can use the installed database for creating instances of webMethods products (for example, Integration Server and My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:mysql://mysql:3306/webm
db.username=webm
db.password=webm
db.type=mysql
```

The connection properties are pre-set in the `environments/mysql/env.properties` file and you can use them by pointing to the environment name, for example:

```bash
CC_ENV=mysql ./provisionw sag-is-cluster
```
