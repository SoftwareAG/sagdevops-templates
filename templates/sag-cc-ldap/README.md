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
# Users, Roles, and Groups for an LDAP Directory and the Command Central Internal User Repository

Use this template to configure users, roles, and groups for:
- an external LDAP directory (including the LDAP domain parameter that helps Command Central determine whether to verify the user against the LDAP user store or the internal user repository)
- the Command Central internal user repository

## Requirements

None.

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To configure users, roles, and groups that Command Central uses to authenticate users and determine what permissions they have:

```bash
sagcc exec templates composite apply sag-cc-ldap --sync-job --wait 360
```