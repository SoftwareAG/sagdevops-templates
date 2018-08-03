# Small integration stack

Use this template to provision and configure containers stack with the following runtimes:

* Integration Server 10.3 ([Dockerfile](../../sag-is-server/Dockerfile)
* Universal Messaging Server 10.3 ([Dockerfile](../../sag-um-server/Dockerfile)

## Requirements

### Supported Software AG releases

* Universal Messaging 10.3
* Integration Server 10.3
* Platform Manager 10.3
* Command Central 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Provisioning 10.3 UM and IS containers
* Configuring UM and IS using push model (from CC)

## Launching integration stack using docker-compose

Launch [Command Central 10.3 Stack](../sag-cc/) first.

Launch Universal Messaging 10.3 and Integration Server 10.3 containers and configure
them using Command Central templates (push model):

```bash
docker-compose up -d
```

Browse to http://localhost:5555 to open Integration Server Admin UI. Login (Administrator/manage)
