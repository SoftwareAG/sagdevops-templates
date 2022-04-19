<!-- Copyright 2013 - 2020 Software AG, Darmstadt, Germany and/or its licensors

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

# Universal Messaging Remote Channel Join

> STATUS: INCUBATING

Use this template to create a channel with an outgoing join to a channel on a remote realm.

## Requirements

### Supported Software AG releases

* Universal Messaging 10.1 and higher
* Command Central 10.3 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Creation of a channel, that has a join to a remote channel, on Universal Messaging realm server


## Channel with join creation

For information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).

To create a channel `c1`, on Universal Messaging instance `umserver`, that has an outgoing join to an already existing channel `c2` on Universal Messaging instance `umserver2` listening on port `9100`.

```bash
sagcc exec templates composite apply sag-um-config-join
```
