# Apama Correlator

WARNING: UNDER DEVELOPMENT !!!

Use this template to provision empty Apama Correlator instance

## Requirements

### Supported Software AG releases

* Apama 10.2 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.2 or higher environments
* Installing latest fixes
* Creating new correlator instances

## Running as a composite template

> NOTE: to provision a new 10.2+ node use any of the `sag-spm-*` templates.

Provision `default` instance of Apama Correlator on port 15903:

```bash
sagcc exec templates composite apply sag-apama-correlator nodes=dev1 \
  apama.instance.name=default apama.port=15903 \
  apama.fixes=[] \
  repo.product=webMethods-10.2 \
  repo.fix=Empower \
  --sync-job --wait 360
```

## FIXME's

* License file does not get picked up
* Digital Event Services component does not support status and restart operation
