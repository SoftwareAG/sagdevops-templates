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

# EntireX Broker 

## Building container image

```
cd <home>/sagdevops-templates/containers
docker-compose build entirex-broker
```

## Running container image

### Configuring during Image Start, using Default File Names

Provide your configuration files with the default file names, for example:

```
<my-license-dir>/license.xml	(required)
<my-config-dir>/etbfile		(optional)
<my-config-dir>/exxAppCert.pem	(optional)
<my-config-dir>/exxAppKey.pem	(optional)
<my-config-dir>/exxCACert.pem	(optional)
```

```
cd <home>/sagdevops-templates/containers>
docker run -d -p 2001:1971 
	-v <my-license-dir>:/licenses 
	-v <my-config-dir>:/configs softwareag/entirex-broker:10.3
```

### Configuring during Image Start, using Custom File Names

Provide your configuration files with the default file names, for example:

```
<my-license-dir>/myLicense.xml		(required)
<my-config-dir>/myEtbfile		(optional)
<my-config-dir>/myExxAppCert.pem	(optional)
<my-config-dir>/myExxAppKey.pem		(optional)
<my-config-dir>/myExxCACert.pem		(optional)
```

```
cd <home>/sagdevops-templates/containers>
docker run -d -p 2001:1971 
	-e "EXX_ATTRIBUTE=myEtbfile" 
	-e "EXX_LICENSE_KEY=myLicense.xml" 
	-e "EXX_KEY_FILE=myExxAppKey.pem" 
	-e "EXX_KEY_STORE=myExxAppCert.pem" 
	-e "EXX_TRUST_STORE=myExxCACert.pem" 
	-v <my-license-dir>:/licenses 
	-v <my-config-dir>:/configs softwareag/entirex-broker:10.3
```

