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

# EntireX RPC Server for XML/SOAP

## Building container image

```
cd <home>/sagdevops-templates/containers
docker-compose build entirex-xml-rpc-server
```

## Running container image

### Configuring during Image Start, using Default File Names

Provide your configuration files with the default file names, for example:

```
<my-license-dir>/license.xml	(required)
<my-config-dir>/entirex.xmlrpcserver.properties	(required)
<my-config-dir>/entirex.xmlrpcserver.configuration.xml	(required)
<my-config-dir>/<myMapping>.xmm 	(required)
```

```
cd <home>/sagdevops-templates/containers>
docker run -d -v <my-license-dir>:/licenses 
              -v <my-config-dir>:/configs softwareag/entirex-xml-rpc-server:10.3
```

### Configuring during Image Start, using Custom File Names

Provide your configuration files with the default file names, for example:

```
cd <home>/sagdevops-templates/containers>
<my-license-dir>/myLicense.xml	(required)
<my-config-dir>/myConfiguration		(required)
<my-config-dir>/myWebServerConfiguration	(required)
<my-config-dir>/<myMapping>.xmm	(required)
```

```
cd <home>/sagdevops-templates/containers>
docker run -d -e "EXX_LICENSE_KEY=myLicense.xml" 
              -e "EXX_XML_SERVER_CONFIGURATION=myConfiguration" 
              -e "EXX_XML_SERVER_MAPPING=myWebServerConfiguration" 
              -v <my-license-dir>:/licenses 
              -v <my-config-dir>:/configs softwareag/entirex-xml-rpc-server:10.3
```

