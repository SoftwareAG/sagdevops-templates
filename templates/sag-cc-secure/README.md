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
# Secure connections in Command Central and Platform Manager

Use this template to configure secure connections (local and remote) in Command Central and Platform Manager.
- The HTTPS port of Command Central using a custom keystore certificate
- The HTTPS port of Platform Manager using a custom keystore certificate
- Command Central SSL connection using custom Truststore certificate
- Platform Manager SSL connection using custom Truststore certificate

## Requirements

While applying this template the node which is going to be configured should be registered in Command Central using its HTTP port

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To configure secure connections custom certificates in Command Central and local Platform Manager:

```bash
sagcc exec templates composite apply sag-cc-secure \
spm.https.keystore.location=${user.home}/secure/KEY-CCE-SPM.jks \
spm.https.keystore.password=mySPMKeystorePass \
spm.https.key.alias=mySPMKeystoreAlias \
spm.truststore.location=${user.home}/secure/TRUST-SPM.jks \
spm.truststore.password=mySPMTrustorePass \
cce.https.keystore.location={user.home}/secure/KEY-CCE.jks \
cce.https.keystore.password=myCCEKeystorePass \
cce.https.key.alias=myCCEKeystoreAlias \
cce.truststore.location=${user.home}/secure/TRUST-CCE.jks \
cce.truststore.password=myCCETrustorePass \
--sync-job --wait 360
```
