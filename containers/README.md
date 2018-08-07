<!-- Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors

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

# Command Central Docker Builder generic Dockerfile

EXPERIMENTAL: Build a basic docker image for any product that provides a template.yaml in this project.

For example, to build webMethods Microservices Runtime (sag-msc-server) 10.1 with latest fix level run:

```bash
docker build \
    --build-arg TAG=10.1 \
    --build-arg TEMPLATE=sag-msc-server \
    --build-arg PORT=5555 \
    --build-arg ENTRYPOINT=profiles/IS_default/bin/console.sh \
    -t softwareag/msc:10.1 \
    .
```

## Supported customizations

The customizatinos are supported via --build-arg parameters for the `docker build` :

* TAG - 10.3, 10.2, 10.1 - target release for which you'd like to build the image, default 10.3
* TEMPLATE - template alias from this project, default sag-spm-config
* PORT - runtime port to expose, default 8092
* ENTRYPOINT - main runtime entrypoint, default profiles/SPM/bin/console.sh
