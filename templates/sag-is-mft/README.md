# ActiveTransfer Server/Gateway

Use this template to provision ActiveTransfer server/Gateway 10.1 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* Integration Server 10.1 and higher
* ActiveTransfer Server/Gateway 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new environments
* Installing latest fixes
* Configuration of:
  * JDBC Pool alias for ActiveTransfer
  * Functional alias for ActiveTransfer

## Running as a composite template

> IMPORTANT: Apply this template on top of an existing [Integration Server](../templates/sag-is-server) instance of the same release version as ActiveTransfer

## Provisioning ActiveTransfer Server/Gateway on Integration server

```bash
sagcc exec templates composite apply sag-mft-server nodes=dev \
  repo.product=products-10.1 \
  repo.fix=fixes-10.1 \
  --sync-job --wait 600
```
