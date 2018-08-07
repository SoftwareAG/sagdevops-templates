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
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

FROM $BUILDER_IMAGE

ARG __exx_broker_instance_name=ETB002

RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

EXPOSE 7722 7723 8092

COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# entrypoint script
ADD entrypoint.sh $SAG_HOME/

WORKDIR $SAG_HOME
ENTRYPOINT $SAG_HOME/entrypoint.sh
