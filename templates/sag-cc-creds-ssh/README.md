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
# Command Central credentials for SSH public key authentication

Use this template to configure the credentials alias for SSH public key authentication 
that Command Central uses when accessing remote hosts. 

## Requirements

None.

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

To configure the SSH credentials and set the SSH credentials alias:

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
* Click the **+** icon and select the **Username and password** type from the menu.
* Fill in the required fields, including the password and save the configuration.
* Click the alias of the new configuration and then **Export**.
* Use the encrypted value of the `Password:` property.

Store the encrypted password in a YAML or properties file, which you can add to a version control system.