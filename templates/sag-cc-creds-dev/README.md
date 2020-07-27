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
# Command Central credential keys configuration examples

Use this template to configure credentials for accessing repositories and remote hosts. The following authentication types are available:

* Basic username/password authentication type.
* SSH private key authentication type. Note that Command Central supports only the PKCS #1 definition of the ASN.1 syntax for representing the SSH private keys.
* Encrypted passwords.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone composite template

Configure credentials:

```bash
sagcc exec templates composite apply sag-cc-creds-dev cc.password=mycustompass --sync-job --wait 20 -c 5
```

## Encrypting passwords

Run the 'sagcc exec security encrypt' command in the Command Central CLI specifying the password to encrypt. Use the encrypted password value that the CLI returns.

Alternatively, in the Command Central web user interface:
1. Navigate to CCE > Command Central > Configurations > Credentials.
2. Click the **+** icon and select **Username and password** type from the menu.
3. Fill in the required fields, including password and save the configuration.
4. Click on the newly created configuration and click **Export**.
5. Use the encrypted value of the `Password:` property.

The encrypted password can be stored in a YAML file, or a properties file and added to a version control system.
