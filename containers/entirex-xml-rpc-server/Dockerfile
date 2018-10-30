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

ARG BUILDER_IMAGE
ARG BASE_IMAGE

FROM $BUILDER_IMAGE as builder

RUN $CC_HOME/provision.sh sag-exx-xml-rpc-server

FROM $BASE_IMAGE

# setting environment variables, can be overwritten during startup
ENV EXX_XML_SERVER_CONFIGURATION=entirex.xmlrpcserver.properties
ENV EXX_XML_SERVER_MAPPING=entirex.xmlrpcserver.configuration.xml
ENV EXX_LICENSE_KEY=license.xml

# set some environment variables
ENV SAG_HOME=/opt/softwareag
ENV EXXDIR=$SAG_HOME/EntireX

COPY --from=builder --chown=1724:1724 $SAG_HOME/common/lib/ $SAG_HOME/common/lib/
COPY --from=builder --chown=1724:1724 $SAG_HOME/WS-Stack/lib/ $SAG_HOME/WS-Stack/lib/
COPY --from=builder --chown=1724:1724 $EXXDIR/classes/entirex.jar $EXXDIR/classes/entirex.jar

RUN mkdir $EXXDIR/config

COPY --chown=1724:1724 entrypoint.sh $EXXDIR/bin/
USER sagadmin

WORKDIR $SAG_HOME

ENTRYPOINT $EXXDIR/bin/entrypoint.sh
