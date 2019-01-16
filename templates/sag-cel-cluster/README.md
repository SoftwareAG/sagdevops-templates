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



# Internal Data Store



Use this template to provision and maintain Internal Data Store.



## Requirements and limitations



None.



### Supported Software AG releases



* Internal Data Store 10.1 and higher

* Command Central 10.3 or higher



### Supported platforms



All supported Windows and UNIX platforms.



### Supported use cases



* Provisioning of new 10.1 and higher environments

* Installing latest fixes

* Configuration of:

  * Cluster if 2 or 3 nodes are specified
  
  * Custom properties required for functioning cluster if 2 or 3 nodes are specified



## Using the template to provisioning a new Internal Data Store product and configure a cluster up to 3 nodes



For information about applying templates, see [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli).



To provision Internal Data Store on one node with all latest fixes:



```bash

sagcc exec templates composite apply sag-cel-cluster nodes=node \

  repo.product=webMethods-10.3 \

  repo.fix=Empower \

  --sync-job --wait 360

```



To provision Internal Data Store on 2 nodes with all latest fixes and configure them in a cluster:



```bash

sagcc exec templates composite apply sag-cel-cluster nodes=[dev1,dev2] \

  repo.product=webMethods-10.3 \

  repo.fix=Empower \

  --sync-job --wait 360

```
