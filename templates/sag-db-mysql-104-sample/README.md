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

# Creating webMethods database on MySQL server

With this template you can create user, database, and webMethods database schemas on a MySQL Server. If you need any other database components, you can extend this template with similar inline templates, like is-db-scripts.

## Requirements

None.

### Supported Software AG releases

* Command Central 10.4 and higher
* Database Component Configurator 10.4 and higher
* webMethods database schemas for products version 10.4 and higher
* [MySQL JDBC Driver](https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.zip)

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of MySQL Server database
* Docker Engine 17.09 and higher

## Running as a standalone Composite Template

When importing the composite template to Command Central, you will have to attach the 'mysql-connector-java-5.1.47.jar' file. Add the `template.yaml` and `mysql-connector-java-5.1.47.jar` files into a single template.zip file and import that file using the Command Central CLI with the following command:

```bash
sagcc exec templates composite import -i template.zip
```

To install Database Component Configurator 10.4 on the Command Central node with alias `local`,
create a database named `webm` and a database user named `webm` with password `webm`,
and create ISInternal and ISCoreAudit database components with user `root` with password `root`:

```bash
sagcc exec templates composite apply sag-db-mysql \
  db.version=latest repo.product=products-10.4 repo.fix=fixes-10.4 nodes=local \
  db.host=mysql db.admin.username=root db.admin.password=root \
  db.name=webm db.username=webm db.password=webm \
  db.components=[ISInternal,ISCoreAudit] \
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

Launch the Command Central container from the root folder of this project:

```bash
docker-compose up -d cc
```

Launch the [MySQL](https://hub.docker.com/_/mysql/) container:

```bash
docker-compose -f templates/sag-db-mysql-104-sample/docker-compose.yml up -d mysql
```

Provision sag-db-mysql template and run tests:

```bash
CC_ENV=mysql ./provisionw sag-db-mysql-104-sample
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
* CTR   10.4       ComponentTracker                                              *
* PRE   10.4       ProcessEngine                                                 *
* OPM   9.0.1      OperationManagement                                           *
* ISI   10.3.fix1  ISInternal                                                    *
* DSL   7.1        DistributedLocking                                            *
* ISC   10.3       ISCoreAudit                                                   *
* PRA   10.3       ProcessAudit                                                  *
* IDR   7.1        DocumentHistory                                               *
* XRF   8.2.2      CrossReference                                                *
* MWS   10.4       MywebMethodsServer                                            *
* CCS   9.0.1      CentralConfiguration                                          *
* OPT_AE_ANL 85         Optimize Analytic Engine Analysis Component                                *
* ANL   10.1       Analysis                                                      *
* DBM   9.9        DatabaseManagement                                            *
* DTP   9.0.1      DataPurge                                                     *
* OPT_AE_PTR 50         Optimize Analytic Engine Process Tracker Component                                *
* PTR   10.1       ProcessTracker                                                *

The expected values were successfully retrieved after 1 call within 2 seconds.

TEST SUCCESSFUL
```

You can now use this database for creating instances of webMethods products (Integration Server, My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:mysql://mysql:3306/webm
db.username=webm
db.password=webm
db.type=mysql
```

The properties are preset in `environments/mysql/env.properties` file and you can use them by poiting to the environment name. For example:

```bash
CC_ENV=mysql ./provisionw sag-is-cluster
```
