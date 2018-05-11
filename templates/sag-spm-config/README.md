# Platform Manager Configurations

Use this template to configure Platform Managers

## Requirements

### Supported Software AG releases

* Platform Manager 9.8 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Configuration of:
  * Tanuki Java Service wrapper
  * Java System properties
  * Monitoring interval
* Building Docker image with configured SPM

## Running as a composite template

Apply custom configurations to SPM's registered as node1 and node2:

```bash
sagcc exec templates composite apply sag-spm-config nodes=node1,node2 \
  hello.world=spm \
  --sync-job --wait 360
```

## Building Docker image

Build Docker image with SPM customized configuration

Configuration values can be:

* Hardcoded in the template
* Defined as parameters in [env.properties](env.properties) file
* Defined as build arguments in Dockerfile and docker-compose.yml file. See `__hello_world`
* Defined in the template as ENV variables resolved at container startup. See `%HELLO_NAME%`

```bash
docker-compose build
```

Run the container

```bash
docker-compose up -d node
```

Open SPM in the browser:

```bash
open http://`docker-compose port node 8092`/spm
```

Login as Administrator/manage
