# Ninja demo product

Use this template to provision and migrate Ninja demo product.

## Requirements

### Supported Software AG releases

* Ninja 10.1 or higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new environments
* Installing latest fixes and support patches
* In-place upgrades
* Cross-host migrations
* Configuration of:
  * License
  * JVM memory
  * Ports
  * ...

## Running as a composite template

> NOTE: to provision a new 9.8+ node use any of the `sag-spm-*` templates.

Provisions `default` instance of Universal Messaging Realm 10.1 server with all latest fixes,
listening on default ports
9000 and 9988 (jmx), with 512mb of memory:

```bash
sagcc exec templates composite apply sag-ninja-server nodes=node \
  ninja.memory.max=256 \
  repo.product=products \
  repo.fix=fixes \
  --sync-job --wait 600
```

## Creating a new stack with Ninja layer using Web UI

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select NINJA-SERVER layer definition
  * Select product and fix repositories
  * Select exactly one node on which to provision Ninja server
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor

## Local development and testing



