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
For more information you can Ask a Question in the [TECHcommunity Forums](http://techcommunity.softwareag.com/home/-/product/name/command-central).

You can find additional information in the [Software AG TECHcommunity](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=command-central).
______________________

Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
______________________

## Default Micro Templates Reference

The following tables describe the default micro templates available in this library.

### Infrastructure Micro Templates

The following table lists all stable infrastructure micro templates and describes what they provision.

Template alias | Provisions Platform Manager
-------------------------|--------------------------------
[hello-world](templates/hello-world) | Hello world example
[sag-spm-boot-local](templates/sag-spm-boot-local) | on the same host as Command Central
[sag-spm-boot-ssh](templates/sag-spm-boot-ssh) | on remote UNIX hosts using SSH protocol
[sag-spm-boot-winrm](templates/sag-spm-boot-winrm) | on remote Windows hosts using the native Windows remote protocol
[sag-spm-connect](templates/sag-spm-connect) | connects to existing Platform Manager nodes

### Micro Templates for creating database components

The following table lists all stable micro templates for creating database components.

Template alias | Description
-------------------------|--------------------------------
[sag-db-oracle-103-and-lower](templates/sag-db-oracle-103-and-lower) | Creates a user, database, and webMethods database schemas on an Oracle database server. Use with Command Central 10.3 and lower.
[sag-db-oracle](templates/sag-db-oracle) | Creates a user, database, and webMethods database schemas on an Oracle database server. Use with Command Central 10.5 and higher.
[sag-db-sqlserver-103-and-lower](templates/sag-db-sqlserver-103-and-lower) | Creates a user, database, and webMethods database schemas on an SQL Server database server. Use with Command Central 10.3 and lower.
[sag-db-sqlserver](templates/sag-db-sqlserver) | Creates a user, database, and webMethods database schemas on an SQL Server database server. Use with Command Central 10.5 and higher.
[sag-db-sqlserver-is-schemas](templates/sag-db-sqlserver-is-schemas) | Creates a user, database, and Integration Server database schemas on an SQL Server database server. Use with Command Central 10.5 and higher.
[sag-db-mysql-103](templates/sag-db-mysql-103) | Creates a user, database, and webMethods database schemas on a MySQL Server. Use with Command Central 10.3.
[sag-db-mysql](templates/sag-db-mysql) | Creates a user, database, and webMethods database schemas on a MySQL Server. Use with Command Central 10.5 and higher.
[sag-db-db2](templates/sag-db-db2) | Creates a user and webMethods database schemas on a DB2 database server. Use with Command Central 10.5 and higher.

### Micro Templates for provisioning Software AG products

The following table lists all stable run-time micro templates for Software AG products.

Template alias | Provisions
-------------------------|--------------------------------
[sag-abe](templates/sag-abe) | Asset Build Environment
[sag-apama-correlator](templates/sag-apama-correlator) | Apama correlator instance
[sag-apigateway-cluster](templates/sag-apigateway-cluster) | API Gateway cluster
[sag-apigateway-server](templates/sag-apigateway-server) | API Gateway server
[sag-des-config](templates/sag-des-config) | Digital Event Services configuration
[sag-des](templates/sag-des) | Digital Event Services
[sag-designer-applatform](templates/sag-designer-applatform) | Designer and Application Platform
[sag-designer-cloudstreams](templates/sag-designer-cloudstreams) | Designer Cloudstreams Development
[sag-designer-services](templates/sag-designer-services) | Designer Service Development
[sag-exx-broker](templates/sag-exx-broker) | EntireX Broker
[sag-exx-c-rpc-server](templates/sag-exx-c-rpc-server) | EntireX C RPC server
[sag-exx-csl-rpc-server](templates/sag-exx-csl-rpc-server) | EntireX RPC Server for CICS Socket Listener
[sag-exx-ims-rpc-server](templates/sag-exx-ims-rpc-server) | EntireX RPC Server for IMS
[sag-exx-java-rpc-server](templates/sag-exx-java-rpc-server) | EntireX Java RPC server
[sag-exx-mf-broker](templates/sag-exx-mf-broker) | a proxy for an EntireX Mainframe Broker
[sag-exx-mq-rpc-server](templates/sag-exx-mq-rpc-server) | EntireX RPC Server for IBM MQ
[sag-exx-net-rpc-server](templates/sag-exx-net-rpc-server) | EntireX RPC Server for .NET
[sag-exx-xml-rpc-server](templates/sag-exx-xml-rpc-server) | EntireX XML RPC server
[sag-infradc](templates/sag-infradc) | Infrastructure Data Collector
[sag-internaldatastore](templates/sag-internaldatastore) | Internal Data Store
[sag-is-applatform](templates/sag-is-applatform) | Application Platform on Integration Server or Microservices runtime
[sag-is-cloudstreams](templates/sag-is-cloudstreams) | Cloudstreams on Integration Server or Microservices runtime
[sag-is-config](templates/sag-is-config) | webMethods Integration Server configurations
[sag-is-mft](templates/sag-is-mft) | ActiveTransfer Server / ActiveTransfer Gateway on Integration Server
[sag-is-server](templates/sag-is-server) | webMethods Integration Server instance
[sag-msc-server](templates/sag-msc-server) | webMethods Microservices Runtime
[sag-msc-server-103-and-lower](templates/sag-msc-server-103-and-lower) | webMethods Microservices Runtime for version 10.3 and lower
[sag-mws-applatform](templates/sag-mws-applatform) | Application Platform on My webMethods Server
[sag-mws-infradcui](templates/sag-mws-infradcui) | Infrastructure Data Collector web user interface on My webMethods Server
[sag-mws-mftui](templates/sag-mws-mftui) | ActiveTransfer web user interface
[sag-tc-cluster](templates/sag-tc-cluster) | Terracotta BigMemory cluster
[sag-tc-server](templates/sag-tc-server) | Terracotta BigMemory server
[sag-tdb-server](templates/sag-tdb-server) | Terracotta DB server

The following table lists micro templates that are still in the testing phase.

Template alias | Provisions
-------------------------|--------------------------------
[sag-is-cluster](templates/sag-is-cluster) | webMethods Integration Server stateless cluster
[sag-is-statefull-cluster](templates/sag-is-statefull-cluster) | webMethods Integration Server statefull cluster
[sag-mft-config](templates/sag-mft-config) | ActiveTransfer
[sag-mws-server](templates/sag-mws-server) | My webMethods Server
[sag-onedata](templates/sag-onedata) | OneData
[sag-optimize-wsdc](templates/sag-optimize-wsdc) | Optimize Web Service Data Collector
[sag-optimize-analysis](templates/sag-optimize-analysis) | Optimize Analytic Engine
[sag-um-cluster](templates/sag-um-cluster) | Universal Messaging cluster
[sag-um-cluster-migrate](templates/sag-um-cluster-migrate) | Migrates a Universal Messaging cluster
[sag-um-config](templates/sag-um-config) | Universal Messaging configuration
[sag-um-server](templates/sag-um-server) | Universal Messaging server
[sag-um-server-migrate](templates/sag-um-server-migrate) | Migrates a Universal Messaging server


### Micro Templates for configuring Command Central and Platform Manager

The following table lists all stable micro templates for configuring Command Central and Platform Manager.

Template alias | Description
-------------------------|--------------------------------
[sag-cc-builder-repos](templates/sag-cc-builder-repos) | Configures product and fix repositories for Docker builder
[sag-cc-creds-dev](templates/sag-cc-creds-dev) | Configures different types of credentials.
[sag-cc-creds](templates/sag-cc-creds) | Configures default outbound credentials for Command Central.
[sag-cc-layer-defs](templates/sag-cc-layer-defs) | Creates Software AG layer type definitions for Stacks API and UI
[sag-cc-ldap](templates/sag-cc-ldap) | Configures Command Central LDAP connection and sample users, groups and roles.
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
[integration-server](containers/integration-server) | webMethods Integration Server
[terracotta-server](containers/terracotta-server) | Terracotta BigMemory server
[universal-messaging](containers/universal-messaging) | Universal Messaging server
[microservices-runtime](containers/microservices-runtime) | webMethods Microservices runtime
