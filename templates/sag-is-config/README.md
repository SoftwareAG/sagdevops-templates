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
# Configuring webMethods Integration Server and Microservices Runtime

Use this template to configure webMethods Integration Server and Microservices Runtime

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)
for general information about applying templates.

## Requirements

### Supported Software AG releases

* Command Central 10.2 and higher
* webMethods Integration Server 9.6 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported configurations

* Messaging connections
* JNDI and JMS connections

## Configuring Integration Server

> IMPORTANT: this template must be applied on top of _existing_ Integration Server instance

### Configure Messaging connections

```bash
sagcc exec templates composite apply sag-is-config \
  nodes=node \
  is.configs=messaging
  is.instance.name=default \
  is.um.url=nsp://um01:9000 \
  is.um.enabled=true \
  is.um.jms.enabled=true \
  --sync-job
```

### Configure JNDI and JMS connections

```bash
sagcc exec templates composite apply sag-is-config \
  nodes=node \
  is.configs=jndi-jms
  is.instance.name=default \
  is.um.jndi.alias=DEFAULT_IS_JNDI_PROVIDER \
  is.um.jms.enabled=true \
  is.um.jms.alias=DEFAULT_IS_JMS_CONNECTION \
  is.um.jms.enabled=true \
  is.um.jms.cf.name=cf \
  --sync-job
```
