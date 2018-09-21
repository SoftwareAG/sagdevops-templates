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

# Building Universal Messaging container image

Use this template to build a Universal Messaging container image.

## Requirements and limitations

### Supported Software AG releases

* Universal Messaging 10.3 or higher
* Command Central 10.3 or higher

### Supported platforms

* Docker 18.06-ce or higher

## Building Docker image

### Building using docker-compose

Build the container image:

```bash
cd sagdevops-template/containers
docker-compose build universal-messaging
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
