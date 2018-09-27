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

# Apama Correlator

The current template provisions an Apama installation, creates an Apama correlator instance and deploys a simple Apama application.

This template demonstrates in detail all possible Apama correlator configurations that can be applied using a product template. Use this template as a reference when provisioning Apama correlator instances.

## Requirements

### Supported Software AG releases

* Apama 10.2 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning new environments of version 10.2 and higher
* Installing latest fixes
* Creating an Apama correlator instance and deploying a simple EPL application to it
* Configuration of:
  * License
  * Ports
  * Logging
  * Persistence
  * All other supported correlator configuration items

## Running as a composite template

When importing the composite template to Command Central, you will have to
attach the simple 'HelloWorld' application. Add the `template.yaml` and
`HelloWorld.zip` into a single zip file and import that file using the Command Central CLI with the following command:

```bash
sagcc exec templates composite import -i template.zip
```

For more information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To provision a `default` instance of an Apama 10.2 correlator with all the
latest fixes, listening on port 15904:

```bash
sagcc exec templates composite apply sag-apama-correlator nodes=sag1 \
  repo.product=products-10.2 \
  repo.fix=fixes-10.2 \
  os.platform=LNXAMD64 \
  --sync-job --wait 360
```

## Adding as a runtime layer to a stack

Once imported, this template can also be used as a runtime layer for stacks,
using either the Command Central CLI, or the Command Central web user interface.

For more information about using stacks and layers, see [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui).
