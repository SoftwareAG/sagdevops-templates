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

# API Gateway server

Use this template to provision and maintain API Gateway server

## Requirements

### Supported Software AG releases

* API Gateway 10.1 and higher
* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.1 and higher environments
* Installing latest fixes
* Configuration of:
  * License
  * JVM memory
  * Primary, diagnostics and JMX ports of Integration Server or MSC 

## Provisioning of new server instance

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

Provision product API Gateway 10.3 on top of its own `apigateway` instance of Integration Server with all latest fixes

```bash
sagcc exec templates composite apply sag-apigateway-server nodes=node \
  is.instance.type=integrationServer \
  agw.memory.max=512 \
  repo.product=webMethods-10.3 \
  repo.fix=Empower \
  --sync-job --wait 360
```

Provision product API Gateway 10.3 on top of its own `apigateway` instance of MSC with all latest fixes

```bash
sagcc exec templates composite apply sag-apigateway-server nodes=node \
  repo.product=webMethods-10.3 \
  repo.fix=Empower \
  --sync-job --wait 360
```
