###############################################################################
#  Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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

# bootstrap node using CC bootstrapper 
ARG CC_INSTALLER
ARG CC_INSTALLER_URL

# TODO: is thi needed?
WORKDIR $CC_HOME

USER root
RUN mkdir $SAG_HOME && chown --recursive 1724:1724 $SAG_HOME 

USER 1724
# provision managed node and remove jvm/ since we base off ibit/java image
RUN $CC_HOME/provision.sh && rm -rf $SAG_HOME/jvm/


FROM $BASE_IMAGE as java

ENV CC_SERVER=cc
ENV CC_PASSWORD=manage
ENV CC_CLI_HOME=$SAG_HOME/CommandCentral/client
ENV JAVA_HOME=$SAG_HOME/jvm/jvm
ENV PATH=$PATH:$CC_CLI_HOME/bin:$JAVA_HOME/bin
ENV CC_AUTO_REGISTER=1

USER root
# 3rd part tools
RUN yum install -y net-tools && \
    yum clean all

WORKDIR $SAG_HOME
USER 1724

COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

EXPOSE 8092 8093


# run time builder
ENTRYPOINT $SAG_HOME/entrypoint.sh
