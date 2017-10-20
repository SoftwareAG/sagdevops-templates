# How to add new templates

## Steps

* Fork the project
* See existing templates as examples
* Add new template under templates/ folder
* Register new template as new layer type definitino in templates/sag-layer-defs/template.yaml
* Reimport project
* Test new template
* Create pull request for the master branch

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

TBD
