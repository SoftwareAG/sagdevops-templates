<!-- Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors

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
# Cloud Streams

Use this template to provision CloudStreams product on top of Integration Server
or Microservices Runtime instance (is this supported?)

## Requirements

### Supported Software AG releases

* Integration Server 10.2 and higher
* Microservices Runtime 10.2 and higher (is this supported?)
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.2 or higher CloudStreams

## Provisioning of new CloudStreams server instance

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

> IMPORTANT: this template must be applied on top of _existing_ Integration Server instance

Provision Integration Server 10.2 with all latest fixes on the installation with alias `dev1`
and create `default` instance listening on default ports 5555:

```bash
sagcc exec templates composite apply sag-is-server nodes=dev1 \
  is.instance.name=default \
  repo.product=products-10.2 \
  repo.fix=fixes-10.2 \
  --sync-job --wait 360
```

Provision CloudStreams on top of `default` Integration Server instance on the installation
with alias `dev1`:

```bash
sagcc exec templates composite apply sag-is-cloudstreams nodes=dev1 \
  is.instance.name=default \
  repo.product=products-10.2 \
  repo.fix=fixes-10.2 \
  --sync-job --wait 360
```
