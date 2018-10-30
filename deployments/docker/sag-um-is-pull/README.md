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

# Universal Messaging and Integration Server managed containers asset deployment

Use this template to run containers and deploy configuration and code assets to the containers from the asset repository using pull model for the following runtimes:

* [Integration Server managed container](../../containers/microservices-runtime/Dockerfile)
* [Universal Messaging Server managed container](../../universal-messaging/Dockerfile)

> IMPORTANT: this feature requires *managed* container images

## Requirements

### Supported Software AG releases

* Universal Messaging 10.3
* Integration Server 10.3
* Platform Manager 10.3
* Command Central 10.3

### Supported platforms

* Docker 17.09+
* Managed container images built with Command Central Docker builder

### Supported use cases

* Running Universal Messaging and Integration Server containers
* Configuring the containers using the pull model from asset repository (git) by Platform Managers

## Launching integration stack using docker-compose and deploying assets from a repository

> IMPORTANT: if you run the stacks on a machine different from where you built container images, point to a remote Docker registry that contains the images

For example:

```bash
export REG=my.docker.registry:4443/softwareag
```

or

```bash
export REG=daerepository03.eur.ad.sag:4443/sagdevops
export CC_REG=daerepository03.eur.ad.sag:4443/ccdevops
```

Optionally, launch [Command Central Stack](../sag-cc/) first.
Command Central is not required but useful for monitoring and troubleshooting of the deployment process.
If you do not want to use Command Central, set auto-registration off:

```bash
export CC_AUTO_REGISTER=0
```

Launch Universal Messaging and Integration Server containers and point to two asset repositories
that include configuration and code assets for Universal Messaging and Integration Server respectively.

For example:

```bash
export IS_ASSET_REPO_URL=http://irepo/scm/devops/wmic-asset-repo-is.git
export UM_ASSET_REPO_URL=http://irepo/scm/devops/wmic-asset-repo-um.git

docker-compose up -d
```

Browse to [Command Central Web UI](https://localhost:8091/) and login (Administrator/manage)
Verify Universal Messaging and Integration Server containers have assets from the above repositories as initial deployment.

## Deploying configuration changes

Clone asset (git) repositories and make local changes.
For example, for Universal Messaging repository:

```bash
cd ~
git clone $UM_ASSET_REPO_URL um-repo
cd um-repo/CC
```

Edit an .acdl file and modify any property value that needs changes:

```xml
    <property name="..." many="false" isSecure="false" displayName="...">
        <value>some value - modify me</value>
    </property>
```

Or make changes to the configuration template.yaml within the configuration asset .zip file.

Commit and push the changes to the repository:

```bash
git commit -am "config changes"
git push
```

Observe the changes are automatically deployed to the running Universal Messaging container.

## Deploying code changes

Clone asset (git) repositories and make local changes.
For example, for Integration Server repository:

```bash
cd ~
git clone $IS_ASSET_REPO_URL is-repo
cd is-repo/IS
```

Edit an .acdl file and modify any property value or update the asset .zip

```xml
    <property name="..." many="false" isSecure="false" displayName="...">
        <value>some value - modify me</value>
    </property>
```

Commit and push the changes

```bash
git commit -am "code changes"
git push
```

Observe the code changes are automatically deployed to the Integration Server container
