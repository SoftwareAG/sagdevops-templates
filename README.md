<!-- Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors

   SPDX-License-Identifier: Apache-2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and

     limitations under the License.                                                  

-->

# Command Central Default Templates Library

Please see [Default Templates Library wiki](https://github.com/SoftwareAG/sagdevops-templates/wiki) for details.

## Global setup

Set the following enviornment variables specific to your environment:

* CC_REGISTRY=host:port - the URL of the Docker registry to download Command Central images from.

By default, it is the Docker Store registry. If you use your own private registry change this value to the
URL of this registry, e.g.

```bash
CC_REG=daerepository03.eur.ad.sag:4443
```

* CC_ORG=ccorg - the org name in the $CC_REGISTRY registry that contains Command Central images.

By default, it is `softwreag`. Change it to reflect your private registry org, e.g.

```bash
CC_ORG=ccdevops
```

* REG=host:port - the URL of the Docker registry to push and store your custom images

Set this to point to your private registry

* ORG=myorg - the org name in the $REG registry to store custom images

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
______________________

Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
