# Command Central Docker Builder generic Dockerfile

EXPERIMENTAL: Build a basic docker image for any product that provides a template.yaml in this project.

For example, to build webMethods Microservices Runtime (sag-msc-server) 10.1 with latest fix level run:

```bash
docker build \
    --build-arg TAG=10.1 \
    --build-arg TEMPLATE=sag-msc-server \
    --build-arg PORT=5555 \
    --build-arg ENTRYPOINT=profiles/IS_default/bin/console.sh \
    -t softwareag/msc:10.1 \
    .
```

## Supported customizations

The customizatinos are supported via --build-arg parameters for the `docker build` :

* TAG - 10.3, 10.2, 10.1 - target release for which you'd like to build the image, default 10.3
* TEMPLATE - template alias from this project, default sag-spm-config
* PORT - runtime port to expose, default 8092
* ENTRYPOINT - main runtime entrypoint, default profiles/SPM/bin/console.sh
