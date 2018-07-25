# Small Integration stack on Docker

Use this template to provision and configure containers stack with the following runtimes:

* Integration Server 10.3 ([Dockerfile](../sag-is-server/Dockerfile))
* Universal Messaging Server 10.3 ([Dockerfile](../sag-um-server/Dockerfile))

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
* Configuring UM and IS using pull model (from LAR)

## Using Docker Compose

### Launching containers with docker-compose

Launch Universal Messaging 10.3 and Integration Server 10.3 containers:

```bash
docker-compose -f templates/sag-ic-small-stack/docker-compose.yml up -d um01 is01
```

### Configuring containers using push model

```bash
docker-compose -f templates/sag-ic-small-stack/docker-compose.yml run --rm init
```

### Configuring containers using pull model

```bash
docker-compose -f templates/sag-ic-small-stack/docker-compose-pusll.yml up -d
```

TODO:

* Setup SPM repo configs for LAR
