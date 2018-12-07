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
# Command Central Public Product and Fix Master Repositories

Use this template to add Software AG product and fix repositories for all officially supported releases.

## Requirements

Create Empower credentials by running the sag-cc-creds template:

```bash
sagcc exec templates composite apply sag-cc-creds \
  credentials.username=yourusername \
  credentials.password=yourpassword \
  credentials.key=EMPOWER \
  --sync-job --wait 360
```

For more information, see [sag-cc-creds](https://github.com/SoftwareAG/sagdevops-templates/tree/master/templates/sag-cc-creds).


### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To add Software AG product and fix repositories for all officially supported releases:

```bash
sagcc exec templates composite apply sag-cc-repos --sync-job --wait 360
```
