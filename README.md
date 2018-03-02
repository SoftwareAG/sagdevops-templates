# Command Central Default Template Library

This project provides default templates for Software AG Digital Business Platform products.

* The templates require Command Central 10.x. They do not work with Command Central 9.x
* The templates support provisioning of 9.8+ SAG products. See each template README.md for details

## Importing templates

If you use [automated Command Central setup project](https://github.com/SoftwareAG/sagdevops-cc-server)
the templates get imported automatically.

You can also import the templates into your local or remote Command Central instance by running:

```bash
sagccant up
```

## Using templates from Command Central Web UI

The templates can be used from the Web UI Stacks feature.

* Open [Command Central Stacks UI](https://0.0.0.0:8091/cce/web/?entry=stacks#stacks:)
and click + icon to create your first stack.
* Add infrastructure layer with new or existing nodes
* Add a runtime layer by selecting one of the supported layer types. Later type identifies the template to apply

## Using templates from Command Central CLI

The templates can also be used from the CLI

______________________
Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
