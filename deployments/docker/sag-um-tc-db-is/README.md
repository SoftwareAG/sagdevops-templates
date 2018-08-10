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

# Integration Stack

UNDER DEVELOPMENT !!!

Use this template to provision stack with the following containers:

* SQL Server DB
* Universal Messaging Server 10.3 ([Dockerfile](../../sag-um-server/Dockerfile)
* Terracotta Big Memory Server 4.3 ([Dockerfile](../../sag-tc-server/Dockerfile)
* Integration Server 10.3 cluster ([Dockerfile](../../sag-is-statefull-cluster/Dockerfile)

## Requirements

### Supported Software AG releases

* Software AG DBP 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Provisioning of new 10.3 stack using Docker

## Launching integration stack using docker-compose

Launch [Command Central 10.3 Stack](../sag-cc/) first.

Launch DB and create schemas:

```bash
export CC_TAG=10.3
export TAG=10.3

docker-compose run --rm initdb
```

Launch containers and configure
them using Command Central templates (push model):

```bash
docker-compose up -d
```
