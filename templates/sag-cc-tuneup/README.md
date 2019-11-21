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
# Command Central and Platform Manager Server System Properties

Use the template to configure system properties for Command Central and Platform Manager that modify the server behavior during operations, such as bootstrapping, installing products, or creating repositories.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To set up server system properties for Command Central and Platform Manager:

```bash
sagcc exec templates composite apply sag-cc-tuneup --sync-job --wait 360
```

> IMPORTANT: If you use Command Central 10.1 you have to monitor the job completion with a separate command, instead of the `--sync-job` option:

```bash
sagcc list jobmanager jobs <jobIdFromAboveCommand> --wait 360 -e DONE
```