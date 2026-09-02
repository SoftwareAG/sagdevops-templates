# Trading Networks User Interface on My webMethods Server

Use this template to provision Trading Networks Web UI 10.1 and higher on My webMethods Server.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* Trading Networks Server 10.1 and higher
* My webMethods Server 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported configurations

* Provisioning of new environments
* Database component configuration for MWS and Trading Networks
* Configurable JDBC pool, load balancer, and IS connection settings
* Installing fixes for MWS and Trading Networks UI

## Running as a composite template

> Important: Apply this template on top of an existing [My webMethods Server](../sag-mws-server) instance
> with the same release version as Trading Networks.

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

### Provisioning Trading Networks UI on My webMethods Server

```bash
sagcc exec templates composite apply sag-mws-tnui \
  nodes=dev1 \
  mws.instance.name=default \
  mws.http.port=8585 \
  mws.https.port=8586 \
  mws.jmx.port=8587 \
  mws.memory.init=256 \
  mws.memory.max=512 \
  mws.lb.host=localhost \
  mws.lb.http.port=8585 \
  mws.lb.https.port=8586 \
  mws.fixes=ALL \
  repo.product=webM121 \
  repo.fix=Empower \
  is.host=localhost \
  is.port=5555 \
  db.type=oracle \
  db.url="jdbc:wm:oracle://hostname:1521;sid=orcl" \
  db.username=tncc \
  db.password=tncc \
  --sync-job --wait 600
```

## Creating a new stack with Trading Networks UI layer using Web UI

Consult [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui)
for additional information about using Stacks UI.

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select `tn-portal` layer definition
  * Select product and fix repositories
  * Select the node on which to provision the Trading Networks UI
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision job completes. Use Jobs view to monitor

## Template parameters

| Parameter | Description | Example |
|---|---|---|
| `mws.instance.name` | MWS instance name | `default` |
| `mws.http.port` | MWS HTTP port | `8585` |
| `mws.https.port` | MWS HTTPS port | `8586` |
| `mws.jmx.port` | MWS JMX port | `8587` |
| `mws.memory.init` | MWS JVM initial heap size (MB) | `256` |
| `mws.memory.max` | MWS JVM max heap size (MB) | `512` |
| `mws.lb.host` | Load balancer hostname | `localhost` |
| `mws.lb.http.port` | Load balancer HTTP port | `8585` |
| `mws.lb.https.port` | Load balancer HTTPS port | `8586` |
| `mws.fixes` | MWS fix list to install | `ALL` |
| `repo.product` | Product repository alias | `webM121` |
| `repo.fix` | Fix repository alias | `Empower` |
| `is.host` | Integration Server hostname | `localhost` |
| `is.port` | Integration Server port | `5555` |
| `db.type` | Database type (`oracle`, `sqlserver`, `db2`) | `oracle` |
| `db.url` | JDBC URL to the Trading Networks database | `jdbc:wm:oracle://hostname:1521;sid=orcl` |
| `db.username` | Database username | `tncc` |
| `db.password` | Database password | *(secure)* |
| `nodes` | Managed node(s) to provision on | `dev1` |
