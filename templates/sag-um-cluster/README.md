# Universal Messaging Cluster

> STATUS: INCUBATING

Use this template to provision, maintain, or upgrade a Universal Messaging cluster with two or three nodes, or a Universal Messaging cluster with four nodes and two sites.

## Requirements

### Supported Software AG releases

* Universal Messaging 9.8 and higher
* Command Central 10.3 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 9.8 or higher environments
* Installing latest fixes and support patches
* In-place upgrades to 9.12 or higher
* Configuration of:
  * License
  * JVM memory
  * NHP and JMX ports
  * COMMON-JAVASYSPROPS configuration in YAML format (supported for Universal Messaging 10.1 and higher)
  * COMMON-CLUSTER configuration for two, three, or four nodes
* Building docker images for 10.x releases

## Provisioning a new cluster instance

For more information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To provision a `default` instance of a Universal Messaging 10.5 cluster with alias name `testCluster`, consisting of two nodes, listening on default ports 9000 and 9988 (JMX), with 128mb of memory, and install all latest fixes:

```bash
sagcc exec templates composite apply sag-um-cluster nodes=[dev1,dev2] \
  um.memory.max=512 \
  repo.product=webMethods-10.5_GA \
  repo.fix=GA_Fix_Repo \
  um.cluster=testCluster \
  --sync-job --wait 360
```
