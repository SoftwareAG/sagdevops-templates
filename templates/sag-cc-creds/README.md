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
# Command Central Credentials for Basic Authentication

Use this template to configure user credentials that Command Central uses when connecting to managed products using basic authentication. You can also use the template to define a credentials key alias for the user credentials used for basic authentication.

## Requirements

None.

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To configure credentials that Command Central uses for basic authentication for a user with username "myuser", password "secret", and credentials key alias "MY_USER":

```bash
sagcc exec templates composite apply sag-cc-creds \
  credentials.username=myuser \
  credentials.password=secret \
  credentials.key=MY_USER \
  --sync-job --wait 360
```
