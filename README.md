# Command Central 10.x templates

This project provides basic templates for Command Central 10.1 Stacks feature.

To be able to provision new 10.1 stacks you must setup your Command Central 10.1 with:

* Mirror product repository for 10.1 release
* Mirror fix repository with the latest fixes
* License keys for your products
* CC bootstrap installers

Please see [Command Central server](https://github.com/SoftwareAG/sagdevops-cc-server) project for details.

## Quick start

1. Build and import the templates into your Command Central

```bash
git clone --recursive https://github.com/SoftwareAG/sagdevops-templates.git
cd sagdevops-templates
sagccant
```

2. Open [Command Central Stacks UI](https://localhost:8091/cce/web/?entry=stacks#stacks:) and click + icon to create your first stack.

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
