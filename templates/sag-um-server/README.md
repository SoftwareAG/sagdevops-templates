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
# Universal Messaging Realm Server

Use this template to provision, maintain, upgrade and migrate Universal Messaging Realm Server
as well as create Docker images

## Requirements

### Supported Software AG releases

* Universal Messaging 9.8 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 9.8 or higher environments
* Installing latest fixes and support patches
* In-place upgrades to 9.12 or higher
* Cross-host migrations to 9.12 or higher
* Configuration of:
  * License
  * JVM memory
  * NHP and JMX ports
* Building docker images for 10.x releases

## Provisioning of new server instance

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli) for additional information about applying templates.

Provision `default` instance of Universal Messaging Realm 10.1 server with all latest fixes,
listening on default ports 9000 and 9988 (jmx), with 512mb of memory:

```bash
sagcc exec templates composite apply sag-um-server nodes=dev1 \
  um.memory.max=512 \
  repo.product=webMethods-10.1 \
  repo.fix=Empower \
  --sync-job --wait 360
```

## Creating a new stack with Universal Messaging layer using Web UI

Consult [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui)
for additional information about using Stacks UI.

* Open Stacks UI
* Add new stack by clicking `(+)` icon
* Add new Infrastructure layer
* Add new Runtime layer
  * Select UM-SERVER layer definition
  * Select product and fix repositories
  * Select exactly one node on which to provision Universal Messaging Realm server
  * Review and adjust optional parameters as needed
  * Finish the wizard
* Wait until provision jobs completes. Use Jobs view to monitor

## Building Docker image using Command Central Docker builder

Consult [Building Docker images](https://github.com/SoftwareAG/sagdevops-templates/wiki/Building-default-Docker-images)
for additional informatino about building Docker images.

Build Docker image for Universal Messaing Realm Server 10.2 release with all the latest fixes, using your custom Command Central Docker builder image:

```bash
docker build \
  --build-arg BUILDER_IMAGE=commandcentral-builder \
  --build-arg __um_fixes=ALL \
  -t universal-messaging .
```

## Running containers

### Using Docker

Use the following content for the `docker-compose.yml` file, then run `docker-compose up`.

```yaml
version: '3'
services:
  um:
    image: universal-messaging
    ports:
      - '9000:9000'
```

Or you can use `docker run` directly:

```shell
docker run \
  --name um \
  -p 9000:9000 \
  -d \
  universal-messaging
```

Universal Messaing Realm Server is accessible on port 9000.

### Using Kubernetes

Copy the following content to `pod.yaml` file, and run `kubectl create -f pod.yaml`.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: um
  labels:
    name: um
spec:
  containers:
    - image: universal-messaging
      name: um
```
