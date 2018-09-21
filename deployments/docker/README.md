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

# Deployments on Docker

Launch various stacks using Docker.

## Requirements

### Supported platforms

These deployments were tested with:

* Docker 18.06-ce

## Quick start

1. Build infrastructure images as described [here](../../infrastructure)
2. Build product images as described [here](../../containers/)
3. Launch [Command Central stack](sag-cc)
4. Launch [Prometheus monitoring stack](prometheus)
5. Launch [Universal Messaging and Integration Server stack](sag-um-is)
