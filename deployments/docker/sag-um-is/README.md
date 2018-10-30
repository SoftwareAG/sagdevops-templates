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

Use this template to run managed or unmanaged containers stack with the following runtimes:

* Integration Server ([Dockerfile](../../containers/microservices-runtime/Dockerfile)
* Universal Messaging Server ([Dockerfile](../../universal-messaging/Dockerfile)

## Requirements

### Supported Software AG releases

* Universal Messaging 10.1 or higher
* Integration Server 10.1 or higher

### Supported platforms

* Docker 17.09+

### Supported use cases

* Running Universal Messaging and Integration Server containers

## Launching integration stack using docker-compose

> IMPORTANT: if you run the stacks on a machine different from where you built container images, point to a remote Docker registry that contains the images

For example:

```bash
export REG=daerepository03.eur.ad.sag:4443/sagdevops
export CC_REG=daerepository03.eur.ad.sag:4443/ccdevops
```

Launch Universal Messaging 10.3 and Integration Server 10.3 containers:

```bash
TAG=10.3 docker-compose up -d
```

Browse to [Integration Server Admin UI](http://localhost:5555) and login (Administrator/manage)
Manually configure Integration Server to point to Universal Messaging container listening at nsp://um01:9000

For automated configuration see:

* [Configuring containers using push deployment](../sag-um-is-push)
* [Configuring containers using pull deployment](../sag-um-is-pull)
