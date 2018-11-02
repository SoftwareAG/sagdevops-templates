###############################################################################
#  Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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

ARG BASE_IMAGE
ARG NODE_IMAGE=store/softwareag/commandcentral-node:10.3
FROM $NODE_IMAGE as javasource
FROM $BASE_IMAGE as base

ENV SAG_HOME=/opt/softwareag
ENV JAVA_HOME=$SAG_HOME/jvm/jvm
ENV PATH=$PATH:$JAVA_HOME/bin

USER 1724

COPY --from=javasource --chown=1724:1724 $SAG_HOME/jvm/jvm/ $SAG_HOME/jvm/jvm/

RUN env && java -version

WORKDIR $SAG_HOME

ENTRYPOINT java
