# Creating webMethods database on Oracle

With this template you can create user, database, and webMethods database schemas on an Oracle database server.

## Requirements

### Supported Software AG releases

* Command Central 10.1 or higher
* Database Component Configurator 9.10 or higher
* webMethods database schemas, created in version 9.8 or higher

### Supported platforms

* All supported Windows and UNIX platforms
* All supported versions of Oracle database
* Docker Engine 17.09 or higher

## Running as a standalone Composite Template

To install Database Component Configurator on a node with alias `local` and version 10.2 and create a webMethods database, named `webm` with credentials `webm`/`webm` and all database schemas for version 10.2 on an Oracle database host connecting with `system` /`oracle`:

```bash
sagcc exec templates composite apply sag-db-oracle
  release=10.2 repo.product=products-10.2 repo.fix=fixes-10.2 nodes=local \
  db.host=oracle db.admin.username=system db.admin.password=oracle \
  db.name=webm db.username=webm db.password=webm \
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

To use this template for local development you must first launch the Command Central container. From the root folder of this project run:

```bash
docker-compose up -d cc
```

To launch the [Oracle Database Express Edition 11g Release 2](https://hub.docker.com/r/wnameless/oracle-xe-11g/) container and apply the `sag-db-oracle` template to create a user, database, and IS, MWS, and BPM database schemas for the 10.3 release:

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

You can now use this database for creating instances of webMethods products (Integration Server, My webMethods Server, Business Process Management) with the following database connection properties:

```bash
db.url=jdbc:wm:oracle://oracle:1521;SID=XE
db.username=webm
db.password=webm
db.type=oracle
```
