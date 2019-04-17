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

Use this template to provision an Apama installation, create an Apama correlator instance, and deploy a simple Apama application.

This template demonstrates in detail all possible Apama correlator configurations that can be applied using a product template. Use this template as a reference when provisioning Apama correlator instances.

## Requirements

None.

### Supported Software AG releases

* Apama 10.2 and higher
* Command Central 10.4 
* Command Central 10.2 and 10.3 with limitations. If you apply this template when Digital Event Services is not configured, the template job fails because Digital Event Services cannot be started. 

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.2 and higher environments
* Installing latest fixes
* Creating an Apama correlator instance and deploying a simple EPL application to it
* Configuration of:
  * License
  * Ports
  * Logging
  * Persistence
  * All other supported correlator configuration items

## Running as a composite template

When importing the composite template in Command Central, you should attach the simple 'HelloWorld' application. Add the `template.yaml` and `HelloWorld.zip` into a single zip file and import this file using the following command in the Command Central CLI:

```bash
sagcc exec templates composite import -i template.zip
```

For more information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To provision a `default` instance of an Apama 10.2 correlator with all the latest fixes, listening on port 15904:

```bash
sagcc exec templates composite apply sag-apama-correlator nodes=sag1 \
  repo.product=products-10.2 \
  repo.fix=fixes-10.2 \
  os.platform=LNXAMD64 \
  --sync-job --wait 360
```

## Adding as a runtime layer to a stack

After importing this template in Command Central, you can use it as a runtime layer for stacks through the Command Central CLI or the Command Central web user interface.

For more information about using stacks and layers, see [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui).
