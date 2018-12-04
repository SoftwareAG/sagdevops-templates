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
# Internal Repositories for the Command Central Docker Builder

Use this template to add internal product, fix, and asset repositories (located inside the Software AG network) to use with the Command Central Docker builder when building images for internal development or testing.

## Requirements

None.

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To add internal product, fix, and asset repositories to use with Command Central Docker builder:

```bash
sagcc exec templates composite apply sag-cc-builder-dev --sync-job --wait 360
```
