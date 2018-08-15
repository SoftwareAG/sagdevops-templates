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

# Command Central builder repositories registration

This template demonstrates show to configure different types
of repositories for Command Central Builder:

* Public master repositories hosted on Empower SDC
* Private mirror repositories hosted on Platform Managers
* Internal mirror repositories hosted on SAG AQU servers

## Requirements

### Supported Software AG releases

* Command Central 10.3 or later

### Supported platforms

* All support platforms

## Configuring Public master repositories hosted on Empower SDC

Configure Empower SDC credentials first:

```bash
sagcc exec templates composite apply sag-cc-creds \
    credentials.username=you@company.com credentials.password=**** credentials.key=EMPOWER \
    --sync-job
```

Disover available product repositories on Empower SDC:

```bash
sagcc list repository products discover properties="version,location"
Version	Location
9.8    	https://sdc.softwareag.com/dataservewebM98/repository/
9.10   	https://sdc.softwareag.com/dataservewebM910/repository/
10.0   	https://sdc.softwareag.com/dataservewebM100/repository/
10.1   	https://sdc.softwareag.com/dataservewebM101/repository/
9.9    	https://sdc.softwareag.com/dataservewebM99/repository/
9.12   	https://sdc.softwareag.com/dataservewebM912/repository/
10.2   	https://sdc.softwareag.com/dataservewebM102/repository/
```

Configure Empower SDC `products` and `fixes` repositories pointing to
the target release repository, for example, 10.2 release:

```bash
sagcc exec templates composite apply sag-cc-builder-repos \
    repo.product.url=http://sdc.softwareag.com/dataservewebM102/repository \
    repo.product.credentials.key=EMPOWER \
    fix.product.credentials.key=EMPOWER \
    --sync-job
```

## Configuring private mirror repositories hosted on Platform Manager

Configure mirror hosting Platform Manager credentials first:

```bash
sagcc exec templates composite apply sag-cc-creds \
    credentials.username=Administrator credentials.password=**** credentials.key=MIRROR \
    --sync-job
```

List available mirror product repositories managed through unstream Command Central
listening at https://upstreamCC:8091/cce :

```bash
sagcc list repository products properties=type,version,location -s upstreamCC | grep MIRROR
MIRROR	10.2   	https://MIRRORSPMHOST:8093/products-10.2/repository

sagcc list repository fixes properties=type,version,location -s upstreamCC | grep MIRROR
MIRROR	10.2   	http://MIRRORSPMHOST:8092/fix-fixes-10.2/repository
```

Configure `products` and `fixes` repositories pointing to
the mirror repositories from the above locations:

```bash
sagcc exec templates composite apply sag-cc-builder-repos \
    repo.product.url=https://MIRRORSPMHOST:8093/products-10.2/repository \
    repo.product.credentials.key=MIRROR \
    repo.fix.url=http://MIRRORSPMHOST:8092/fix-fixes-10.2/repository \
    repo.fix.credentials.key=MIRROR \
    --sync-job
```

## Configuring internal mirror repositories hosted on SAG AQU server

> IMPORTANT: you must have acesss to SAG network to access these repositories

Configure internal credentials first:

```bash
sagcc exec templates composite apply sag-cc-creds-dev --sync-job
```

Configure `products` and `fixes` repositories pointing to
the mirror repositories from the above locations:

```bash
sagcc exec templates composite apply sag-cc-builder-repos \
    repo.product.url=http://aquarius-bg.eur.ad.sag/dataserveCC_PI_103oct2018/repository \
    repo.product.credentials.key=REPO-PRODUCT \
    repo.fix.url=http://aquarius-va.ame.ad.sag/updates/QARepo \
    repo.fix.credentials.key=REPO-FIX \
    --sync-job
```
