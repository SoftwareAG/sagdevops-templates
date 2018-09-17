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
* Building a Docker image with configured Platform Manager

## Running as a composite template

To apply custom configurations to two Platform Managers, registered as node1 and node2:

```bash
sagcc exec templates composite apply sag-spm-config nodes=node1,node2 \
  hello.world=spm \
  --sync-job --wait 360
```

## Building Docker image

You can build a Docker image with a custom Platform Manager configuration, where you can provide the configuration values by:

* Hardcoding them in the template.
* Defining them as parameters in an [env.properties](env.properties) file.
* Defining them as build arguments in Dockerfile and docker-compose.yml file. See `__hello_world`.
* Defineing them in the template as ENV variables resolved at container startup. See `%HELLO_NAME%`.

To build a Docker image with custom Platform Manager configuration:

```bash
docker-compose build
```

To run the container:

```bash
docker-compose up -d node
```

To open Platform Manager in the browser:

```bash
open http://`docker-compose port node 8092`/spm
```

Login as `Administrator/manage`.
