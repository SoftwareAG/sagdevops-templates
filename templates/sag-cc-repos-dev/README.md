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
# Command Central Internal CD Product and Fix Repositories

Only for internal use. With this template, you can add the development or testing sandboxes, located on the Software AG internal install servers, as product and fix repositories in Command Central.

## Requirements

Configure custom credentials by running the sag-cc-creds-dev template:

```bash
sagcc exec templates composite apply sag-cc-creds-dev cc.password=mycustompass --sync-job --wait 20 -c 5
```

For more information, see [sag-cc-creds-dev](https://github.com/SoftwareAG/sagdevops-templates/tree/master/templates/sag-cc-creds-dev).

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To add internal sandboxes with product and fix builds as repositories in Command Central:

```bash
sagcc exec templates composite apply sag-cc-repos-dev --sync-job --wait 360
```
