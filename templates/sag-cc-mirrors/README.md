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
# Command Central Remote Mirrors Registration

Use this template to add remote mirror repositories for products and fixes. This template connects Command Central to the mirror repositories that already exist on a remote Platform Manager node.

## Requirements

Create administrator credentials for the Platform Manager hosting the mirrors by running the sag-cc-creds template:

```bash
sagcc exec templates composite apply sag-cc-creds \
  credentials.username=Administrator \
  credentials.password=manage \
  credentials.key=DEFAULT_ADMINISTRATOR \
  --sync-job --wait 360
```

For more information, see [sag-cc-creds](https://github.com/SoftwareAG/sagdevops-templates/tree/master/templates/sag-cc-creds).

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To add remote mirror repositories:

```bash
sagcc exec templates composite apply sag-cc-mirrors --sync-job --wait 360
```
