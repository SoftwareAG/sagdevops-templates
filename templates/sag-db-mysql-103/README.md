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

With this template you can create user, database, and webMethods database schemas on a MySQL Server.

## Requirements

None.

### Supported Software AG releases

* Command Central 10.3
* Database Component Configurator 10.3
* webMethods database schemas for products version 10.3
* [MySQL JDBC Driver](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.zip)

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of MySQL Server database
* Docker Engine 17.09 or higher

## Running as a standalone Composite Template

When importing the composite template to Command Central, you have to attach the 'mysql-connector-java-5.1.47.jar' file. Add the `template.yaml` and `mysql-connector-java-5.1.47.jar` files into a single `template.zip` file and import that file using the following command in the Command Central CLI:

```bash
sagcc exec templates composite import -i template.zip
```

To install Database Component Configurator 10.3 on the Command Central node with alias `local`,
create a database named `webm` and a database user named `webm` with password `webm`,
and create IS database product schemas with user `root` and password `root`:

```bash
sagcc exec templates composite apply sag-db-mysql-10.3 \
  db.version=latest repo.product=products-10.3 repo.fix=fixes-10.3 nodes=local \
  db.host=mysql db.admin.username=root db.admin.password=root \
  db.name=webm db.username=webm db.password=webm \
  db.components=[STR] \
  db.products=[IS]
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

1. Launch the Command Central container from the root folder of the following project:
```bash
docker-compose up -d cc
```
2. Launch the [MySQL](https://hub.docker.com/_/mysql/) container:
```bash
docker-compose -f templates/sag-db-mysql-10.3/docker-compose.yml up -d mysql
```
3. Provision `sag-db-mysql-10.3` and run tests:
```bash
CC_ENV=mysql ./provisionw sag-db-mysql-10.3
```
If the test is successful, the test ouptut contains `TEST SUCCESSFUL`.

You can now use this database for creating instances of webMethods products (for example, Integration Server and My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:mysql://mysql:3306/webm
db.username=webm
db.password=webm
db.type=mysql
```

The properties are pre-set in the `environments/mysql/env.properties` file and you can use them by pointing to the environment name, for example:

```bash
CC_ENV=mysql ./provisionw sag-is-cluster
```
