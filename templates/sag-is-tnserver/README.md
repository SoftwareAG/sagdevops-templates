# Trading Networks Server

Use this template to provision and maintain webMethods Trading Networks (TN) Server on top of Integration Server.

## Requirements

### Supported Software AG releases

* Integration Server 10.3 and higher
* Trading Networks Server 10.3 and higher
* Command Central 10.3 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported configurations

* Single-node Trading Networks Server (`template.yaml`):
  * Supports Oracle, SQL Server, DB2, and MySQL database back-ends
  * Configurable IS instance name, JDBC pool alias, and fix repository
  * JDBC connection pool and DB functions (`CentralUsers`, `TN`) auto-configured
  * Database schema seeded via Database Component Configurator (DCC)

## Running as a composite template

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

### Provisioning a single-node Trading Networks Server

Provision a Trading Networks Server instance on managed node `local`:

```bash
sagcc exec templates composite apply sag-is-tnserver \
  nodes=local \
  is.instance.name=default \
  is.jdbc.pool.alias=TNTest \
  is.primary.port=5555 \
  is.diagnostic.port=9999 \
  is.secure.port=5543 \
  is.jmx.port=8075 \
  is.install.service=false \
  is.db.alias=TNTest \
  is.db.type=oracle \
  is.db.url="jdbc:wm:oracle://hostname:1521;sid=orcl" \
  is.db.username=tncc \
  is.db.password=tncc \
  is.package.list=WmTN \
  tn.centralusers.poolalias=TNTest \
  tn.dbfunction.poolalias=TNTest \
  repo.product=webM121 \
  repo.fix=Empower \
  TN.fixes=ALL \
  --sync-job --wait 600
```

## Creating a new stack with Trading Networks layer using Web UI

Consult [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui)
for additional information about using Stacks UI.

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select `TN-SERVER` layer definition
  * Select product and fix repositories
  * Select the node on which to provision Trading Networks Server
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision job completes. Use Jobs view to monitor

## Template parameters

| Parameter | Description | Example |
|---|---|---|
| `is.instance.name` | Integration Server instance name | `default` |
| `is.jdbc.pool.alias` | JDBC connection pool alias | `TNTest` |
| `is.primary.port` | Primary HTTP port | `5555` |
| `is.diagnostic.port` | Diagnostics port | `9999` |
| `is.secure.port` | HTTPS port | `5543` |
| `is.jmx.port` | JMX port | `8075` |
| `is.install.service` | Install as OS service | `false` |
| `is.db.alias` | IS database alias | `TNTest` |
| `is.db.type` | Database type (`oracle`, `sqlserver`, `db2`, `mysql`) | `oracle` |
| `is.db.url` | JDBC URL to the Trading Networks database | `jdbc:wm:oracle://hostname:1521;sid=orcl` |
| `is.db.username` | Database user name | `tncc` |
| `is.db.password` | Database password | *(secure)* |
| `is.package.list` | Packages to install on the IS instance | `WmTN` |
| `tn.centralusers.poolalias` | JDBC pool alias for Central Users DB function | `TNTest` |
| `tn.dbfunction.poolalias` | JDBC pool alias for TN DB function | `TNTest` |
| `repo.product` | Product repository alias | `webM121` |
| `repo.fix` | Fix repository alias | `Empower` |
| `TN.fixes` | Fix list to install | `ALL` |
| `nodes` | Managed node(s) to provision on | `local` |
