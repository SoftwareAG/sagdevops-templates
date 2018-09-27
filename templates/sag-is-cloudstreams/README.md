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

# CloudStreams Server

Use this template to provision CloudStreams server 9.12 and higher.

## Requirements

None

### Supported Software AG releases

The template is tested and supported for the following releases:

* Command Central 10.1 and higher
* CloudStreams Server 9.12 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 9.12, 10.1 and higher environments
* Installing the latest fixes

## Running as a composite template

> IMPORTANT: Apply this template on top of an _existing_ Integration Server or Microservices Runtime instance with the same release version as CloudStreams.

1. To import the sag-is-cloudstreams/template.yaml file in Command Central, use one of the methods described in [Importing templates library](https://github.com/SoftwareAG/sagdevops-templates/wiki/Importing-templates-library)
2. To apply the template, follow the instructions in [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)

### Provisioning CloudStreams on Microservices Runtime

Provision an instance of Microservices Runtime on managed node with alias `dev1`:

```bash
sagcc exec templates composite apply sag-msc-server nodes=dev1 \
  repo.product=products-10.1 \
  repo.fix=fixes-10.1 \
  --sync-job --wait 360
```

See [sag-msc-server](../sag-msc-server/) for details.

Provision CloudStreams on top of the above Microservices Runtime instance:

```bash

sagcc exec templates composite apply sag-is-cloudstreams nodes=dev1 \
  repo.product=products-10.1 \
  repo.fix=fixes-10.1 \
  --sync-job --wait 360
```

### Provisioning CloudStreams on Integration Server

Provision an instance of Integration Server on managed node with alias `dev2`

```bash
sagcc exec templates composite apply sag-is-server nodes=dev2 \
  repo.product=products-10.1 \
  repo.fix=fixes-10.1 \
  --sync-job --wait 360
```

See [sag-is-server](../sag-is-server/) for details.

Provision CloudStreams on top of the above Integration Server instance:

```bash

sagcc exec templates composite apply sag-is-cloudstreams nodes=dev2 \
  is.instance.type=integrationSever \
  repo.product=products-10.1 \
  repo.fix=fixes-10.1 \
  --sync-job --wait 360
```
