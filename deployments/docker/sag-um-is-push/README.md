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

# Small integration stack

Use this template to run containers and deploy configurations using Command Central templates for the following runtimes:

* [Universal Messaging Server](../../universal-messaging/Dockerfile)
* [Integration Server](../../containers/microservices-runtime/Dockerfile)

## Requirements

### Supported Software AG releases

* Universal Messaging 10.1 and higher
* Integration Server 10.3 and higher
* Command Central 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Running Universal Messaging and Integration Server containers
* Configuring the containers using the push deployment model from Command Central

## Launching integration stack using docker-compose

> IMPORTANT: if you run the stacks on a machine different from where you built container images, point to a remote Docker registry that contains the images

For example:

```bash
export REG=daerepository03.eur.ad.sag:4443/sagdevops
export CC_REG=daerepository03.eur.ad.sag:4443/ccdevops
```

### Launching containers with asset depoyment

Launch [Command Central Stack](../sag-cc/) first. It is required for configuration deployment.

Launch Universal Messaging and Integration Server containers and configure them using Command Central templates:

```bash
docker-compose run --rm init
```

Browse to [Command Central Web UI](https://localhost:8091/) and login (Administrator/manage)
Verify Universal Messaging and Integration Server containers are configured using these templates:

* [sag-um-config](../../../templates/sag-um-config/)
* [sag-is-config](../../../templates/sag-is-config/)
