# CloudStreams Designer

Use this template to provision CloudStreams Designer

## Requirements

### Supported Software AG releases

* Designer 10.2 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.2 or higher CloudStreams Designer

## Provisioning of new CloudStreams server instance

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

Provision CloudStreams Designer on the installation with alias `dev1`:

```bash
sagcc exec templates composite apply sag-designer-cloudstreams nodes=dev1 \
  repo.product=products-10.2 \
  repo.fix=fixes-10.2 \
  --sync-job --wait 360
```
