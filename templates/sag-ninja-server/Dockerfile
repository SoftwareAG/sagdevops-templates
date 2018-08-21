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
# Use $TAG to control release
ARG TAG=10.3
# Use $BUILDER_IMAGE to control repo, e.g. private/public
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG

# Target image base image
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

FROM $BUILDER_IMAGE as builder

ARG __ninja_mem_max=256

RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

EXPOSE 4444 4445 4446 4447 8092 8093

# copy everything as is from the builder stage
COPY --from=builder $SAG_HOME/ $SAG_HOME/

# basic entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh
