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
# Optimize Web Service Data Collector

Use this template to install Optimize Web Service Data Collector 10.1 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* Optimize Web Service Data Collector 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning Optimize Web Service Data Collector version 10.1 and higher
* Installing Optimize Web Service Data Collector latest fixes
* Adding basic Optimize Web Service Data Collector configuration

## Example how to run the composite template

To provision a default instance of Optimize Web Service Data Collector:

```bash
sagcc exec templates composite apply sag-optimize-wsdc nodes=optimize \
   repo.product=optimize repo.fix=Empower \
   --sync-job --wait 360
```