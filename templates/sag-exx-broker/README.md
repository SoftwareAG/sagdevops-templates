# Entire X Broker

## Test run the template

From the root of the project:

```bash
./provisionw sag-exx-broker
```

Make changes to template.yaml and rerun the above command.

FIXME's:

* SPM plugin does not get activated! Instance cannot be created

## Docker image build

Build image and test container

```bash
export COMPOSE_FILE=docker-compose-build.yml
docker-compose run --rm test
```

Rebuild image

```bash
docker-compose build
```

FIXME's

* Add real entrypoint.sh
