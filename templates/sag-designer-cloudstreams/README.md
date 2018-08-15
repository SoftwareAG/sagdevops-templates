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

# CloudStreams Designer

Use this template to provision CloudStreams Designer.

## Requirements
None

### Supported Software AG releases

* Designer 10.2 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

Provisioning of a new instance of CloudStreams Designer 10.2 or higher 

## Running as a composite template

1. To import the sag-designer-cloudstreams/template.yaml file in Command Central, use one of the methods described in [Importing templates library](https://github.com/SoftwareAG/sagdevops-templates/wiki/Importing-templates-library)
2. To apply the template, follow the instructions in [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)

### Example
To provision CloudStreams Designer on the installation with alias `dev1`:

```bash
sagcc exec templates composite apply sag-designer-cloudstreams nodes=dev1 \
  repo.product=products-10.2 \
  repo.fix=fixes-10.2 \
  --sync-job --wait 360
```
