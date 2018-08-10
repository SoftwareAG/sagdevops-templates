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

# Monitoring stack using Prometheus and Grafana on Docker

Use these deployment scripts to launch [Prometheus](https://hub.docker.com/r/prom/prometheus/)
and [Grafana](https://hub.docker.com/r/grafana/grafana) containers
with dashboards integrated with Command Central 10.3
basic monitoring REST API.

## Requirements

### Supported Software AG releases

* Command Central 10.3 or higher

### Supported platforms

* Docker 17.09+

### Supported use cases

* Monitoring dashbards using Command Central monitoring REST API

## Launching monitoring stack using docker-compose

Launch [Command Central 10.3](../sag-cc/) first.

Launch Prometheus and Grafana stack:

```bash
docker-compose up -d
```

Browse to [http://localhost:3000](http://localhost:3000) to open Grafana Web UI. Login as admin/admin.
