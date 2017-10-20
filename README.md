# Command Central 10.x templates

This project provides basic templates and layer definitions for
Command Central 10.1 Stacks.

## Quick start with Docker

Please see [Hello Docker](https://github.com/SoftwareAG/sagdevops-hello-docker)
on how to get started with Command Central on Docker.

Get sources:

```bash
git clone --recursive https://github.com/SoftwareAG/sagdevops-templates.git
cd sagdevops-templates
```

Launch empty Command Central container instance with an empty target node and
import the templates:

```bash
docker-compose run --rm init
```

Open [Command Central Stacks UI](https://0.0.0.0:8091/cce/web/?entry=stacks#stacks:) and click + icon to create your first stack.

## I don't have Docker

Please see [Command Central Configuration](https://github.com/SoftwareAG/sagdevops-cc-server) project for details.

To build and import templates run:

```bash
sagccant up
```

## How to add new layer templates

Please see [how to add new templates](CONTRIBUTE.md)

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
