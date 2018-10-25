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

# EntireX RPC Server for Java

## Building container image

```
cd <home>/sagdevops-templates/containers
docker-compose build entirex-java-rpc-server
```

## Running container image

### Configuring during Image Start, using Default File Names

Provide your configuration files with the default file names, for example:

```
<my-license-dir>/license.xml				(required)
<my-config-dir>/entirex.javarpcserver.properties	(required)
<my-data-dir>/<custom classes>				(required)
```

```
cd <home>/sagdevops-templates/containers>
docker run -d -v <my-license-dir>:/licenses 
              -v <my-config-dir>:/configs 
              -v <my-data-dir>:/data softwareag/entirex-java-rpc-server:10.3
```

### Configuring during Image Start, using Custom File Names

Provide your configuration files with the default file names, for example:

```
<my-license-dir>/myLicense.xml				(required)
<my-config-dir>/my.entirex.javarpcserver.properties	(required)
<my-data-dir>/<custom jar file>				(required)
```

```
cd <home>/sagdevops-templates/containers>
docker run -d -e "EXX_LICENSE_KEY=myLicense.xml" 
              -e "EXX_JAVA_SERVER_CONFIGURATION=my.entirex.javarpcserver.properties" 
              -e "EXX_JAVA_SERVER_CLASSPATH=/data/custom.jar" 
              -v <my-license-dir>:/licenses 
              -v <my-configuration-dir>:/configs 
              -v <my-data-dir>:/data softwareag/entirex-java-rpc-server:10.3
```

