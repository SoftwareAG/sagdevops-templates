# Small Integration Stack

Use this template to provision containers stack with the following runtimes:

* Integration Server 10.3 ([Dockerfile](../sag-is-server/Dockerfile))
* Universal Messaging Server 10.3 ([Dockerfile](../sag-um-server/Dockerfile))

## Requirements

### Supported Software AG releases

* Software AG DBP 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Provisioning of new 10.3 integration stack using Docker containers

## Using Docker Compose

### Launching containers with docker-compose

```bash
docker-compose -f templates/sag-ic-small-stack/docker-compose.yml run --rm init
```

## TODO

* Configuration of:
  * Asset repository URL
* Asset deployment from landscape asset registry
