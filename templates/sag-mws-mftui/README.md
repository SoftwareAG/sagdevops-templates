# ActiveTransfer User Iterface on My webMethods Server

Use this template to provision ActiveTransfer Web UI 10.1 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* ActiveTransfer Server/Gateway 10.1 and higher
* My webMethods Server 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new environments
* Installing latest fixes

## Running as a composite template

> Important: Apply this template on top of existing [My WebMethods server](../sag-mws-server) instance with same releases version as ActiveTransfer

### Provisioning ActiveTransfer MWS_UI on My WebMethods server

```bash
sagcc exec templates composite apply sag-mws-mftui nodes=dev \
  repo.product=products-10.1 \
  repo.fix=fixes-10.1 \
  --sync-job --wait 600
```
