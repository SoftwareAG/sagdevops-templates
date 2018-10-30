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

# Building Hello World container image

Use this template to build a simple hello-world container image.

## Requirements and limitations

### Supported Software AG releases

* Platform Manager 10.1 or higher
* Command Central 10.3 or higher

### Supported platforms

* Docker 18.06-ce or higher

### Supported use cases

* Building a Docker image with configured Platform Manager

## Building Docker image

### Building using docker-compose

Build the container image:

```bash
cd sagdevops-template/containers
docker-compose build hello-world
```

Run the container:

```bash
docker-compose up -d hello-world
docker-compose port hello-world 8092
```

Open Platform Manager in the browser using the address printed above:

```bash
open http://localhost:PORT/spm
```

Login as `Administrator/manage`

Examine the configuration.

### Parameterizing configuration

You can provide the configuration values by:

* Hardcoding them in the template.
* Defining them as parameters in an [env.properties](env.properties) file.
* Defining them as build arguments in [Dockerfile](Dockerfile) and [docker-compose.yml](../docker-compose.xml) file. See `__hello_world`.
* Defining them in the template as ENV variables resolved at container startup. See `%HELLO_NAME%`
