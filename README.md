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

# Command Central Default Templates Library

Please see [Default Templates Library wiki](https://github.com/SoftwareAG/sagdevops-templates/wiki) for details.

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
______________________

Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
______________________

## Default Micro Templates Reference

The following tables describe the default micro templates available in this library.

### Infrastructure Micro Templates

The following table lists the default infrastructure micro templates and describes what they provision.

Template alias | Provisions Platform Manager
-------------------------|--------------------------------
[hello-world](templates/hello-world) | Hello world example
[sag-spm-boot-local](templates/sag-spm-boot-local) | on the same host as Command Central
[sag-spm-boot-ssh](templates/sag-spm-boot-ssh) | on remote UNIX hosts using SSH protocol
[sag-spm-boot-winrm](templates/sag-spm-boot-winrm) | on remote Windows hosts using the native Windows remote protocol
[sag-spm-connect](templates/sag-spm-connect) | connects to existing Platform Manager nodes

### Micro Templates for creating database components

Template alias | Description
-------------------------|--------------------------------
[sag-db-oracle](templates/sag-db-oracle) | Creates a user, database, and webMethods database schemas on an Oracle database server.
[sag-db-sqlserver](templates/sag-db-sqlserver) | Creates a user, database, and webMethods database schemas on an SQL Server database server.

### Micro Templates for provisioning Software AG products

The following table lists the run-time micro templates for Software AG products.

Template alias | Provisions
-------------------------|--------------------------------
[sag-abe](templates/sag-abe) | Asset Build Environment
[sag-apama-correlator](templates/sag-apama-correlator) | Apama correlator instance
[sag-des](templates/sag-des) | Digital Event Services
[sag-des-config](templates/sag-des-config) | Digital Event Services configuration
[sag-designer-services](templates/sag-designer-services) | Designer Service Development
[sag-designer-cloudstreams](templates/sag-designer-services) | Designer Cloudstreams Development
[sag-exx-broker](templates/sag-exx-broker) | EntireX Broker
[sag-exx-c-rpc-server](templates/sag-exx-c-rpc-server) | EntireX C RPC server
[sag-exx-java-rpc-server](templates/sag-exx-java-rpc-server) | EntireX Java RPC server
[sag-exx-xml-rpc-server](templates/sag-exx-xml-rpc-server) | EntireX XML RPC server
[sag-infradc](templates/sag-infradc) | Infrastructure Data Collector
[sag-is-server](templates/sag-is-server) | webMethods Integration Server instance
[sag-is-cluster](templates/sag-is-cluster) | webMethods Integration Server stateless cluster
[sag-is-statefull-cluster](templates/sag-is-statefull-cluster) | webMethods Integration Server statefull cluster
[sag-is-config](templates/sag-is-config) | webMethods Integration Server configurations
[sag-is-cloudstreams](templates/sag-is-applatform) | Cloudstreams on Integration Server or Microservices runtime
[sag-is-applatform](templates/sag-is-applatform) | Application Platform on Integration Server or Microservices runtime
[sag-msc-server](templates/sag-msc-server) | webMethods Microservices Runtime
[sag-mws-server](templates/sag-mws-server) | My webMethods server
[sag-mws-infradc](templates/sag-mws-server) | Infrastructure Data Collector UI on My webMethods server
[sag-tc-server](templates/sag-tc-server) | Terracotta BigMemory server
[sag-tc-cluster](templates/sag-tc-cluster) | Terracotta BigMemory cluster
[sag-tdb-server](templates/sag-tdb-server) | Terracotta DB server
[sag-um-server](templates/sag-um-server) | Universal Messaging server
[sag-um-cluster](templates/sag-um-cluster) | Universal Messaging cluster
[sag-um-config](templates/sag-um-config) | Universal Messaging configuration

### Micro Templates for configuring Command Central and Platform Manager

The following table lists the micro templates for configuring Command Central and Platform Manager.

Template alias | Description
-------------------------|--------------------------------
[sag-cc-builder-repos](templates/sag-cc-builder-dev) | Configures product and fix repositories for Docker builder
[sag-cc-creds-dev](templates/sag-cc-creds-dev) | Configures different types of credentials.
[sag-cc-creds](templates/sag-cc-creds) | Configures default outbound credentials for Command Central.
[sag-cc-layer-defs](templates/sag-cc-layer-defs) | Creates Software AG layer type definitions for Stacks API and UI
[sag-cc-ldap](templates/sag-spm-boot-local) | Configures Command Central LDAP connection and sample users, groups and roles.
[sag-cc-mirrors](templates/sag-cc-mirrors) | Registers remote mirrors.
[sag-cc-repos](templates/sag-cc-repos) | Configures master repositories hosted on Empower SDC.
[sag-cc-repos-asset](templates/sag-cc-repos-asset) | Configures a sample asset repository.
[sag-cc-tuneup](templates/sag-cc-tuneup) | Configures Command Central and Platform Manager for tuning and troubleshooting.
[sag-spm-config](templates/sag-spm-config) | Configures Platform Manager.
[sag-spm-proxy](templates/sag-spm-proxy) | Configures proxy settings for Platform Manager.
[sag-update](templates/sag-update) | Installs the latest fixes.

## Default Docker Images Reference

The following table lists the default Docker images.

Docker image | Description
-------------------------|--------------------------------
[hello-world](containers/hello-world) | Hello World example
[asset-builder](containers/asset-builder) | webMethods Asset builder (ABE)
[cloud-streams](containers/cloud-streams) | Cloudstreams on Microservices runtime
[entirex-broker](containers/entirex-broker) | Entire X Broker
[entirex-java-rpc-server](containers/entirex-java-rpc-server) | Entire Java RPC server
[entirex-xml-rpc-server](containers/entirex-xml-rpc-server) | Entire XML RPC server
[integration-server](containers/integration-server) | webMethods Microservices runtime and Integration Server
[terracotta-server](containers/terracotta-server) | Terracotta BigMemory server
[universal-messaging](containers/universal-messages) | Universal Messaging server
