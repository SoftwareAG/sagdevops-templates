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

# Building Microservices Runtime container image

Use this template to build a Microservices Runtime container image.

## Requirements and limitations

### Supported Software AG releases

* Microservices Runtime 10.5 or higher
* Command Central 10.5 or higher

### Supported platforms

* Docker 18.06-ce or higher

## Building Docker image

### Building using docker-compose

Build the container image only with Microservices Runtime:

```bash
cd sagdevops-templates/containers
CC_TAG=10.5 TAG=10.5 docker-compose build microservices-runtime
```

Build the container image with Microservices Runtime and a layered product (for example, WmSAP):

```bash
cd sagdevops-templates/containers
CC_TAG=10.5 TAG=10.5 PRODUCTS=[MSC,WmSAP] docker-compose build microservices-runtime
```

Run the container:

```bash
CC_TAG=10.5 TAG=10.5 docker-compose up microservices-runtime
docker-compose port microservices-runtime 5555
```

Open Microservices Runtime in the browser using the port printed above:

```bash
http://localhost:PORT
```

Login as `Administrator/manage`

Examine the configuration.
