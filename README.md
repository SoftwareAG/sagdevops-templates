# Command Central Default Templates Library

This project provides a library of default templates for
Command Central 10.2

The templates can be used as standalone composite templates as well as
micro templates for Command Stack Layer definitions.

See README.md for each template in the [templates/](templates/) folder
for specific details.

The library is included as a git submodule into
[Command Central automation project](https://github.com/SoftwareAG/sagdevops-cc-server)
If you use this project to setup your Command Central you will get it automatically.

## Importing the template library

You can import the library into any Command Central server by running this command:

```bash
git clone --recursive https://github.com/SoftwareAG/sagdevops-templates
cd sagdevops-templates
sagccant up
```

## Provisioning new stacks using Command Central Web UI

You can provision new stacks using Command Central Web UI.

The stacks are built interactively, layer by layer. The layer definitions
use templates from the template library.

Open [Command Central Stacks UI](https://0.0.0.0:8091/cce/web/?entry=stacks#stacks:)
and click `+` icon to create your first stack.

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
______________________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
