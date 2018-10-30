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

# Configuring Proxy Settings for Platform Manager

With this template you can configure HTTP and HTTPS proxy configuration on existing Platform Manager nodes.

## Requirements and limitations

### Supported Software AG releases

* Command Central 10.1 and higher
* Platform Manager 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Running as a standalone Composite Template on Windows

To configure proxy configuration on the `local` Platform Manager:

```bash
sagcc exec templates composite apply sag-spm-proxy proxy.http.host=proxyhost  \
  proxy.http.port=8080 \
  --sync-job --wait 360
```

> IMPORTANT: If you use Command Central 10.1 you have to monitor the job completion with a separate command:

```bash
sagcc exec templates composite apply sag-spm-proxy proxy.http.host=proxyhost  \
  proxy.http.port=8080
sagcc list jobmanager jobs <jobIdFromAboveCommand> --wait 360 -e DONE
```