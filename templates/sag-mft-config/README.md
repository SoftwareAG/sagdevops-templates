ActiveTransfer Listener ports configuration

Use this template to provision create a ports in ActiveTransfer 10.1 and higher.

## Requirements


### Supported Software AG releases

* Command Central 10.1 and higher
* ActiveTransfer Server/Gateway 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported configurations

* Listener ports configuration

## Running as a composite template
	Important: Apply this template on top of existing integration server instance which includes ActiveTransfer server.
	
## Listener ports configuration in ActiveTransfer 

``bash
sagcc exec templates composite apply sag-mft-config nodes=dev \
  --sync-job --wait 600
``
