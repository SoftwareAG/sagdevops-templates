ActiveTransfer MWS_UI

Use this template to provision ActiveTransfer MWS_UI 10.1 and higher.

## Requirements

None

### Supported Software AG releases

* Command Central 10.1 and higher
* ActiveTransfer Server/Gateway 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new environments
* Installing latest fixes

## Running as a composite template
	Important: Apply this template on top of existing My WebMethods server instance with same releases version as ActiveTransfer
	
##Provisioning ActiveTransfer MWS_UI on My WebMethods server

``bash
sagcc exec templates composite apply sag-mws-mftui nodes=dev \
  repo.product=products-10.1 \
  repo.fix=fixes-10.1 \
  --sync-job --wait 600
``
