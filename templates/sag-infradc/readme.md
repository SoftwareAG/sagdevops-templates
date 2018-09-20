# Infrastructure Data Collector

Use this template to provision or migrate Infrastructure Data Collector

## Requirements and limitations

### Supported Software AG releases

* Command Central 10.1 or higher
* Infrastructure Data Collector 10.1 or higher

### Supported platforms

All supported Windows and UNIX platforms.
  
### Supported use cases

* Provisioning of new 10.1 or 10.3 environments
* Installing latest fixes and support patches
* Configuration of:
  * Ports
  * Memory
  * JNDI and JMS connections
  * Monitoring metatdata

## Running as a composite template

To import the template file in Command Central, use one of the methods described in [Importing templates library](https://github.com/SoftwareAG/sagdevops-templates/wiki/Importing-templates-library)

To apply the template, follow the instructions in [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)

Provision Infrastructure Data Collector on the installation with alias `node` and configure it to point to the [Universal Messaging realm server](../sag-um-server/) that listens at `nsp://umhost:9000`:

```bash
sagcc exec templates composite apply sag-infradc nodes=node \
    infradc.jms.host=umhost \
    repo.product=products-10.1 repo.fix=fixes-10.1 \
    --sync-job --wait 360
```
