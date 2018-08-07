# Integration Stack

UNDER DEVELOPMENT !!!

Use this template to provision stack with the following containers:

* SQL Server DB
* Universal Messaging Server 10.3 ([Dockerfile](../../sag-um-server/Dockerfile)
* Terracotta Big Memory Server 4.3 ([Dockerfile](../../sag-tc-server/Dockerfile)
* Integration Server 10.3 cluster ([Dockerfile](../../sag-is-statefull-cluster/Dockerfile)

## Requirements

### Supported Software AG releases

* Software AG DBP 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Provisioning of new 10.3 stack using Docker

## Launching integration stack using docker-compose

Launch [Command Central 10.3 Stack](../sag-cc/) first.

Launch DB and create schemas:

```bash
docker-compose run --rm initdb
```

Launch containers and configure
them using Command Central templates (push model):

```bash
docker-compose up -d
```
