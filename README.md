# Command Central 10.x templates

This project provides basic templates for Command Central 10.1 Stacks feature.

## Quick start with Docker

Launch base Command Central container instance with an empty target node and
import the templates:

```bash
git clone --recursive https://github.com/SoftwareAG/sagdevops-templates.git
cd sagdevops-templates
docker-compose up -d
```

Open [Command Central Stacks UI](https://localhost:8091/cce/web/?entry=stacks#stacks:) and click + icon to create your first stack.
IMPORTANT: if you use Docker Toolbox replace localhost with your Docker VM IP.

## Adding and recycling nodes

To add more nodes:

```bash
docker-compose scale node=2
```

To recycle nodes:

```bash
docker-compose scale node=0
docker-compose scale node=2
```

To shutdown and cleanup:

```bash
docker-compose down
```

## I don't have Docker

Please see [Command Central server](https://github.com/SoftwareAG/sagdevops-cc-server) project for details.

To build and import templates run:

```bash
sagantcc up
```

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
