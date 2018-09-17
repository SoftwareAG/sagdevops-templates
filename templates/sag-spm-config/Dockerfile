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

FROM $BUILDER_IMAGE as builder

# build arg for hello.name template parameter
ARG __hello_world=default
# runtime container init parameter
ENV HELLO_NAME=default

# Apply template.yaml with env.properties and run smoke tests
RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

# Target image
FROM $BASE_IMAGE

# expose any ports from runtimes defined in the template.yaml
EXPOSE 8092 8093

COPY --from=builder $SAG_HOME $SAG_HOME

# entrypoint scripts
ADD entrypoint.sh $SAG_HOME

ENTRYPOINT $SAG_HOME/entrypoint.sh
