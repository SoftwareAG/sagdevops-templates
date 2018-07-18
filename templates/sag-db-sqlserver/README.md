# Creating webMethods database on Miscrosoft SQL Server

With this template you can create user, database, and webMethods database schemas on a Microsoft SQL Server.

## Requirements

### Supported Software AG releases

* Command Central 10.1 or higher
* Database Component Configurator 9.10 or higher
* webMethods database schemas 9.8 or higher

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of Microsoft SQL Server database
* Docker Engine 17.09 or higher

## Running as a standalone Composite Template

Run this command to install Database Component Configurator on `local` 10.2 managed node and create
webMethods `webm` database, `webm` user and all schemas for 10.1 release on `sqlserver` SQL server connecting with `sa` user and `MaNaGe123` password:

```bash
sagcc exec templates composite apply sag-db-sqlserver
  release=10.2 repo.product=products-10.2 repo.fix=fixes-10.2 nodes=local \
  db.host=sqlserver db.admin.username=sa db.admin.password=MaNaGe123 \
  db.name=webm db.username=webm db.password=webm \
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

To use this template for local development launch Command Central container first.
From the root of this project run:

```bash
docker-compose up -d cc
```

Run this command to launch [Miscrosoft SQL Server on Linux for Docker Engine](https://hub.docker.com/r/microsoft/mssql-server-linux/)
container and apply the template to create the user, database and IS, MWS, and BPM schemas for 10.3 release:

```bash
docker-compose -f templates/sag-db-sqlserver/docker-compose.yml run --rm provision
...
17      Wed Jul 18 17:42:45 UTC 2018    DONE    DONE
```

Run this command to verify that the schemas are created successfully:

```bash
docker-compose -f templates/sag-db-sqlserver/docker-compose.yml run --rm test
...
**********************************
* Executing action
*   Action            : catalog
*   Database          : SQL Server
*   URL               : jdbc:wm:sqlserver://sqlserver:1433;databaseName=webm
*   User              : webm
**********************************

**********************************
*      Installed Components      *
**********************************
*   BLZ 10 Blaze
*   RUL 20 BusinessRules
*   CCS 27 CentralConfiguration
*   XRF 11 CrossReference
*   DSL 20 DistributedLocking
*   IDR 10 DocumentHistory
*   DBO 25 DynamicBusinessOrchestrator
*   ISC 51 ISCoreAudit
*   ISI 75 ISInternal
*   MWS 65 My webMethods Server
*   OPM 30 Operation Management
*   PRA 90 ProcessAudit
*   PRE 95 ProcessEngine
**********************************

The expected values were successfully retrieved after 1 call within 4 seconds.
```

You can now use this database for creating instances of webMethods products (IS, MWS, BPM) with the following database connection properties:

```bash
db.url=jdbc:wm:sqlserver://sqlserver:1433;databaseName=webm
db.username=webm
db.password=webm
db.type=sqlserver
```
