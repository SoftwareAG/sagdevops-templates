<!--
 Copyright (c) 2011-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc.,
 Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

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
# Command Central SSH credential keys configuration examples

Use this template to configure credentials for accessing remote hosts for SSH private key authentication type

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

Configure SSH credentials:

```bash
sagcc exec templates composite apply sag-cc-creds-ssh \
ssh.credentials.alias=mysshkey \
ssh.credentials.username=mysshuser \
ssh.credentials.key.path=/home/user/id_rsa \
ssh.credentials.key.password=mysshkeypassword \ 
--sync-job --wait 20 -c 5
```  

## Encrypting passwords

* Open the Command Central web user interface.
* Navigate to CCE > Command Central > Configurations > Credentials.
* Click the **+** icon and select **Username and password** type from the menu.
* Fill in the required fields, including password and save the configuration.
* Click on the newly created configuration and click **Export**.
* Use the encrypted value of the `Password:` property.

The encrypted password can be stored in a YAML file, or a properties file and added to a version control system.
