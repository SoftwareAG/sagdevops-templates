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

ARG CC_SERVER_IMAGE
ARG BASE_IMAGE

FROM $CC_SERVER_IMAGE as builder

ARG CC_INSTALLER
ARG CC_INSTALLER_URL

WORKDIR $CC_HOME

# provision managed node
RUN $CC_HOME/provision.sh

FROM $BASE_IMAGE

ARG RELEASE
ENV RELEASE=$RELEASE

ENV SAG_HOME=/opt/softwareag
ENV CC_SERVER=cc
ENV CC_PASSWORD=manage
ENV CC_CLI_HOME=$SAG_HOME/CommandCentral/client
ENV ANT_HOME=$SAG_HOME/common/lib/ant
ENV JAVA_HOME=$SAG_HOME/jvm/jvm
ENV PATH=$PATH:$CC_CLI_HOME/bin:$ANT_HOME/bin:$JAVA_HOME/bin
ENV CC_AUTO_REGISTER=1

# 3rd part tools
USER root
RUN yum install -y net-tools && yum clean all

WORKDIR $SAG_HOME

USER 1724

COPY --from=builder $SAG_HOME/ $SAG_HOME/
COPY --from=builder /opt/sagtools/register.sh $SAG_HOME/register.sh
COPY --from=builder /opt/sagtools/CommandCentral/client/ $SAG_HOME/CommandCentral/client/
COPY --from=builder /opt/sagtools/common/lib/ant/ $SAG_HOME/common/lib/ant/

EXPOSE 8092 8093

ADD entrypoint.sh $SAG_HOME/

# run time builder
ENTRYPOINT $SAG_HOME/entrypoint.sh
