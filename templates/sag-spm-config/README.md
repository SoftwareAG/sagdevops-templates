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

# Platform Manager Configurations

Use this template to configure Platform Manager.

## Requirements and limitations

### Supported Software AG releases

* Platform Manager 9.8 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Configuration of:
  * Tanuki Java Service wrapper
  * Java System properties
  * Monitoring interval

## Running as a composite template

Apply custom configurations to Platform Managers, registered as `node1` and `node2`:

```bash
sagcc exec templates composite apply sag-spm-config nodes=node1,node2 \
    hello.world=spm \
    --sync-job --wait 360
```
