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

Use this template to provision and configure containers stack with the following runtimes:

* Integration Server 10.3 ([Dockerfile](../../sag-is-server/Dockerfile)
* Universal Messaging Server 10.3 ([Dockerfile](../../sag-um-server/Dockerfile)

## Requirements

### Supported Software AG releases

* Universal Messaging 10.3
* Integration Server 10.3
* Platform Manager 10.3
* Command Central 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Provisioning 10.3 UM and IS containers
* Configuring UM and IS using push model (from CC)

## Launching integration stack using docker-compose

Launch [Command Central 10.3 Stack](../sag-cc/) first.

Launch Universal Messaging 10.3 and Integration Server 10.3 containers and configure
them using Command Central templates (push model):

```bash
CC_TAG=10.3 TAG=10.3 docker-compose up -d
```

Browse to http://localhost:5555 to open Integration Server Admin UI. Login (Administrator/manage)
