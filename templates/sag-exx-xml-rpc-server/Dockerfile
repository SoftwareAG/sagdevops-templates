###############################################################################
#  Copyright © 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
###############################################################################
ARG TAG=10.3
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG
ARG BASE_IMAGE=centos:7

FROM $BUILDER_IMAGE as builder

RUN $CC_HOME/provision.sh

FROM $BASE_IMAGE

RUN groupadd -g 1724 sagadmin && useradd -r -u 1724 sagadmin -g sagadmin -d /opt/softwareag -s /bin/bash -M

# setting environment variables, can be overwritten during startup
ENV EXX_XML_SERVER_CONFIGURATION=entirex.xmlrpcserver.properties
ENV EXX_XML_SERVER_MAPPING=entirex.xmlrpcserver.configuration.xml
ENV EXX_LICENSE_KEY=license.xml

# setting internal environment variables
ENV SAG_HOME=/opt/softwareag
ENV EXXDIR=$SAG_HOME/EntireX
ENV JAVA_HOME=$SAG_HOME/jvm/jvm

COPY --from=builder --chown=1724:1724 $EXXDIR/config/license.xml $EXXDIR/config/license.xml
COPY --from=builder --chown=1724:1724 $SAG_HOME/common/lib/saglic.jar $SAG_HOME/common/lib/saglic.jar
COPY --from=builder --chown=1724:1724 $SAG_HOME/jvm/ $SAG_HOME/jvm/
COPY --from=builder --chown=1724:1724 $EXXDIR/classes/entirex.jar $EXXDIR/classes/entirex.jar

ADD --chown=1724:1724 entrypoint.sh $EXXDIR/bin/

USER sagadmin

WORKDIR $SAG_HOME

ENTRYPOINT $EXXDIR/bin/entrypoint.sh