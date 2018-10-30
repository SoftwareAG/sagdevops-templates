# ActiveTransfer Listener ports configuration

> STATUS: INCUBATING

Use this template to configure ports on Active Transfer 10.1 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* ActiveTransfer Server/Gateway 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported configurations

* Listener ports configuration

## Running as a composite template

### Listener ports configuration in ActiveTransfer

```bash
sagcc exec templates composite apply sag-mft-config nodes=dev \
  mft.port.protocol=HTTP mft.port.number=4081 mft.port.name=p1 \
  --sync-job --wait 600
```
