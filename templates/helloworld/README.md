# Hello World

End to end module to demonstrate [template](template.yaml) provision
[testing](test.sh) and Docker [image building](Dockerfile) capabilities.

## Provisioning

Important files:

* [template.yaml](template.yaml) - Command Central composite template
* [tests](test.sh)

```bash
docker-compose run --rm provision
```

## Building Docker image

```bash
docker-compose up -d node
docker-compose run --rm test
```
