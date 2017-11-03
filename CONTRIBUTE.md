# How to add new templates

## Requirements

* Docker

## Setup dev environment

```bash
export COMPOSE_FILE=dev.yml
export COMPOSE_PROJECT_NAME=sagdevopstemplates
export SAG_AQUARIUS=aquarius-dae.eur.ad.sag # or whatever is the closest

# configure CC
docker-compose run --rm init
```

## Steps

* Fork or branch the project
* Add new template as templates/sag-xxx/template.yaml. See other templates as examples and Template Guidelines below
* Add new sag-xxx template as new layer type definition in templates/sag-layer-defs/template.yaml
* Import new template and test it from Command Central Stacks Web UI

```bash
# reimport templates, register dev nodes, TBD: run provisioning and tests
docker-compose run --rm test
```

* Create pull request to merge into master

## Template Guidelines

* There MUST be only environments/default section. No other environment types are currently supported
* All parameters MUST be declared in the environments/default section with sensible default values where possible
* Parameterize only what is necessary. Avoid too many parameters
* Follow these naming conventions for parameters:
  * License key parameter SHOULD end with '.license.key'
  * Credentials key parameter SHOULD end with 'credentials.key'
  * Port number parameter SHOULD end with '.port'
  * Fix list parameter SHOULD end with '.fixes'
* The following parameteres are provided by the framework
  * repo.product
  * repo.fix
  * nodes
* Template SHOULD define one layer only
* Template MUST define exactly one runtime instance

## Adding Tests

To add automated tests:

TBD
