# Designer Services

Use this template to provision Designer Services:  Designer Service Development, Local Version Control
Integration, and Unit Test Framework

## Requirements

### Supported Software AG releases

* Designer 10.2 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.2 or higher Designer Services
* Installing latest fixes

## Provisioning of new Designer Services instance

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

Provision Designer Services with alias `dev1`:

```bash
sagcc exec templates composite apply sag-designer-services nodes=dev1 \
  repo.product=products-10.2 \
  repo.fix=fixes-10.2 \
  --sync-job --wait 360
```

