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

* Listener port configurations:
  * HTTP
  * HTTPS
  * FTP
  * SFTP

## Running as a composite template

### Listener ports configuration in ActiveTransfer

Configure HTTP port 4081 and FTP port 2221 on ActiveTransfer `default` server instance:

```bash
sagcc exec templates composite apply sag-mft-config nodes=dev \
  mft.http.port=4081 mft.http.port.alias=http1 \
  mft.ftp.port=2221 mft.ftp.port.alias=ftp1 \
  mft.https.port.enabled=false \
  mft.sftp.port.enabled=false \
  --sync-job --wait 600
```
