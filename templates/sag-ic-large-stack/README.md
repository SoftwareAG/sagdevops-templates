# Integration Cloud

Use this template to provision containers stack with the following runtimes:

* Oracle 11 DB
* Terracotta Big Memory Server 4.3
* Universal Messaging Server 10.3
* Integration Server 10.3 cluster with 2 or more instances

## Requirements

### Supported Software AG releases

* Software AG DBP 10.3

### Supported platforms

* Docker 17.09+
* Kubernetes 1.9+

### Supported use cases

* Provisioning of new 10.3 stack
* Configuration of:
  * Memory and CPU resorces
  * Asset repository URL
* Asset deployment from landscape asset registry
* Scalling Integartion Server instances up and down

## Using Docker Compose

### Lanching containers using docker-compose

```bash
docker-compose -f templates/sag-ic-large-stack/docker-compose.yaml up -d
```

## Using Kubernetes

TODO: