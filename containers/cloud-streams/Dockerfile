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

# sag-is-server or sag-msc-server
ARG BASE_TEMPLATE=sag-msc-server

ARG __is_fixes=[]
ARG __cst_fixes=[]
ARG __is_instance_name=default
# has to match BASE_TEMPLATE: MSC for sag-msc-server | integrationServer for sag-is-server
ARG __is_instance_type=MSC

RUN $CC_HOME/provision.sh $BASE_TEMPLATE && \
    $CC_HOME/provision.sh sag-is-cloudstreams && \
    $CC_HOME/profiles/CCE/data/templates/composite/$BASE_TEMPLATE/test.sh && \
    $CC_HOME/profiles/CCE/data/templates/composite/sag-is-cloudstreams/test.sh && \
    $CC_HOME/cleanup.sh && \
    rm -rf $SAG_HOME/profiles/CTP

FROM $BASE_IMAGE

EXPOSE 5555 9999 8094 8092 8093

# copy everything from the builder stage $SAG_HOME
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

WORKDIR $SAG_HOME

# HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 CMD "curl -f localhost:8092/spm/ || exit 1"
