<!-- Copyright 2018-2019 Software AG, Darmstadt, Germany and/or its licensors

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

# EntireX RPC Server for XML/SOAP

The current template provisions an EntireX RPC Server for XML/SOAP.

This template demonstrates in detail how to install the EntireX Core component, creates and configures an RPC Server for Java. Use this template as a reference when provisioning EntireX RPC Server for XML/SOAP instances.

## Requirements

### Supported Software AG releases

* EntireX 10.3 and higher
* Command Central 10.3 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning new environments of version 10.3 and higher
* Installing latest fixes
* Creating an EntireX RPC Server for Java
* Configuration of:
  * License
  * Broker connection parameters
  * Admin Port
  * Logging
  * Deployment
  * HTTPS
  * Mapping
  * Other settings


## Running as a composite template

When importing the composite template to Command Central:
Add the `template.yaml` and import that file using the Command Central CLI with the following command:

```
sagcc exec templates composite import -i template.yaml
```

For more information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To provision an instance of an EntireX RPC Server for XML/SOAP, use the Command Central CLI with the following command:

```
sagcc exec templates composite apply sag-exx-xml-rpc-server nodes=<your_node> \
  repo.product=<your_product_repository> \
  repo.fix=<your_fixes_repository>
```